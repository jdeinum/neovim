# Neovim Configuration

I like my editor to be simple and powerful.

## Using the Config

Move `init.lua` to `~/.config/nvim/init.lua` and open Neovim. Lazy should install all of the plugins on the first boot.

Note: I am using neovim `0.11.0`. I have not tested this on older builds.

---

# Keybinds Reference

## Leader Keys
- `<leader>` = Space
- `<localleader>` = ;

## Base Vim/Neovim Functionality

### Macros
- `q{register}` - Start recording macro to register (e.g., `qa` records to register 'a')
- `q` - Stop recording macro
- `@{register}` - Execute macro from register (e.g., `@a` plays macro from register 'a')
- `@@` - Repeat last executed macro
- `{count}@{register}` - Execute macro N times (e.g., `10@a`)

### Registers
- `"{register}` - Use specific register for next delete/yank/put (e.g., `"ayy` yanks to register 'a')
- `"0` - Last yank register (doesn't change with deletes)
- `"1-9` - Numbered registers (deletion history)
- `"a-z` - Named registers (lowercase = replace, uppercase = append)
- `"+` - System clipboard (copy/paste with OS)
- `"*` - Selection clipboard (X11 primary selection)
- `".` - Last inserted text
- `":` - Last command
- `"/` - Last search pattern
- `:reg` - View all registers
- `<C-r>{register}` - Insert register contents (insert/command mode)

### Marks
- `m{a-z}` - Set local mark (file-specific)
- `m{A-Z}` - Set global mark (across files)
- `'{mark}` - Jump to mark's line (first non-blank character)
- `` `{mark} `` - Jump to mark's exact position (line and column)
- `''` - Jump to position before last jump
- `` `` `` - Jump to last edit position
- `:marks` - View all marks
- `:delmarks {marks}` - Delete specific marks

### Visual Modes
- `v` - Character-wise visual mode
- `V` - Line-wise visual mode
- `<C-v>` - Block-wise visual mode
- `gv` - Reselect last visual selection
- `o` - Move to other end of selection (in visual mode)

### Text Objects
Use with operators (`d`, `c`, `y`, `v`, etc.):
- `iw` / `aw` - Inner word / a word
- `iW` / `aW` - Inner WORD / a WORD (space-delimited)
- `is` / `as` - Inner sentence / a sentence
- `ip` / `ap` - Inner paragraph / a paragraph
- `i"` / `a"` - Inner quotes / a quotes (also works with `'`, `` ` ``)
- `i(` / `a(` - Inner parentheses / a parentheses (also works with `[`, `{`, `<`)
- `it` / `at` - Inner tag / a tag (HTML/XML)
- `i>` / `a>` - Inner angle brackets / a angle brackets

### Operators
Combine with motions or text objects:
- `d` - Delete
- `c` - Change (delete and enter insert mode)
- `y` - Yank (copy)
- `>` - Indent right
- `<` - Indent left
- `=` - Auto-indent
- `g~` - Toggle case
- `gu` - Make lowercase
- `gU` - Make uppercase
- `!` - Filter through external command

Examples:
- `daw` - Delete a word
- `ci"` - Change inside quotes
- `yap` - Yank a paragraph
- `>ip` - Indent a paragraph

### Undo/Redo
- `u` - Undo last change
- `<C-r>` - Redo
- `U` - Undo all changes on current line
- `:earlier {time}` - Go to earlier state (e.g., `:earlier 5m`)
- `:later {time}` - Go to later state

### Repeat & Dot Command
- `.` - Repeat last change
- `&` - Repeat last substitute command
- `@:` - Repeat last command-line command

### Jump List
- `<C-o>` - Jump to older position in jump list
- `<C-i>` - Jump to newer position in jump list
- `:jumps` - View jump list

### Change List
- `g;` - Go to older position in change list
- `g,` - Go to newer position in change list
- `:changes` - View change list

### Window Management
- `<C-w>s` - Split window horizontally
- `<C-w>v` - Split window vertically
- `<C-w>q` - Quit window
- `<C-w>o` - Close all other windows
- `<C-w>h/j/k/l` - Move to left/down/up/right window
- `<C-w>H/J/K/L` - Move window to far left/bottom/top/right
- `<C-w>=` - Make all windows equal size
- `<C-w>_` - Maximize window height
- `<C-w>|` - Maximize window width
- `<C-w>r` - Rotate windows
- `<C-w>x` - Exchange windows

### Tab Pages
- `:tabnew` - Create new tab
- `:tabclose` - Close current tab
- `gt` - Go to next tab
- `gT` - Go to previous tab
- `{count}gt` - Go to tab number {count}
- `:tabs` - List all tabs

### Folds
- `zo` - Open fold under cursor
- `zc` - Close fold under cursor
- `za` - Toggle fold under cursor
- `zR` - Open all folds
- `zM` - Close all folds
- `zj` - Move to next fold
- `zk` - Move to previous fold

### Search & Replace
- `/{pattern}` - Search forward
- `?{pattern}` - Search backward
- `*` - Search for word under cursor forward
- `#` - Search for word under cursor backward
- `n` - Next match
- `N` - Previous match
- `:%s/old/new/g` - Replace all occurrences in file
- `:s/old/new/g` - Replace all occurrences in line
- `:%s/old/new/gc` - Replace with confirmation

### Other Useful Commands
- `ZZ` - Save and quit (same as `:wq`)
- `ZQ` - Quit without saving (same as `:q!`)
- `gf` - Go to file under cursor
- `gx` - Open URL under cursor
- `ga` - Show ASCII value of character under cursor
- `g<C-g>` - Show cursor position and file statistics
- `gg=G` - Auto-indent entire file
- `:%!{cmd}` - Filter entire file through external command

## Core Navigation & Editing

### Escape Alternatives
- `<C-j>` - Escape to normal mode (all modes)
- `<C-k>` - Escape to normal mode (all modes)
- `<F1>` - Escape to normal mode

### File Operations
- `<leader>w` - Save file
- `<leader><leader>` - Switch to last buffer
- `<leader>o` - Open new file in current directory

### Search & Navigation
- `n` - Next search result (centered)
- `N` - Previous search result (centered)
- `*` - Search word under cursor (centered)
- `#` - Search word under cursor backward (centered)
- `g*` - Search partial word under cursor (centered)
- `/` - Very magic search forward
- `?` - Very magic search backward
- `<C-c>` - Clear search highlighting (normal and visual)

### Line Navigation
- `j` - Move down by visual line
- `k` - Move up by visual line
- `H` - Go to start of line
- `L` - Go to end of line

### Buffer Navigation
- `<left>` - Previous buffer
- `<right>` - Next buffer

### Text Editing
- `<CR>` (Enter) - Change inner word
- `<leader>m` - Change text until underscore
- `yc` - Duplicate line and comment original
- `J` (visual mode) - Move selected lines down
- `K` (visual mode) - Move selected lines up

## File & Project Navigation (Snacks Picker)

### Finding Files
- `<localleader>ff` - Find files
- `<localleader>fg` - Find git files
- `<localleader>b` - Buffers
- `<localleader>x` - Recent files
- `<localleader>fs` - Smart find

### Searching
- `<localleader>gg` - Grep
- `<localleader>gf` - Grep word under cursor
- `<localleader>gb` - Grep buffers
- `<leader>/` - Search buffer lines

### Utility
- `<localleader>:` - Commands
- `<leader>sk` - Keymaps
- `<localleader>h` - Help
- `<localleader>d` - Diagnostics

## LSP (Language Server Protocol)

### Navigation
- `gd` - Goto Definition (Snacks picker)
- `gr` - References (Snacks picker)
- `gi` - Goto Implementation (Snacks picker)
- `gD` - Declaration
- `<leader>D` - Type Definition
- `<leader>ss` - LSP Symbols (Snacks picker)

### Diagnostics
- `[d` - Previous Diagnostic
- `]d` - Next Diagnostic
- `<leader>q` - Diagnostic Location List

### Code Actions
- `K` - Hover documentation
- `<leader>k` - Signature help
- `<leader>ca` - Code action (normal and visual)
- `<leader>r` - LSP Rename symbol
- `<leader>R` - Rename file

### Workspace
- `<leader>wa` - Add workspace folder
- `<leader>wr` - Remove workspace folder
- `<leader>wl` - List workspace folders

### Formatting
- `<leader>cf` - Format code (normal and visual)

## Git Integration

### Git Navigation (Snacks Picker)
- `<localleader>gc` - Git branches
- `<localleader>gl` - Git log
- `<localleader>gs` - Git status

### Diffview
- `<leader>gd` - Open Diffview
- `<leader>gD` - Close Diffview
- `<leader>gh` - File history
- `<leader>gH` - Current file history

### Hunk Navigation (Gitsigns)
- `]c` - Next hunk
- `[c` - Previous hunk

### Hunk Actions (Gitsigns)
- `<leader>hs` - Stage hunk (normal and visual)
- `<leader>hr` - Reset hunk (normal and visual)
- `<leader>hS` - Stage buffer
- `<leader>hu` - Undo stage hunk
- `<leader>hR` - Reset buffer
- `<leader>hp` - Preview hunk
- `ih` - Select hunk (operator and visual modes)

### Git Information
- `<leader>hb` - Blame line
- `<leader>hd` - Diff this
- `<leader>hD` - Diff this ~

## File Navigation

### Flash (Quick Motion)
- `s` - Flash jump (normal, visual, operator)
- `S` - Flash Treesitter (normal, visual, operator)
- `r` - Remote Flash (operator)
- `R` - Treesitter Search (operator and visual)
- `<c-s>` - Toggle Flash Search (command mode)

### Harpoon (Quick File Switching)
- `<leader>a` - Add file to Harpoon
- `<C-e>` - Toggle Harpoon menu
- `<C-h>` - Jump to Harpoon file 1
- `<C-t>` - Jump to Harpoon file 2
- `<C-n>` - Jump to Harpoon file 3
- `<C-s>` - Jump to Harpoon file 4
- `<leader>hp` - Harpoon previous
- `<leader>hn` - Harpoon next

### File Explorer
- `-` - Open parent directory (Oil)
- `<localleader>a` - Toggle Explorer (Snacks)

## Toggles

All toggle keybinds are under `<leader>u`:
- `<leader>ud` - Toggle dim
- `<leader>ui` - Toggle indent scope highlighting
- `<leader>uh` - Toggle hidden characters
- `<leader>ub` - Toggle line blame
- `<leader>ugd` - Toggle deleted lines
- `<leader>uz` - Toggle zen mode
- `<leader>uZ` - Toggle zoom

## Testing (Neotest)

- `<leader>tt` - Run nearest test
- `<leader>tf` - Run file tests
- `<leader>ts` - Toggle test summary
- `<leader>to` - Show test output
- `<leader>tO` - Close test output
- `<leader>tp` - Toggle test output panel

## Diagnostics & Trouble

- `<leader>xx` - Diagnostics (Trouble)
- `<leader>xX` - Buffer Diagnostics (Trouble)
- `<leader>cs` - Symbols (Trouble)
- `<leader>cl` - LSP Definitions/References (Trouble)
- `<leader>xL` - Location List (Trouble)
- `<leader>xQ` - Quickfix List (Trouble)

## Code Editing

### Text Manipulation
- `<leader>S` - Search and Replace (grug-far)
- `gs` - Substitute operator
- `gss` - Substitute line
- `gS` - Substitute to end of line
- `gs` (visual) - Substitute visual selection
- `<leader>j` - Toggle split/join code blocks

### Utilities
- `<leader>li` - Pick Icon

## REST Client (Kulala)

- `<leader>kr` - Run HTTP request
- `<leader>ki` - Inspect request
- `<leader>kt` - Toggle view

## Screenshots (Silicon)

Visual mode only:
- `<leader>sc` - Copy code screenshot to clipboard
- `<leader>sf` - Save code screenshot as file
- `<leader>ss` - Create code screenshot

## Plugin Management

- `<leader>ll` - Open Lazy plugin manager
- `<leader>mm` - Open Mason (LSP/tool installer)

## Completion (Blink.cmp)

Insert mode:
- `<CR>` - Accept completion
- `<C-n>` - Next completion (default preset)
- `<C-p>` - Previous completion (default preset)
- `<C-y>` - Confirm completion (default preset)
- `<C-e>` - Cancel completion (default preset)

## Notes

### Disabled Keys
- Arrow keys (`<up>`, `<down>`) are disabled in normal and insert mode to encourage using `j`/`k`
- Arrow keys (`<left>`, `<right>`) are remapped in normal mode for buffer navigation
- Arrow keys in insert mode are disabled

### Plugin-Specific Behavior
- **Comment.nvim**: Use `gcc` (line comment) and `gc` (operator/visual comment)
- **nvim-surround**: Default keybinds (`ys`, `ds`, `cs`)
- **nvim-autopairs**: Automatic bracket/quote pairing in insert mode
- **Marks.nvim**: Enhanced marks with default vim keybinds (`m`, `'`, `` ` ``)
