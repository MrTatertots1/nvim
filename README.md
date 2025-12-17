# Neovim Configuration

Personal Neovim configuration built around **lazy.nvim**, optimized for .NET / C# development with **omnisharp-roslyn**.

---

## ✨ Features
- **Plugin Management**: Uses [lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin loading and management.
- **Fuzzy finding**: Integrated [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for powerful file and content searching.
- **LSP support**
    - Omnisharp-roslyn for C# language server support.
- **Debugging**: Configured with [nvim-dap](https://github.com/mfussenegger/nvim-dap) for debugging capabilities.
- **Code folding**: with [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo) for better code navigation.
- **Syntax highlighting**: Powered by [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) for enhanced syntax awareness.
    - **Comment Highlighting**: Using [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) to highlight TODOs and FIXMEs.
- **AI Assistance**: Integrated with [copilot.vim](https://github.com/github/copilot.vim) for AI-powered code suggestions.
- **Git Integration**: Using
    - [vim-fugitive](https://github.com/tpope/vim-fugitive) for Git commands within Neovim.
    - [diffview.nvim](https://github.com/sindrets/diffview.nvim) for visualizing Git diffs.
    - [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) for Git signs in the gutter.
    - [octo.nvim](https://github.com/pwntester/octo.nvim) for GitHub integration.
- **Smart window management**
- **Which-key** for keybinding hints.
- **Statusline**: Customized with [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim).
- **Enhanced UI feedback** (fidget, better messages)
- **Markdown Preview**: Using [markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) for live markdown preview.

---

## 📦 Requirements

- **Neovim**: Version 0.11.5 or higher.
- Git
- Node.js (for some plugins)
- Nerd Font (for icons)
    - [Download Nerd Fonts](https://www.nerdfonts.com/font-downloads)
        - Personal Preference: FiraCode Nerd Font

Optional (mostly language specific):
- ripgrep for telescope live grep
    - [Ripgrep GitHub](https://github.com/BurntSushi/ripgrep)
- .NET SDK (for C# development)
    - [Download .NET SDK](https://dotnet.microsoft.com/en-us/download)
- omnisharp-roslyn (C# language server)
    - [Omnisharp-Roslyn GitHub](https://github.com/OmniSharp/omnisharp-roslyn) *Note: Mason will install this automatically if not found*

## 🚀 Installation
### Install Neovim
- Follow the instructions here [Neovim GitHub Releases](https://github.com/neovim/neovim/releases)
    - Easiest on Linux is the AppImage

### Clone this repository
```bash
git clone <repository_url> ~/.config/nvim
```
