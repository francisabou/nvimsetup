return({
  'lervag/vimtex',
    ft = 'tex',
    config = function()
      -- Make sure "out/" exists anytime main.tex is entered/loaded
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'BufEnter' }, {
        -- Match any file whose name ends with "main.tex"
        pattern = { '*main.tex' },
        callback = function(args)
          local bufnr   = args.buf
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          -- Get the directory containing main.tex:
          local dir = vim.fn.fnamemodify(bufname, ':p:h')
          -- Full path to "out" under that directory:
          local outdir = dir .. '/out'

          -- Create "out/" (and parents) if necessary:
          if vim.fn.isdirectory(outdir) == 0 then
            vim.fn.mkdir(outdir, 'p')
          end

          -- Tell VimTeX that this buffer (main.tex) is the root file:
          vim.b[bufnr].vimtex_root = bufname
        end,
      })
    end
})
