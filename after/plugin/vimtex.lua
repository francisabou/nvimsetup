-- Use latexmk as the compiler
vim.g.vimtex_compiler_method     = 'latexmk'

-- Enable continuous compilation on save
vim.g.vimtex_compiler_continuous = 1

-- Set your PDF viewer (e.g. 'zathura', 'skim', 'okular', etc.)
vim.g.vimtex_view_method         = 'skim'

-- Force latexmk to hand pdflatex the “-output-directory=out” flag.
-- That way **all** files (PDF + aux) go into “out/”.
vim.g.vimtex_compiler_latexmk = {
  options = { '-pdf', '-interaction=nonstopmode', '-output-directory=out' }
}
