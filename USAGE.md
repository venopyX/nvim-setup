# Neovim Professional Setup - Complete Usage Guide

A comprehensive guide for your modern Neovim development environment, organized for both beginners and advanced users.

## Table of Contents

- [Core Concepts](#core-concepts)
- [Getting Started](#getting-started)
- [Basic Navigation](#basic-navigation)
- [Development Features](#development-features)
- [Text Manipulation](#text-manipulation)
- [Motion Commands](#motion-commands)
- [Code Navigation](#code-navigation)
- [Text Objects](#text-objects)
- [Git Integration](#git-integration)
- [Search and Replace](#search-and-replace)
- [Buffer Management](#buffer-management)
- [Window Management](#window-management)
- [Tab Management](#tab-management)
- [Terminal Integration](#terminal-integration)
- [Code Folding](#code-folding)
- [Language Support](#language-support)
- [Debugging](#debugging)
- [Registers and Marks](#registers-and-marks)
- [Macros](#macros)
- [Telescope Features](#telescope-features)
- [UI Features](#ui-features)
- [Advanced Features](#advanced-features)
- [Tips for Efficiency](#tips-for-efficiency)
- [Common Workflows](#common-workflows)
- [Performance Tips](#performance-tips)
- [Visual Guide](#visual-guide)

## Core Concepts

- **Leader Key**: Space - Primary prefix for commands
- **Local Leader**: `,` - Secondary prefix for filetype-specific commands
- **Hunk**: A section of code changes in version control
- **LSP**: Language Server Protocol for code intelligence
- **Buffer**: A file loaded into memory for editing
- **Text Objects**: Code structures like words, paragraphs, functions
- **Fuzzy Finding**: Smart pattern-based search
- **Marks**: Named positions in code for quick navigation
- **Registers**: Named storage for text and commands

## Getting Started

### Modes
- **Normal** (default): Command mode
- **Insert** (`i`): Text editing mode
- **Visual** (`v`): Text selection mode
- **Visual Line** (`V`): Line selection mode
- **Visual Block** (`<C-v>`): Block selection mode
- **Command** (`:`): Command entry mode
- **Terminal**: Integrated terminal mode

## Basic Navigation

### File Navigation
- `<leader>e`: Toggle file explorer (NvimTree)
- `<leader>ff`: Find files (Telescope)
- `<leader>fg`: Live grep in files
- `<leader>fb`: Browse open buffers
- `<leader>fo`: Browse recent files
- `gf`: Go to file under cursor

### Basic Movement
- `h/j/k/l`: Left/down/up/right
- `w/b`: Next/previous word
- `e`: End of word
- `0/$`: Start/end of line
- `gg/G`: Start/end of file

## Development Features

### LSP Features
- `gd`: Go to definition
- `gD`: Go to declaration
- `gr`: Find references
- `gi`: Go to implementation
- `K`: Show documentation
- `<leader>ca`: Code actions
- `<leader>rn`: Rename symbol
- `<leader>f`: Format code

### Diagnostics
- `[d/]d`: Previous/next diagnostic
- `<leader>d`: Show diagnostic details
- `<leader>xx`: Toggle trouble list
- `<leader>xw`: Workspace diagnostics
- `<leader>xd`: Document diagnostics

### Auto-completion
- `<Tab>`: Next suggestion
- `<S-Tab>`: Previous suggestion
- `<CR>`: Confirm selection
- `<C-Space>`: Trigger completion
- `<C-e>`: Close completion

## Git Integration (via Gitsigns)

### Basic Git Operations
- `<leader>gs`: Stage hunk
- `<leader>gr`: Reset hunk
- `<leader>gS`: Stage buffer
- `<leader>gu`: Undo stage hunk
- `<leader>gp`: Preview changes
- `<leader>gb`: Show blame
- `<leader>gd`: Show diff

### Advanced Git
- `<leader>tb`: Toggle line blame
- `<leader>td`: Toggle deleted
- `]c/[c`: Next/previous hunk

## Advanced Features

### Zen Mode and Focus
- `<leader>z`: Toggle zen mode
- `<leader>hw`: Hop word
- `<leader>hl`: Hop line
- `<leader>hc`: Hop char

### Mini.nvim Features
- `ga`: Align text (normal and visual mode)
- Smart pairs auto-completion
- Enhanced text objects

### Session Management
- `<leader>qs`: Restore session
- `<leader>ql`: Load last session
- `<leader>qd`: Don't save session

### Symbols and Structure
- `<leader>so`: Toggle symbols outline
- Browse code structure
- Quick symbol navigation

### UFO Folding
- `zR`: Open all folds
- `zM`: Close all folds
- `K`: Peek fold content
- `zr/zm`: Decrease/increase fold level

### Clipboard Management
- `<leader>fc`: Show clipboard history
- Persistent clipboard across sessions
- Multiple register support

### Debug Features
- `<leader>db`: Toggle breakpoint
- `<leader>dc`: Continue/start debug
- `<leader>di`: Step into
- `<leader>do`: Step over
- `<leader>dO`: Step out
- `<leader>dr`: Open REPL
- `<leader>du`: Toggle debug UI

## Language-Specific Features

### Go Development
- `<leader>gt`: Run tests
- `<leader>gtf`: Test function
- `<leader>gr`: Run file
- `<leader>gi`: Import
- `<leader>gfs`: Fill struct

### TypeScript/JavaScript
- `<leader>tso`: Organize imports
- `<leader>tsr`: Rename file
- `<leader>tsi`: Add missing imports
- `<leader>tsf`: Fix all issues

### Python
- Automatic formatting (black)
- Type checking (pyright)
- Debug support
- Test runner integration

## UI Features

### Modern UI Elements
- Floating windows
- Icon support
- Git decorations
- Diagnostic signs
- Completion documentation
- Status line information

### Notifications
- Error messages
- LSP status
- Git status
- Process completion
- Debug information

### Custom Status Line
- File information
- Git status
- LSP status
- File type
- Position information

## Performance Features

### Lazy Loading
- On-demand plugin loading
- Event-based activation
- Command-based loading
- Filetype-based loading

### Treesitter Integration
- Syntax highlighting
- Code folding
- Text objects
- Incremental selection

## Visual Guide

- `<C-x>`: Control + x
- `<M-x>`: Alt + x
- `<S-x>`: Shift + x
- `<leader>`: Space
- `<CR>`: Enter
- `<BS>`: Backspace

## Tips for Success

1. Learn progressively
2. Use which-key for command discovery
3. Practice text objects
4. Master the LSP features
5. Utilize fuzzy finding
6. Learn to combine commands
7. Use macros for repetitive tasks
8. Leverage registers
9. Master window management
10. Keep plugins updated

## Common Workflows

### Code Navigation
1. File finding: `<leader>ff`
2. Symbol search: `<leader>fs`
3. Reference finding: `gr`
4. Definition jumping: `gd`

### Code Editing
1. Format: `<leader>f`
2. Actions: `<leader>ca`
3. Rename: `<leader>rn`
4. Fix imports: Language-specific commands

### Git Operations
1. Stage: `<leader>gs`
2. Preview: `<leader>gp`
3. Blame: `<leader>gb`
4. Diff: `<leader>gd`

### Debug Workflow
1. Set breakpoint: `<leader>db`
2. Start/continue: `<leader>dc`
3. Step through: `<leader>di/do/dO`
4. Monitor variables: Debug UI

## Performance Tips

1. Keep plugins minimal
2. Use lazy loading
3. Configure updatetime
4. Clean unused plugins
5. Regular updates
6. Profile when slow
7. Use LSP efficiently
8. Optimize file watching
9. Configure treesitter
10. Monitor startup time
