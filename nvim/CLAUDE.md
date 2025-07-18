# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Testing and Validation

- Test configuration changes: `./test_config.sh`
- The test script validates basic startup, configuration loading, plugin functionality, and error detection
- Always run tests after making configuration changes to ensure Neovim starts properly

## Configuration Architecture

This is a modern Neovim configuration using Lua with a modular, thematic structure:

### Core Structure
- `init.lua` - Entry point that sets leader key and loads all thematic modules
- Organized into thematic packages: `core`, `ui`, `editor`, `files`, `lsp`, `system`
- Each package has its own `init.lua` that loads its components
- Global keymaps in root `lua/keymaps.lua`

### Thematic Package Organization

```
lua/
├── core/           # Core Neovim functionality
│   ├── init.lua    # Bootstrap mini.nvim & load core components
│   ├── options.lua # Core vim settings (indentation, search, UI)
│   └── autocmds.lua # Autocommands & project root detection
├── ui/             # Visual and interface elements
│   ├── plugins.lua # Themes, statusline, colorizer
│   ├── keymaps.lua # UI debugging keymaps
│   └── number-toggle.lua # Number line toggle functionality
├── editor/         # Text editing and manipulation
│   ├── plugins.lua # Treesitter, text objects, editing tools
│   ├── keymaps.lua # Text object & editing keymaps
│   └── text-objects.lua # Custom text object functions
├── files/          # File management and search
│   ├── plugins.lua # Telescope, file browser
│   ├── keymaps.lua # File/search mappings
│   └── project_telescope.lua # Telescope project functions
├── lsp/            # Language Server Protocol
│   ├── plugins.lua # LSP, mason plugins
│   ├── config.lua  # LSP setup and handlers
│   └── keymaps.lua # LSP-specific keymaps
├── system/         # System integration
│   ├── plugins.lua # Git, tmux, oscyank
│   ├── keymaps.lua # System integration mappings
│   └── quickfix.lua # Quickfix management functions
└── keymaps.lua     # Global/core keymaps only
```

### Plugin Management
Uses mini.deps (from mini.nvim) as the plugin manager. The configuration bootstraps mini.nvim from a custom fork at `joshuaMarple/mini.nvim`.

Key plugin categories:
- **LSP**: Mason, mason-lspconfig, nvim-lspconfig for language server support
- **Completion**: mini.completion with LSP integration
- **Fuzzy Finding**: Telescope for files, buffers, grep, git status, file browser
- **Text Objects**: Treesitter, various-textobjs, custom text objects
- **UI**: Custom statusline (dotline.nvim), galaxyline, colorschemes, mini.icons
- **Git**: diffconflicts for merge resolution
- **System Integration**: tmux-navigator, oscyank for clipboard

### Key Mappings Architecture
- Leader key: `<Space>`
- Telescope mappings use `<leader>` prefix for most file/search operations
- Window navigation uses `<C-h/j/k/l>`
- Quickfix navigation uses `<C-n/p>` and `<A-c/S-c>`
- LSP mappings are configured in `lsp/config.lua` setup function
- Keymaps are organized thematically alongside their related functionality

### Project Root Detection
Uses built-in project root detection with caching in `core/autocmds.lua`. The `b:projectroot` variable is available in all buffers and used by grep operations and file finders. Searches for `.git`, `package.json`, `Cargo.toml`, `go.mod` markers.

### Legacy VimScript Integration
Loads `~/.config/nvim/work.vim` for any legacy VimScript configuration that hasn't been migrated to Lua.

## Custom Functions and Features

### Search and Grep
- Uses ripgrep (`rg`) when available for faster searching
- Project-scoped grep operations using cached `b:projectroot`
- Telescope integration for live grep and file finding
- Project-specific telescope functions in `files/project_telescope.lua`

### Text Objects
- Custom "last change" text objects (`ik`, `ak`) in `editor/keymaps.lua`
- Treesitter text objects for functions, classes, blocks, comments
- Number text objects (`iN`) for selecting numeric values in `editor/text-objects.lua`

### Completion
- mini.completion with LSP integration and automatic import resolution
- Configured in `core/init.lua` as part of mini.nvim setup

### Quickfix Management
- Toggle and refresh functionality in `system/quickfix.lua`
- Keymaps for navigation and management in `system/keymaps.lua`

## Development Workflow

### Plugin Updates
- Update plugins: `<leader>rp` (calls `require('mini.deps').update()`)
- Plugin installation is handled automatically by mini.deps

### Configuration Reloading
- Reload configuration: `<leader>rc`
- Edit init file: `<leader>ev`
- Reload current file: `<leader>rr`

### File Management
- Project file finding: `<leader>fp`
- Buffer switching: `<leader>b` or `,,`
- File browser: `<leader>ff` (Telescope file browser)
- Recent files: `<leader>h`

### Finding Configuration
When looking for specific settings:
- **Core vim options**: `core/options.lua`
- **Autocommands**: `core/autocmds.lua`
- **LSP configuration**: `lsp/config.lua`
- **Plugin definitions**: `{package}/plugins.lua`
- **Keymaps**: `{package}/keymaps.lua` or global `keymaps.lua`
- **Custom functions**: Named files like `quickfix.lua`, `text-objects.lua`

This configuration prioritizes maintainability and clear organization while maintaining extensive functionality through carefully chosen plugins and custom Lua functions organized by logical themes.