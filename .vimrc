set nocompatible " Don't maintain compatibility with Vi. This must be first since it changes other options
filetype plugin on

" ======================================
"  vim-plug settings
" -----------------------
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Tim Pope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" FZF for Vim
" Plugin outside ~/.vim/plugged with post-update hook
" First, install github.com/junegunn/fzf using git
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" NerdTree
" Need to install nerdfonts and use Nerd Font as the font
Plug 'preservim/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Visual
" Plug 'lifepillar/vim-solarized8'
Plug 'morhetz/gruvbox'
" Plug 'flazz/vim-colorschemes'
" Plug 'sainnhe/forest-night'
" Plug 'joshdick/onedark.vim'
" Plug 'dracula/vim', { 'name': 'dracula' }
" Plug 'arcticicestudio/nord-vim'

Plug 'machakann/vim-highlightedyank'
Plug 'sheerun/vim-polyglot'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'

" Tmux
" :TmuxNavigatorProcessList to check if vim-tmux-navigator is properly
Plug 'christoomey/vim-tmux-navigator'
" Plug 'christoomey/vim-tmux-runner'

Plug 'tmhedberg/SimpylFold'

" Coc
" I had problems with installing nodejs on remote machines.
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" ALE
Plug 'dense-analysis/ale'

" Others
Plug 'vim-scripts/ReplaceWithRegister'
" Plug 'mhinz/vim-signify'

" Python cell execution
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }

" Notes
Plug 'vimwiki/vimwiki'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" Initialize plugin system
call plug#end()
" ======================================

" https://pybit.es/vim-tricks.html
let mapleader = ','

" Colors
" github.com/benizi/dotfiles/blob/master/.vim/vimrc
syntax on  " syntax highlighting (similar to 'syndtax enable')

" set t_Co=256

let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
" if has( 'termguicolors' )
"     set termguicolors
" endif

" This must come before the gruvbox is definded
let g:gruvbox_italic=1
" let g:gruvbox_contrast_dark = 'soft'

set background=dark
" colorscheme solarized8
colorscheme gruvbox
" colorscheme forest-night
" colorscheme molokai
" colorscheme dessert
" colorscheme wombat
" colorscheme onedark
" colorscheme dracula
" colorscheme nord

" (!) Required to show italic in vim markdown.
" https://github.com/morhetz/gruvbox/issues/119
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"


" -----------------------------------------------------------------------------
"   Basic Settings
" -----------------------------------------------------------------------------
set autoindent                  " Copy indent from current line on <cr>
set backspace=indent,eol,start  " Sane backlspace vi.stackexchange.com/questions/2162/
set conceallevel=2              " italic, bold, 
set cursorline                  " highlight cursorline
set encoding=UTF-8
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

" stackoverflow.com/questions/234564
" set autoindent                " copy indent when starting a new line
set expandtab                   " Expand tabs to spaces
set shiftwidth=4                " Number of spaces to use for (auto) indent
set tabstop=4                   " The number of spaces that a <Tab> counts for


" -----------------------------------------------------------------------------
"   Mappings
" -----------------------------------------------------------------------------
" Clear search highlights
" vi.stackexchange.com/questions/8741
nnoremap <ESC><ESC> :silent! nohls<cr>
" nnoremap \\ :silent! nohls<CR>

" Mappings in Normal mode
" nnoremap 0 ^

" Move up and down by visible lines if current line is wrapped
nnoremap j gj
nnoremap k gk

" Map Esc
inoremap jk <ESC>
inoremap kj <ESC>

" Make Y behave as D
" github.com/davidhalter/dotfiles/blob/master/.vimrc
map Y y$

" Redo with U
nnoremap U <C-r>

" Map write (save) file
inoremap <Leader>w <ESC>:w<CR>
nnoremap <Leader>w :w<CR>

" Map quit file
inoremap <Leader>q <ESC>:q<CR>
nnoremap <Leader>q :q<CR>

" Map fold code; TODO: how to unbind za
nnoremap <Space> za
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

" Buffers
" nnoremap <Leader>n :enew<CR>  " new buffer
nnoremap <Tab> :bnext<CR>         " next buffer
nnoremap <S-Tab> :bprev<CR>       " previous buffer
nnoremap <Leader><Space> :b#<CR>  " recent buffer
" nnoremap <Leader>a :only<CR>  " only buffer
nnoremap Q :bd!<CR>               " close buffer

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" ALE
map <Leader>g :ALEGoToDefinition<CR>


" --------------------------------------
" learnvimscriptthehardway.stevelosh.com
" --------------------------------------
nnoremap <Leader>ev :vsplit $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

nnoremap H ^
nnoremap L $
" nnoremap J G
" nnoremap K gg
nnoremap J 5j
nnoremap K 5k


" -----------------------------------------------------------------------------
"   Basic settings
" -----------------------------------------------------------------------------
let g:python_highlight_space_errors = 0  " disable reg line in polyglot


" -----------------------------------------------------------------------------
"   VimWiki
" -----------------------------------------------------------------------------
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]


" -----------------------------------------------------------------------------
"   NERDTree
" -----------------------------------------------------------------------------
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__', '.ipynb_checkpoints']

" Automatically close tree after file is opened from it
let NERDTreeQuitOnOpen=1  " options: 0, 1, 2, 3

" Sort files with numbers naturally
let NERDTreeNaturalSort=1

" Show hidden files by default
let NERDTreeShowHidden=1

" Automatically delete buffer when file is deleted from the tree explorer
let NERDTreeAutoDeleteBuffer=1


" -----------------------------------------------------------------------------
"   Status Line
" -----------------------------------------------------------------------------
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
"   ALE Configs
" -----------------------------------------------------------------------------
" Linting
let g:ale_linters = {'python': ['flake8', 'pyls']}
" can't enbale linting for a single buffer when ale_enabled=1
" let g:ale_enabled = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
" Only run linters named in ale_linters settings.
" let g:ale_linters_explicit = 1

" Fixing
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']} " work!
" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['black']}
" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['yapf']}
let g:ale_fix_on_save = 0

" Remove background color in sign gutter for linting
" https://github.com/dense-analysis/ale/issues/249
highlight clear ALEErrorSign
highlight clear ALEWarningSign

let g:ale_sign_error = '✗'
" let g:ale_sign_error = '•'
" let g:ale_sign_warning = '•'
" let g:ale_sign_warning = '▲'
let g:ale_sign_warning = '.'

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
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" " Airline
" let g:airline_left_sep  = ''
" let g:airline_right_sep = ''
" let g:airline#extensions#ale#enabled = 1
" let airline#extensions#ale#error_symbol = 'E:'
" let airline#extensions#ale#warning_symbol = 'W:'

" Disable things (LSP, etc)
" Completion is only supported while at least one LSP linter is enabled.
" ALE integrates with Deoplete for offering automatic completion data.
" let g:ale_completion_enabled=0  " code completion (default=0)
" let g:ale_disable_lsp=1         " ignore linters powered by lsp and also tsserver (default=0)
" let g:ale_update_tagstack=0  " go to definition


" -----------------------------------------------------------------------------
"   Slime Configs
" -----------------------------------------------------------------------------
" always use tmux
let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1


" -----------------------------------------------------------------------------
"   FZF
" -----------------------------------------------------------------------------
" github.com/tallguyjenks/.dotfiles/blob/master/nvim/.config/nvim/init.vim
" noremap <C-f> <Esc><Esc>:Files!<CR>
" inoremap <C-f> <Esc><Esc>:BLines!<CR>
" noremap <C-g> <Esc><Esc>:BCommits!<CR>
" Bat Preview Theme
let $BAT_THEME = 'Solarized (dark)'
" Let FZF find hidden files and folders
" let $FZF_DEFAULT_COMMAND='find . -not -path "*/\.git*" -type f -print'

" github.com/nickjj/dotfiles/blob/master/.vimrc
" nnoremap <silent> <C-p> :FZF -m<CR>
" nnoremap <silent> <Leader><Enter> :Buffers<CR>
" nnoremap <silent> <Leader>l :Lines<CR>

" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf
nnoremap <silent> <C-f> :Files!<CR>
nnoremap <silent> <Leader>l :BLines<CR>
nnoremap <silent> <Leader>L :Lines<CR>
nnoremap <silent> <Leader>b :Buffers<CR>


" -----------------------------------------------------------------------------
" https://thoughtbot.com/upcase/videos/tmux-vim-integration
" -----------------------------------------------------------------------------
" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" zoom a vim pane, <C-w>= to re-balance
" (ap) this doesn't work (?!)
nnoremap <Leader>~ :wincmd _<CR>:wincmd \|<CR>
nnoremap <Leader>= :wincmd =<CR>

" thoughtbot.com/upcase/videos/tmux-vim-integration
" I haven't tried this. See if I can also initiate a specific conda env.
" Not sure why this doesn't open a new pane (??)
" nnoremap <leader>py :VtrOpenRunner {'orientation': 'h', 'percentage': 50, 'cmd': 'python'}<cr>
