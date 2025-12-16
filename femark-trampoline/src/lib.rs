use std::any::Any;


pub struct FemarkHostImpl;

impl FemarkAppWorldImports for FemarkHostImpl {
    #[unsafe(no_mangle)]
    fn process_markdown_to_html(
        &mut self,
        input: wasmtime::component::__internal::String,
    ) -> Result<HtmlOutput, HighlightError> {
        self.process_markdown_to_html_with_frontmatter(input, false)
    }

    #[unsafe(no_mangle)]
    fn process_markdown_to_html_with_frontmatter(
        &mut self,
        input: wasmtime::component::__internal::String,
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
}
