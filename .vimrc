set nocompatible " Don't maintain compatibility with Vi. This must be first since it changes other options

" " ===========================================================
" "  Vundle settings
" " -----------------------
" " required by Vundle stackoverflow.com/questions/14642956/
" filetype off

" " set runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()
" " or, pass a path where Vundle should install plugins
" " call vundle#begin('~/some/path/here')

" " let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" " Run ':TmuxNavigatorProcessList' to check vim-tmux-navigator is properly
" " installed. This plugin didn't work with minpac.
" Plugin 'tpope/vim-commentary'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-fugitive'

" " Integrate fzf with Vim.
" " First, install github.com/junegunn/fzf using git
" Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plugin 'junegunn/fzf.vim'

" Plugin 'vim-scripts/ReplaceWithRegister'
" Plugin 'machakann/vim-highlightedyank'

" " Colors
" Plugin 'lifepillar/vim-solarized8'
" " Plugin 'dracula/vim', { 'name': 'dracula' }

" " Plugin 'vim-airline/vim-airline'
" " Plugin 'vim-airline/vim-airline-themes'
" Plugin 'itchyny/lightline.vim'
" " Plugin 'mengelbrecht/lightline-bufferline'

" Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'christoomey/vim-tmux-runner'

" Plugin 'Vimjas/vim-python-pep8-indent'
" Plugin 'tmhedberg/SimpylFold'

" " All of your Plugins must be added before the following line
" call vundle#end()            " required

" " required by Vundle; allow plugins by file type
" filetype plugin indent on

" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to  auto-approve removal
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
" " ===========================================================

" ===========================================================
"  vim-plug settings
" -----------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Run ':TmuxNavigatorProcessList' to check vim-tmux-navigator is properly
" installed. This plugin didn't work with minpac.
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
" Plug 'mhinz/vim-signify'

" Integrate fzf with Vim.
" Plugin outside ~/.vim/plugged with post-update hook
" First, install github.com/junegunn/fzf using git
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-scripts/ReplaceWithRegister'
Plug 'machakann/vim-highlightedyank'

" Colors
Plug 'lifepillar/vim-solarized8'
" Plug 'flazz/vim-colorschemes'
" Plug 'sainnhe/forest-night'
" Plug 'joshdick/onedark.vim'
" Plug 'dracula/vim', { 'name': 'dracula' }
" Plug 'sheerun/vim-polyglot'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'

Plug 'sheerun/vim-polyglot'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
" Plug 'christoomey/vim-tmux-runner'

Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tmhedberg/SimpylFold'

" Coc
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ALE
Plug 'dense-analysis/ale'

" Initialize plugin system
call plug#end()
" ===========================================================

" https://pybit.es/vim-tricks.html
let mapleader = ","

" Colors
" github.com/benizi/dotfiles/blob/master/.vim/vimrc
syntax on  " syntax highlighting (similar to 'syndtax enable')
set t_Co=256
set background=dark
colorscheme solarized8
" colorscheme forest-night
" colorscheme molokai
" colorscheme dessert
" colorscheme wombat
" colorscheme onedark
" colorscheme dracula


" -----------------------------------------------------------------------------
"   Basic Settings
" -----------------------------------------------------------------------------
set autoindent                  " Copy indent from current line on <cr>
set backspace=indent,eol,start  " Sane backlspace vi.stackexchange.com/questions/2162/
set cursorline                  " highlight cursorline
set hlsearch                    " Highlight search results
set laststatus=2                " Show statusbar all the time
set matchpairs+=<:>     	    " Highlight matching pairs of brackets. Use '%' char to jump btw them.
set noswapfile  	            " Swap files give annoying warning
set noshowmode                  " Don't show vim mode (use when lightline is used)
set number                      " Display line numbers
set relativenumber              " Display relative line number
set ruler                       " Show line number and column number
set scrolloff=3                 " Keep at least 2 lines below cursor
set showmatch                   " Show matching brackets
set showtabline=2               " Show tab line
set ttyfast             	    " Speed up scrolling in Vim

" stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
" set autoindent                " copy indent when starting a new line
set expandtab                   " Expand tabs to spaces
set shiftwidth=4                " Number of spaces to use for (auto) indent
set tabstop=4                   " The number of spaces that a <Tab> counts for


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

" Make Y behave as D
" github.com/davidhalter/dotfiles/blob/master/.vimrc
map Y y$

" Map write (save) file
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
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
" github.com/nickjj/dotfiles/blob/master/.vimrc
xnoremap <leader>r :s///g<Left><Left>
xnoremap <leader>rc :s///gc<Left><Left><Left>

" Buffers
" nnoremap <leader>k :bnext<cr>
" nnoremap <leader>j :bprev<cr>

" --------------------------------------
" learnvimscriptthehardway.stevelosh.com
" --------------------------------------
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap H ^
nnoremap L $
nnoremap J G
nnoremap K gg

" Put text into python docstring in visual mode
" vnoremap """ <esc>'<O"""<esc>'>o"""<esc>j^

" iabbrev impd import pandas as pd
" iabbrev imnp import numpy as np
" iabbrev imsk import sklearn


" -----------------------------------------------------------------------------
"   Python indent
" -----------------------------------------------------------------------------
let g:python_pep8_indent_hang_closing=0 " TODO does it even work??


" -----------------------------------------------------------------------------
"   Status line
" -----------------------------------------------------------------------------
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
"   ALE configs
" -----------------------------------------------------------------------------
" Linting
let g:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_enter = 0
" can't enbale linting for a single buffer when ale_enabled=1
" let g:ale_enabled = 0
" let g:ale_lint_on_save = 1
" Only run linters named in ale_linters settings.
" let g:ale_linters_explicit = 1

" Fixing
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']} " work!
" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black']} " does work!
" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['yapf']} " doesn't work!
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'python': ['yapf']
" \}
let g:ale_fix_on_save = 0

" let g:ale_sign_warning = '▲'
" let g:ale_sign_error = '✗'
" let g:ale_sign_error = '•'
" let g:ale_sign_warning = '•'

" let g:ale_echo_msg_error_str = 'Error'  " 'E'
" let g:ale_echo_msg_warning_str = 'Warning'  " 'W'

" github.com/horseinthesky/dotfiles/blob/master/files/init.vim
" ignore long-lines, import on top of the file, unused modules and statement with colon
" let g:ale_python_flake8_options = '--ignore=E501,E402,F401,E701' 
" ignore long-lines for autopep8 fixer
" let g:ale_python_autopep8_options = '--ignore=E501'              

" https://github.com/statico/dotfiles/blob/master/.vim/vimrc
" https://yufanlu.net/2018/09/03/neovim-python/
" Ale
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_linters = {'python': ['flake8']}
" " Airline
" let g:airline_left_sep  = ''
" let g:airline_right_sep = ''
" let g:airline#extensions#ale#enabled = 1
" let airline#extensions#ale#error_symbol = 'E:'
" let airline#extensions#ale#warning_symbol = 'W:'

" -----------------------------------------------------------------------------
"   FZF
" -----------------------------------------------------------------------------
" github.com/tallguyjenks/.dotfiles/blob/master/nvim/.config/nvim/init.vim
" noremap <C-f> <Esc><Esc>:Files!<CR>
" inoremap <C-f> <Esc><Esc>:BLines!<CR>
" noremap <C-g> <Esc><Esc>:BCommits!<CR>
" Bat Preview Theme
" let $BAT_THEME = 'Solarized (dark)'
" Let FZF find hidden files and folders
" let $FZF_DEFAULT_COMMAND='find . -not -path "*/\.git*" -type f -print'

" github.com/nickjj/dotfiles/blob/master/.vimrc
" nnoremap <silent> <C-p> :FZF -m<CR>
" nnoremap <silent> <Leader><Enter> :Buffers<CR>
" nnoremap <silent> <Leader>l :Lines<CR>

" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf
nnoremap <leader>l :BLines<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>b :Buffers<cr>


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
