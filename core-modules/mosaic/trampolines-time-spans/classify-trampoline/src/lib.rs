use std::io::Cursor;
use image::imageops::FilterType;
use tract_onnx::prelude::*;


#[unsafe(no_mangle)]
pub unsafe extern "C" fn trampoline_dispatch(
    func_name_ptr: *const u8,
    func_name_len: usize,
    mem_base: *mut u8,
    mem_len: usize,
    args_ptr: *const u64,
    args_len: usize,
    ret_ptr: *mut u64,
) -> bool {
    unsafe {
        let func_name_slice = std::slice::from_raw_parts(func_name_ptr, func_name_len);
        let func_name = std::str::from_utf8(func_name_slice).unwrap_or("");
        let args = std::slice::from_raw_parts(args_ptr, args_len);

        match func_name {
            "host_infer" => {
                if args.len() != 4 { return false; }
                let model_ptr = args[0] as usize;
                let model_len = args[1] as usize;
                let img_ptr = args[2] as usize;
                let img_len = args[3] as usize;

                if model_ptr + model_len > mem_len || img_ptr + img_len > mem_len { return false; }

                let model_slice = std::slice::from_raw_parts(mem_base.add(model_ptr), model_len);
                let img_slice = std::slice::from_raw_parts(mem_base.add(img_ptr), img_len);

                let mut cursor = Cursor::new(model_slice);
                let model = match tract_onnx::onnx()
                    .model_for_read(&mut cursor).unwrap()
                    .into_optimized().unwrap()
                    .into_runnable() {
                        Ok(m) => m,
                        Err(_) => { *ret_ptr = 0; return true; }
                };

                let img = match image::load_from_memory(img_slice) {
                    Ok(i) => i.to_rgb8(),
                    Err(_) => { *ret_ptr = 0; return true; }
                };

                let resized = image::imageops::resize(&img, 256, 256, FilterType::Triangle);
                let crop_x = (256 - 224) / 2;
                let crop_y = (256 - 224) / 2;
                let cropped = image::imageops::crop_imm(&resized, crop_x, crop_y, 224, 224).to_image();

                let mut tensor = tract_ndarray::Array4::<f32>::zeros((1, 3, 224, 224));
                let mean = [0.485, 0.456, 0.406];
                let std = [0.229, 0.224, 0.225];

                for (x, y, pixel) in cropped.enumerate_pixels() {
                    for c in 0..3 {
                        tensor[[0, c, y as usize, x as usize]] = (pixel[c] as f32 / 255.0 - mean[c]) / std[c];
                    }
                }

                let tract_tensor = tensor.into_tensor();
                let result = match model.run(tvec!(tract_tensor.into())) {
                    Ok(r) => r,
                    Err(_) => { *ret_ptr = 0; return true; }
                };

                let logits = result[0].to_array_view::<f32>().unwrap();

                let mut max_idx = 0;
                let mut max_val = logits[[0, 0]];

                for i in 0..1000 {
                    let val = logits[[0, i]];
                    if val > max_val {
                        max_val = val;
                        max_idx = i;
                    }
                }

                *ret_ptr = max_idx as u64;
                true
            }
            _ => false, // Unknown function requested.
        }
    }
}
