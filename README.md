# init.lua
Config file for Neovim

### Shortcuts

leader = " "

CTRL+y -> Confirm Suggestion

<leader>pf -> Search files

<leader>y -> Yank

<leader>p -> Paste

u -> undo

CTRL+r -> redo

### Core Vim copy paste commands

Y -> copy (in visual mode inside editor only)

P -> paste (in visual mode inside editor only)

"ay - yank selected text to 'a' register (inside editor)

"ap - paste yanked text from 'a' register (inside editor)

"+y - yank selected text to '+' register which also copies to system clipboard, so we can paste using CTRL + V outside editor

"+p - paste yanked text from outside editor to editor

### Nvim Explorer - File management

<leader>pv -> Open nvim folder tree

d - create directory

D - Delete

% - create file

R - rename
