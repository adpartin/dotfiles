set nocompatible " Don't maintain compatibility with Vi. This must be first since it changes other options
filetype off     " required by Vundle stackoverflow.com/questions/14642956/why-vundle-requires-filetype-off/17045575

" ===========================================================
"  Vundle settings
" -----------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Run ':TmuxNavigatorProcessList' to check vim-tmux-navigator is properly
" installed. This plugin didn't work with minpac.
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'christoomey/vim-tmux-runner'

Plugin 'lifepillar/vim-solarized8'

Plugin 'tpope/vim-surround'

Plugin 'tpope/vim-commentary'

Plugin 'tpope/vim-repeat'

Plugin 'machakann/vim-highlightedyank'

Plugin 'vim-scripts/ReplaceWithRegister'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to  auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" ===========================================================

syntax on  " syntax highlighting, (similar to 'syndtax enable')

" Map the leader
" https://pybit.es/vim-tricks.html
let mapleader = ","

set number                      " display line numbers
set relativenumber              " display relative line number
set showmatch                   " show matching brackets
set hlsearch                    " highlight search results
set noswapfile  	            " swap files give annoying warning
set ttyfast             	    " speed up scrolling in Vim
set matchpairs+=<:>     	    " highlight matching pairs of brackets. Use '%' char to jump btw them.
set scrolloff=2                 " keep at least 2 lines below cursor
set backspace=indent,eol,start  " sane backlspace vi.stackexchange.com/questions/2162/

" stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim
set tabstop=4
set shiftwidth=4
set expandtab

" Set colors
set t_Co=256
set background=dark
colorscheme solarized8  " github.com/lifepillar/vim-solarized8

" -----------------------------------------------------------------------------
"   Mappings
" -----------------------------------------------------------------------------
" vi.stackexchange.com/questions/8741/how-to-automatically-turn-off-hlsearch-after-im-done-searching
nnoremap <esc><esc> :silent! nohls<cr>

" Mappings in Normal mode
nmap 0 ^

" Move up and down by visible lines if current line is wrapped
nmap j gj
nmap k gk

" Map Esc
imap jk <esc>
imap kj <esc>

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

