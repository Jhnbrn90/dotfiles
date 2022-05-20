set nocompatible " Be iMproved!
" Vundle configuration
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'cormacrelf/vim-colors-github'
Plugin 'joshdick/onedark.vim'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-rooter'
Plugin 'tpope/vim-surround'
call vundle#end()
" Editor configuration
filetype plugin indent on " Detect file types for plugin loading
syntax on " Syntax highlighting
set number " Line numbers
set smartindent " Automatically indent pasted code
set tabstop=4 shiftwidth=4 " Indent with four spaces
set expandtab " Convert tabs to spaces
set clipboard=unnamedplus " Use the system clipboard by default
set scrolloff=5 " Scroll offset
set incsearch " Incremental searching
set hlsearch " Highlight all results
set history=1000 " Remember more commands and search history
set undolevels=1000 " Use many levels of undo
nnoremap W <C-w><C-w>
imap jj <Esc>
" Colorscheme configuration
" set background=light
set termguicolors
colorscheme onedark
" Nerdtree configuration
autocmd vimenter * NERDTree | wincmd w " Open the tree on startup and move focus to the file buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " Close the tree if it is the only remaining buffer
nnoremap N :NERDTreeToggle<CR>
" Airline configuration
let g:airline_theme = "github"
let g:lightline = { 'colorscheme': 'github' }
let g:airline_powerline_fonts=1
let g:Powerline_symbols='fancy'
" Syntastic configuration
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_javascript_checkers=['eslint'] " Use ESLint for JavaScript linting
" Search configuration
if executable('ag')
 " Use `ag` in Ctrl-P for listing files (fast and respects `.gitignore`)
 let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore .git --ignore **/*.pyc -g ""'
 " `ag` is fast enough that Ctrl-P does not need to cache
 let g:ctrlp_use_caching = 0
 " Use `ag` instead of `grep` for regular search queries
 set grepprg=ag\ --nocolor\ --vimgrep
 " Allow using the `\` key or the `Ag` command to find usages of any given word
 command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
 nnoremap \ :Ag<SPACE>
 " Allow using the `F` key to find usages of the word under the cursor
 nnoremap F :grep! "<C-R><C-W>"<CR>:cw<CR>
endif
" Make configuration (to show errors automatically in a subwindow)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost l* nested lwindow

