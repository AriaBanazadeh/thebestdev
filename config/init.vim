set nocompatible
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set ruler
set showcmd
set incsearch
set shellslash
set number
set relativenumber
set cino+=L0 
syntax on
filetype indent on
filetype off
setlocal indentkeys-=:
autocmd TermOpen * startinsert

imap kk <Esc>
imap jj <Esc>
imap hh <Esc>
imap ll <Esc>
nnoremap <A-t> :cd %:p:h<CR>:terminal<CR>
inoremap <A-t> <Esc>:cd %:p:h<CR>:terminal<CR>
function! OpenNewBufferWithTermCWD()
    let term_cwd = system('pwd')
    let clean_cwd = substitute(term_cwd, '\n\+$', '', '')
    autocmd! TermClose * ++once cd %:p:h | execute "cd " . shellescape(clean_cwd, 1) | enew
    execute "<C-\><C-n>"
endfunction

tnoremap <A-t> <cmd>call OpenNewBufferWithTermCWD()<CR>

function! ToggleZoom()
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction

" Map Mod+f (Alt+f) to toggle zoom in normal and insert modes
nnoremap <A-f> :call ToggleZoom()<CR>
inoremap <A-f> <Esc>:call ToggleZoom()<CR>


" Map Alt+ d to zz and Alt + d to center the vioew always 

nnoremap <A-d> <C-d>zz
nnoremap <A-u> <C-u>zz
tnoremap <A-d> <C-d>zz
tnoremap <A-u> <C-u>zz

" Navigate to the next tab with Alt + K 
nnoremap <A-K> :tabnext<CR>
inoremap <A-K> <Esc>:tabnext<CR>
tnoremap <A-K> <C-\><C-n>:tabnext<CR>

" Navigate to the previous tab with Alt + J  
nnoremap <A-J> :tabprev<CR>
inoremap <A-J> <Esc>:tabprev<CR>
tnoremap <A-J> <C-\><C-n>:tabprev<CR>

function! GoToTabOrCreate(tabnum)
    if tabpagenr('$') < a:tabnum
        tabnew
    else
        " Simulate pressing keys in normal mode without using :execute
        let command = a:tabnum . 'gt'
        execute 'normal! ' . command
    endif
endfunction

" Map keys to use the function for tabs 1 through 9 and 0 for the last tab
nnoremap <A-1> :call GoToTabOrCreate(1)<CR>
nnoremap <A-2> :call GoToTabOrCreate(2)<CR>
nnoremap <A-3> :call GoToTabOrCreate(3)<CR>
nnoremap <A-4> :call GoToTabOrCreate(4)<CR>
nnoremap <A-5> :call GoToTabOrCreate(5)<CR>
nnoremap <A-6> :call GoToTabOrCreate(6)<CR>
nnoremap <A-7> :call GoToTabOrCreate(7)<CR>
nnoremap <A-8> :call GoToTabOrCreate(8)<CR>
nnoremap <A-9> :call GoToTabOrCreate(9)<CR>
nnoremap <A-0> :tablast<CR>

" Insert mode mappings
inoremap <A-1> <Esc>:call GoToTabOrCreate(1)<CR>
inoremap <A-2> <Esc>:call GoToTabOrCreate(2)<CR>
inoremap <A-3> <Esc>:call GoToTabOrCreate(3)<CR>
inoremap <A-4> <Esc>:call GoToTabOrCreate(4)<CR>
inoremap <A-5> <Esc>:call GoToTabOrCreate(5)<CR>
inoremap <A-6> <Esc>:call GoToTabOrCreate(6)<CR>
inoremap <A-7> <Esc>:call GoToTabOrCreate(7)<CR>
inoremap <A-8> <Esc>:call GoToTabOrCreate(8)<CR>
inoremap <A-9> <Esc>:call GoToTabOrCreate(9)<CR>
inoremap <A-0> <Esc>:tablast<CR>

" Terminal mode mappings
tnoremap <A-1> <C-\><C-n>:call GoToTabOrCreate(1)<CR>
tnoremap <A-2> <C-\><C-n>:call GoToTabOrCreate(2)<CR>
tnoremap <A-3> <C-\><C-n>:call GoToTabOrCreate(3)<CR>
tnoremap <A-4> <C-\><C-n>:call GoToTabOrCreate(4)<CR>
tnoremap <A-5> <C-\><C-n>:call GoToTabOrCreate(5)<CR>
tnoremap <A-6> <C-\><C-n>:call GoToTabOrCreate(6)<CR>
tnoremap <A-7> <C-\><C-n>:call GoToTabOrCreate(7)<CR>
tnoremap <A-8> <C-\><C-n>:call GoToTabOrCreate(8)<CR>
tnoremap <A-9> <C-\><C-n>:call GoToTabOrCreate(9)<CR>
tnoremap <A-0> <C-\><C-n>:tablast<CR>

" Map Alt + x to close the current buffer
nnoremap <A-x> :q!<CR>
inoremap <A-x> <Esc>:q!<CR>
tnoremap <A-x> <C-\><C-n>:q!<CR>
function! CloseTabOrExit()
    if tabpagenr('$') == 1
        qa!
    else
        tabclose!
    endif
endfunction

" Map Alt + Shift + x (Alt + X) to close the current tab
nnoremap <A-X> :call CloseTabOrExit()<CR>
inoremap <A-X> <Esc>:call CloseTabOrExit()<CR>
tnoremap <A-X> <C-\><C-n>:call CloseTabOrExit()<CR>


"Save files
nnoremap <A-s> :w!<CR>
inoremap <A-s> <Esc>:w!<CR>  

" Remap for navigating splits with Alt key
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k

" Configuration for creating and navigating terminals with shortcuts
" Modified to use Alt key for your requirements

" Quickly create a new terminal in a new tab
tnoremap <A-t> <C-\><C-n>:tabnew<CR>:term<CR>
noremap <A-t> :tabnew<CR>:term<CR>
inoremap <A-t> <Esc>:tabnew<CR>:term<CR>

" Create a new vertical split with Alt + v
nnoremap <A-v> :vsplit<CR>
inoremap <A-v> <Esc>:vsplit<CR>
tnoremap <A-v> <C-\><C-n>:vsplit<CR>

" Create a new horizontal split with Alt + h
nnoremap <A-b> :split<CR>
inoremap <A-b> <Esc>:split<CR>
tnoremap <A-b> <C-\><C-n>:split<CR>





tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>
tnoremap hh <C-\><C-n>
tnoremap ll <C-\><C-n>
tnoremap kk <C-\><C-n>
call plug#begin('/etc/nvim/plugged')
call plug#end()

let mapleader = ","
let $PATH = '/usr/local/lib/nodejs/bin:' . $PATH

call plug#begin('/etc/nvim/plugged')
Plug 'nvim-lua/plenary.nvim'
Plug 'chomosuke/term-edit.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'BurntSushi/ripgrep'
Plug 'sharkdp/fd'
Plug 'lervag/vimtex'
Plug 'SirVer/ultisnips'
Plug 'chomosuke/term-edit.nvim', {'tag': 'v1.*'}
call plug#end()
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:python3_host_prog = "/usr/bin/python3"
let g:netrw_keepdir=0
lua << EOF
require 'term-edit'.setup {
  prompt_end = '%$ ',
}

require('telescope').setup{
  defaults = {
  },
  extensions = {
    fzf = {
      fuzzy = true,                
      override_generic_sorter = true, 
      override_file_sorter = true,   
      case_mode = "smart_case",     
    }
  }
}
require('telescope').load_extension('fzf')

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<CR>", default_opts)
map('n', '<leader>fb', "<cmd>lua require'telescope.builtin'.buffers({ show_all_buffers = true })<CR>", default_opts)
map('n', '<leader>/', "<cmd>lua require'telescope.builtin'.live_grep()<CR>", default_opts)
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

-- Custom function to open terminal in selected directory
local open_terminal_in_directory = function(prompt_bufnr)
    local selected_directory = action_state.get_selected_entry()
    actions.close(prompt_bufnr)
    -- Change directory command
    vim.cmd('cd ' .. selected_directory[1])
    -- Open terminal
    vim.cmd('terminal')
end

-- Custom Telescope picker for directories using 'find'
function Telescope_find_directories()
    pickers.new({}, {
        prompt_title = "Find Directories",
        finder = finders.new_oneshot_job({'find', '.', '-type', 'd'}),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(_, map)
            map('i', '<CR>', open_terminal_in_directory)
            map('n', '<CR>', open_terminal_in_directory)
            return true
        end,
    }):find()
end

-- Map the custom picker to a keybinding (adjust as needed)

vim.api.nvim_set_keymap('n', '<leader>fd', '<cmd>lua Telescope_find_directories()<CR>', {noremap = true, silent = true})


