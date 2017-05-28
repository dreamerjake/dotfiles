set nocompatible
filetype off

" F-Keys Current Bindings
" #######################
" F-2    Toggle Line Numbering
" F-3    Toggle Paste
" F-7    Flake8 Scan
" F-9    NERDTree Find
" F-10   Toggle NERDTree
" SPACE  Fold

" Set up Vundle:
" ##############
" $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

" YouCompleteMe install guide
" ###########################
" https://valloric.github.io/YouCompleteMe/#full-installation-guide
" <Install vim from source>
" sudo apt-get install cmake
" cd ~
" mkdir ycm_build
" cd ycm_build
" cmake -G "<generator>" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
" cmake -G "Unix Makefiles" . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
" cmake --build . --target ycm_core --config Release

" Flake8 Install
" ##############
" python -m pip install flake8

" Vundle Stuff
" ############
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


" Automatic reloading of .vimrc
" #############################
autocmd! bufwritepost .vimrc source %

" Better copy and paste
" #####################
set pastetoggle=<F3>
set clipboard=unnamed

" Mouse and backspace
" ###################
set mouse=a
set bs=2

" Show trailing whitespace
" ########################
" Must be inserted before the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/


" Color Scheme
" ############
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget <colorscheme>
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
set t_co=256
" color wombat256mod
color badwolf

" Turn off HTML link underlining
" let g:badwolf_html_link_underline = 0

" Turn on CSS properties highlighting
" let g:badwolf_css_props_highlight = 1

" Enable Syntax Highlighting
" ##########################
" You need to reload this file for the change to apply
let python_highlight_all=1
syntax on

" Line Numbering and Length
" ###############################
set relativenumber
set number
set tw=79  " width of document
set nowrap " don't automatically wrap on load
set fo-=t  " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=16
" Map num/relativenum toggling to F-2
nmap <silent> <F2> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>

" PEP8 indentation
" ################
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" Full stack filetype indentation
" ###############################
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

" Search
" ######
" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase 

" Backup and Swap Files
" #####################
" Disable backup and swap files
" They trigger too many events for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Pathogen
" ########
" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
" call pathogen#infect()

" Powerline
" #########
" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2

" Folding
" #######
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" UTF8 Support
" ############
set encoding=utf-8

" Autocomplete
" ############
" ensure the autocomplete window goes away when done
let g:ycm_autoclose_preview_window_after_completion=1
" map goto definition to space-g
map <leader>g  :YcmCompleter GoToDefinition<CR>

" Virtualenv Support
" ##################
"python with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" File Browsing
" #############
" hide pyc files
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
" quit NERDTree if it's the only thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" NERDTree dir arrows compatible with putty
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"
" Toggle NERDTree with F10
map <F10> :NERDTreeToggle<CR>
" Current file in nerdtree
map <F9> :NERDTreeFind<CR>
