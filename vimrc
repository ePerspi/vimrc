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

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

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

"Keep 8 chars tab for make files
if has("autocmd")
        filetype plugin indent on
        autocmd Filetype make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
endif

"Replace tabs with 4 spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"Whitespaces
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣

"STATUSLINE
" set ruler
" set laststatus=2

" set statusline=%{fugitive#statusline()}
" file encoding
" set statusline+=\ %{(&fenc!=''?&fenc:&enc)}
" file name
" set statusline+=\ %f
" last print time
" set statusline+=%=%{strftime(\"%c\",getftime(expand(\"%:p\")))}
" line counter
" set statusline+=%=\ \ \ %l/%L

"Plugins to load at vim start
"autocmd vimenter

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"Plugins
call plug#begin('/usr/share/vim/plugged')

"Minimap
Plug 'severin-lemaignan/vim-minimap'

"NERDTree tree file explorer
Plug 'scrooloose/nerdtree'

"NERDTree git flags
Plug 'Xuyuanp/nerdtree-git-plugin'

"Git wrapper
Plug 'tpope/vim-fugitive'

"Vim repeat
Plug 'tpope/vim-repeat'

"Vim surround
Plug 'tpope/vim-surround'

"Vim commentary
Plug 'tpope/vim-commentary'

"Vim unimpaired
Plug 'tpope/vim-unimpaired'

"Colorschemes
Plug 'vim-scripts/burnttoast256'

"Ctags generator
Plug 'szw/vim-tags'

"Autoclose
Plug 'Townk/vim-autoclose'

"Indent object
Plug 'michaeljsmith/vim-indent-object'

"Indent movement
Plug 'jeetsukumaran/vim-indentwise'

"Autocomplete
Plug 'maralla/completor.vim'

"Search counter
Plug 'vim-scripts/IndexedSearch'

"Tagbar
Plug 'majutsushi/tagbar'

"Statusline style
Plug 'vim-airline/vim-airline'

"Syntastic
Plug 'vim-syntastic/syntastic'

call plug#end()

hi String ctermfg=204

"Airline customizations
let g:airline_section_y = "%{strftime(\"%c\",getftime(expand(\"%:p\")))}"
let g:airline_section_z = '%l/%L'

"Syntastic customizations
let g:syntastic_python_python_exec = '/usr/bin/python3'

"NERDTree toggle shortcut
map <F6> :NERDTreeToggle<CR>

"Minimap toggle shortcut
map \mini :MinimapToggle<CR>

"Run python script
map \py3 :! python3 %<CR>
map \py2 :! python %<CR>

"Tagbar
nmap <F8> :TagbarToggle<CR>

"YankRing
nmap <silent> <F7> :YRShow<CR>
