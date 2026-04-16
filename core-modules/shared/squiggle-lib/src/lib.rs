use std::io::Cursor;
use serde::Serialize;


#[derive(Serialize)]
struct SquiggleOutput {
    x: Vec<f64>,
    y: Vec<f64>,
}


pub fn squiggle_transform(fasta_data: &[u8], out_buf: &mut [u8]) -> usize {
    let fasta_str = std::str::from_utf8(fasta_data).unwrap_or("");

    // Pre-allocate to avoid slow vector resizing during computation.
    // 2 points per nucleotide + 1 start point.
    let estimated_capacity = fasta_str.len() * 2;
    let mut x_coords = Vec::with_capacity(estimated_capacity);
    let mut y_coords = Vec::with_capacity(estimated_capacity);

    let mut cur_x = 0.0;
    let mut cur_y = 0.0;

    x_coords.push(cur_x);
    y_coords.push(cur_y);

    // Squiggle algorithm loop.
    for line in fasta_str.lines() {
        // Ignore FASTA headers.
        if line.starts_with('>') { continue; }

        for b in line.bytes() {
            match b {
                b'A' | b'a' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                    cur_x += 1.0;               // cur_y += 0.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'C' | b'c' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                    cur_x += 1.0;               // cur_y += 0.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'G' | b'g' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y + 0.5);
                    cur_x += 1.0;               cur_y += 1.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                b'T' | b't' | b'U' | b'u' => {
                    x_coords.push(cur_x + 0.5); y_coords.push(cur_y - 0.5);
                    cur_x += 1.0;               cur_y -= 1.0;
                    x_coords.push(cur_x);       y_coords.push(cur_y);
                }
                _ => {} // Ignore whitespace, 'N', or unrecognized characters.
            }
        }
    }

    let result = SquiggleOutput { x: x_coords, y: y_coords };

    // Use a Cursor to serialize directly into the pre-allocated slice.
    let mut cursor = Cursor::new(out_buf);
    match serde_json::to_writer(&mut cursor, &result) {
        Ok(_) => cursor.position() as usize,
        Err(_) => 0,
    }
}
