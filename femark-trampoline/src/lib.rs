use wasmtime::component::Linker;
use wasmtime_state::States;
use bindings::docs::femark_trampoline::hosted::{HtmlOutput, HighlightError, OwnedFrontmatter, OwnedCodeBlock};

mod bindings {
    wasmtime::component::bindgen!({
        path: "/home/sergiyivan/work/mosaic/system/femark-trampoline/wit/world.wit",
        world: "femark-trampoline",
        async: false
    });
}


#[unsafe(no_mangle)]
pub fn register_imports(
    linker: &mut Linker<States>,
) -> Result<(), Box<dyn std::error::Error>> {
    println!("Registering femark imports");
    
    let mut hosted = linker.instance("docs:femark-app/hosted@0.1.0")?;
    
    hosted.func_wrap(
        "process-markdown-to-html",
        |_store, (input,): (String,)| { // : wasmtime::StoreContextMut<'_, States>
            Ok((process_markdown_to_html(input),))
        },
    )?;

    hosted.func_wrap(
        "process-markdown-to-html-with-frontmatter",
        |_store, (input, extract_frontmatter): (String, bool)| { // : wasmtime::StoreContextMut<'_, States>
            Ok((process_markdown_to_html_with_frontmatter(input, extract_frontmatter),))
        },
    )?;

    println!("Femark imports registered");
    Ok(())
}


fn process_markdown_to_html(
    input: String,
) -> Result<HtmlOutput, HighlightError> {
    process_markdown_to_html_with_frontmatter(input, false)
}

fn process_markdown_to_html_with_frontmatter(
    input: String,
    extract_frontmatter: bool,
) -> Result<HtmlOutput, HighlightError> {
    let res = femark::process_markdown_to_html_with_frontmatter(&input, extract_frontmatter);

    match res {
        Ok(output) => Ok(HtmlOutput {
            toc: output.toc,
            content: output.content,
            frontmatter: output.frontmatter.map(|fm| OwnedFrontmatter {
                title: fm.title,
                code_block: fm.code_block.map(|cb| OwnedCodeBlock {
                    language: cb.language,
                    source: cb.source,
                }),
            }),
        }),
        Err(e) => Err(match e {
            femark::HighlightError::NoLang => HighlightError::NoLang,
            femark::HighlightError::NoHighlighter => HighlightError::NoHighlighter,
            femark::HighlightError::CouldNotBuildHighlighter(s) => {
                HighlightError::CouldNotBuildHighlighter(s)
            }
            femark::HighlightError::StringGenerationError(s) => {
                HighlightError::StringGenerationError(s)
            }
        }),
    }
}
