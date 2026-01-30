# jcl.nvim

Neovim syntax highlighting for IBM MVS JCL files.

- Detects `*.jcl` / `*.JCL`
- Sets `filetype=jcl`
- Provides JCL syntax highlighting (ported from a classic Vim syntax file by Fiorenzo Zanotti; minor fixes applied)

## Install (lazy.nvim)

```lua
-- lua/plugins/jcl.lua (example)
return {
  {
    "drunyd/jcl.nvim",
    -- Smallest/simplest: just load on startup so ftdetect is available.
    lazy = false,

    -- Alternatively, you can lazy-load on patterns too:
    -- event = { "BufReadPre *.jcl", "BufNewFile *.jcl" },
  },
}
