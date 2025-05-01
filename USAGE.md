# Neovim Professional Setup Usage Guide

## Core Concepts

- **Leader Key**: A special key (Space in this setup) that triggers custom commands, like a prefix key for shortcuts
- **Hunk**: A section of code changes in version control (additions, deletions, or modifications)
- **LSP**: Language Server Protocol - provides code intelligence like autocomplete and error checking
- **Buffer**: A file loaded into memory for editing (can be saved or unsaved)
- **Terminal Mode**: Neovim's built-in terminal emulator for running commands
- **Fuzzy Finding**: Quick search that matches patterns, not exact text

## Basic Navigation

### Leader Keys
- Space (Leader): Main prefix key for custom commands
- `,` (LocalLeader): Secondary prefix for filetype-specific commands

### Window Management
- `<C-h/j/k/l>`: Move between windows (C means Ctrl key) - like arrows but with hjkl
- `<C-Up/Down/Left/Right>`: Make current window bigger/smaller
- `<leader>w`: Save current file (Space + w)
- `<leader>q`: Close current window
- `<leader>c`: Close current buffer but keep window

### File Navigation
- `<leader>e`: Show/hide file tree on the left
- `<S-h/l>`: Switch to previous/next file (S means Shift)
- `<leader>ff`: Open file search (like Ctrl+P in other editors)
- `<leader>fg`: Search text in all files (like global search)
- `<leader>fb`: List all open files
- `<leader>fo`: Show recently opened files

## Development Features

### Code Navigation
- `gd`: Jump to where symbol is defined
- `gD`: Jump to where symbol is declared
- `gr`: Show all places where symbol is used
- `gi`: Jump to where symbol is implemented
- `K`: Show documentation for symbol under cursor
- `<C-k>`: Show function signature while typing

### Code Actions
- `<leader>ca`: Show available code actions (like quick fixes)
- `<leader>rn`: Change name of symbol everywhere
- `<leader>f`: Fix code formatting
- `<leader>D`: Show full type information

### Diagnostics
- `[d/]d`: Go to previous/next error or warning
- `<leader>d`: Show error details in floating window
- `<leader>xx`: Open problems panel (like VS Code)
- `<leader>xw`: Show all problems in project
- `<leader>xd`: Show problems in current file

## Git Integration

### Git Operations
- `<leader>gs`: Mark current changes for commit
- `<leader>gr`: Undo changes in current section
- `<leader>gb`: Show who wrote each line
- `<leader>gp`: Preview changes before saving

### Git Navigation
- `<leader>gc`: Browse through commits
- `<leader>gb`: Switch between branches
- `<leader>gs`: See changed files

## Language Support

### Go Development
- `<leader>gt`: Run all tests
- `<leader>gtf`: Run test under cursor
- `<leader>gr`: Run current file
- `<leader>gi`: Add missing imports
- `<leader>gfs`: Automatically fill struct fields

### TypeScript/JavaScript
- `<leader>tso`: Sort and clean up imports
- `<leader>tsr`: Safely rename file and update imports
- `<leader>tsi`: Find and add missing imports
- `<leader>tsf`: Fix common problems automatically

## Debugging

### Debug Controls
- `<leader>db`: Add/remove stopping point
- `<leader>dc`: Run until next stopping point
- `<leader>di`: Execute current line and stop at next line
- `<leader>do`: Skip current function but stop after
- `<leader>dO`: Finish current function and stop after
- `<leader>dr`: Open debug console
- `<leader>du`: Show/hide debug information

## Productivity Features

### Search and Replace
- `<leader>fw`: Find all occurrences of word under cursor
- `<leader>fs`: List all functions and classes in file
- `<leader>fh`: Search through Neovim help pages

### Code Folding
- `zR`: Show all code that was hidden
- `zM`: Hide all code that can be folded
- `za`: Toggle hide/show current section

### Focus Mode
- `<leader>z`: Hide UI elements for focus
- `<leader>hw`: Jump to any word visible on screen
- `<leader>hl`: Jump to any line visible on screen
- `<leader>hc`: Jump to any character visible on screen

### Session Management
- `<leader>qs`: Load previously saved workspace
- `<leader>ql`: Return to last saved workspace
- `<leader>qd`: Don't save current workspace

## Quick Tips

1. Press Space (leader) and wait to see available commands
2. Use `<leader>ff` to quickly find files (like Ctrl+P)
3. Use `<leader>fg` to search text in all files
4. Use `<leader>fc` to see copy/paste history
5. Use Harpoon for frequently used files:
   - `<leader>ha`: Bookmark current file
   - `<leader>hm`: View bookmarked files
   - `<leader>h1-4`: Jump to bookmarked file 1-4

## Project Features

1. Automatic language support for:
   - Go: Smart completion and formatting
   - TypeScript: Code fixes and organizing
   - Python: Type checking and suggestions
   - Lua: Neovim-aware completion
   - Rust: Advanced type support

2. Auto-formatting when saving:
   - Go: Using gofmt rules
   - Lua: Using stylua
   - Python: Using black rules
   - JS/TS: Using prettier rules

## Additional Features

- `<leader>fc`: View and restore previous copies (clipboard history)
- Tab: Trigger code snippets and completions
- Auto-pairs: () [] {} automatically close
- Infinite undo: Never lose changes
- Project settings: Custom rules per project
- Git blame: See commit info inline
- Modern UI: Notifications and status info

## Terminal Integration

In terminal window:
- `<Esc>` or `jk`: Switch back to normal mode
- `<C-h/j/k/l>`: Move between terminal and editor
- `<C-w>`: Terminal window management

## Visual Guide

- `<C->`: Means hold Ctrl key
- `<S->`: Means hold Shift key
- `<leader>`: Means press Space key
- `<CR>`: Means press Enter key
- `<A->`: Means hold Alt key
