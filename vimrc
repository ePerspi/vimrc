" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch	" Show matching brackets.
set ignorecase	" Do case insensitive matching
set smartcase	" Do smart case matching
set incsearch	" Incremental search
set autowrite	" Automatically save before commands like :next and :make
set hidden		" Hide buffers when they are abandoned
"set mouse=a	" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

"Autoload files
set autoread

"Create undofile
set undofile

"Show line numbers
set number
"Show relative line numbers
set relativenumber

"Replace tabs with 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Keep 8 chars tab for make files
if has("autocmd")
        filetype plugin indent on
        autocmd Filetype make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

"Whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Encoding
set encoding=utf-8

""Plugins
call plug#begin('~/.vim/plugged')

"NERDTree tree file explorer
Plug 'scrooloose/nerdtree'

"NERDTree git flags
Plug 'Xuyuanp/nerdtree-git-plugin'

"Vim repeat
Plug 'tpope/vim-repeat'

"Vim surround
Plug 'tpope/vim-surround'

"Vim commentary
Plug 'tpope/vim-commentary'

"Vim unimpaired
Plug 'tpope/vim-unimpaired'

"Autoclose
Plug 'Townk/vim-autoclose'

"Indent object
Plug 'michaeljsmith/vim-indent-object'

"Indent movement
Plug 'jeetsukumaran/vim-indentwise'

"Search counter
Plug 'vim-scripts/IndexedSearch'

"Tagbar
Plug 'majutsushi/tagbar'

"Black Python auto-format
Plug 'psf/black'

"PEP 8 check
Plug 'nvie/vim-flake8'

"CSV reader
Plug 'chrisbra/csv.vim'

"Status line
Plug 'vim-airline/vim-airline'

call plug#end()

"NERDTree toggle shortcut
map <F6> :NERDTreeToggle<CR>

"On save
autocmd BufWritePre *.py execute ':Black'
autocmd BufWritePost *.py call flake8#Flake8()
