set nocompatible " Don't maintain compatibility with Vi. This must be first since it changes other options

" ===========================================================
"  Vundle settings
" -----------------------
" required by Vundle stackoverflow.com/questions/14642956/
filetype off

" set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" or, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Run ':TmuxNavigatorProcessList' to check vim-tmux-navigator is properly
" installed. This plugin didn't work with minpac.
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

" Integrate fzf with Vim.
" First, install github.com/junegunn/fzf using git
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'machakann/vim-highlightedyank'

" Colors
Plugin 'lifepillar/vim-solarized8'
" Plugin 'dracula/vim', { 'name': 'dracula' }

" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
Plugin 'itchyny/lightline.vim'
" Plugin 'mengelbrecht/lightline-bufferline'

Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'

Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tmhedberg/SimpylFold'

" All of your Plugins must be added before the following line
call vundle#end()            " required

" required by Vundle; allow plugins by file type
filetype plugin indent on
syntax on  " syntax highlighting (similar to 'syndtax enable')

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to  auto-approve removal
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ===========================================================

" https://pybit.es/vim-tricks.html
let mapleader = ","

set autoindent                  " Copy indent from current line on <cr>
set backspace=indent,eol,start  " Sane backlspace vi.stackexchange.com/questions/2162/
set hlsearch                    " Highlight search results
set laststatus=2                " Show statusbar all the time
set matchpairs+=<:>     	    " Highlight matching pairs of brackets. Use '%' char to jump btw them.
set noswapfile  	            " Swap files give annoying warning
set noshowmode                  " Don't show vim mode (use when lightline is used)
set number                      " Display line numbers
set relativenumber              " Display relative line number
set ruler                       " Show line number and column number
set scrolloff=2                 " Keep at least 2 lines below cursor
set showmatch                   " Show matching brackets
set showtabline=2               " Show tab line
set ttyfast             	    " Speed up scrolling in Vim

" stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
set tabstop=4                   " The number of spaces that a <Tab> counts for
set shiftwidth=4                " Number of spaces to use for (auto) indent
set expandtab                   " Expand tabs to spaces

" Colors
set t_Co=256
set background=dark
colorscheme solarized8          " github.com/lifepillar/vim-solarized8
" colorscheme dracula

" -----------------------------------------------------------------------------
"   Mappings
" -----------------------------------------------------------------------------
" Make double-<Esc> clear search highlights
" vi.stackexchange.com/questions/8741/how-to-automatically-turn-off-hlsearch-after-im-done-searching
nnoremap <esc><esc> :silent! nohls<cr>

" Mappings in Normal mode
" nnoremap 0 ^

" Move up and down by visible lines if current line is wrapped
nnoremap j gj
nnoremap k gk

" Map Esc
inoremap jk <esc>
inoremap kj <esc>

" Map write file
inoremap <leader>w <esc>:w<cr>
nnoremap <leader>w :w<cr>

" Map quit file
inoremap <leader>q <esc>:q<cr>
nnoremap <leader>q :q<cr>

" Map fold code; TODO: how to unbind za
nnoremap <space> za
" nnoremap <leader>z zMzvzz

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
" github.com/nickjj/dotfiles/blob/master/.vimrc
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
" github.com/nickjj/dotfiles/blob/master/.vimrc
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" --------------------------------------
" learnvimscriptthehardway.stevelosh.com
" --------------------------------------
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H ^
nnoremap L g_
nnoremap J G
nnoremap K gg

" Put text into python docstring in visual mode
" vnoremap """ <esc>'<O"""<esc>'>o"""<esc>j^

" iabbrev impd import pandas as pd
" iabbrev imnp import numpy as np
" iabbrev imsk import sklearn

" -----------------------------------------------------------------------------
"   Plugin configs
" -----------------------------------------------------------------------------
let g:python_pep8_indent_hang_closing=0 " TODO does it even work??

" Airline
" let g:airline_powerline_fonts = 1
" let g:airline_theme = 'simple'

" Lighline
" github.com/statico/dotfiles/blob/202e30b23e5216ffb6526cce66a0ef4fa7070456/.vim/vimrc
" let g:lightline#bufferline#show_number  = 1           " Buffer number as shown by the :ls command
" let g:lightline#bufferline#shorten_path = 0           " Defines whether to shorten the path
" let g:lightline#bufferline#unnamed      = '[No Name]' " The name to use for unnamed buffers

let g:lightline = {'colorscheme': 'wombat'}
let g:lightline.active = {'left': [['mode', 'paste'], ['readonly', 'filename', 'modified']]}
let g:lightline.active = {'right': [['lineinfo'], ['percent']]}
" let g:lightline.active = {'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]}

" let g:lightline.tabline          = {'left': [['buffers']]}
" let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
" let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
" let g:lightline.component_type   = {'buffers': 'tabsel'}

" -----------------------------------------------------------------------------
" https://thoughtbot.com/upcase/videos/tmux-vim-integration
" -----------------------------------------------------------------------------
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
" (ap) this doesn't work (?!)
nnoremap <leader>~ :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" thoughtbot.com/upcase/videos/tmux-vim-integration
" I haven't tried this. See if I can also initiate a specific conda env.
" Not sure why this doesn't open a new pane (??)
" nnoremap <leader>py :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'python'}<cr>

