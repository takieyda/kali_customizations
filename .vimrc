" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
    \| PlugInstall --sync | source $MYVIMRC
    \| endif

call plug#begin()
    Plug 'thaerkh/vim-indentguides'
    Plug 'scrooloose/nerdtree'
    Plug 'vim-scripts/AutoComplPop'
    Plug 'dracula/vim',{'as':'dracula'}
call plug#end()


if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif


" Theme related
let g:airline#extensions#tabline#enabled=1  " Top line showing tabes of open files
let g:airline_skip_empty_sections=1         " Collapses empty bottom row sections
let g:airline_powerline_fonts=1             " Powerline like fonts and symbols
let g:airline_section_z = airline#section#create(
    \ ['windowswap', '%p%% ', 'linenr','maxlinenr',':%v'])    " 
let g:airline_theme='dracula'               " Set theme
set background=dark                         " For compatibility with tmux
"packadd! dracula
"colorscheme dracula

" Basic Settings
syntax on                  " Syntax highlighting on
filetype plugin indent on  " Filetype detection, syntax highlighting, indenting on

set laststatus=2           " Bottom row always visible
set number                 " Show line numbers
set incsearch              " Incremental search, starts search as typed
set hlsearch               " Highlight search, highlights matching results
set expandtab              " Tab replacedwith  the appropriate number of spaces
set tabstop=4              " Tab set to 4 spaces
set shiftwidth=4           " Indention amount for < and > commands
set mouse=a                " Mouse text select, no line numbers, and pane resizinge
set showmatch              " Show matching (,{ when ),} is entered
set ignorecase             " Case insensitive search
set clipboard=unnamedplus  " Allows for yanking to clipboard
set splitbelow splitright  " Split window either below or right of current pane
set cursorline             " Horizontal line on screen where cursor is


" AutoComplPop Settings
set complete+=kspell
set completeopt=menuone,preview


" NERDTree Configuration
nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
nnoremap <C-k>nf :NERDTreeFind<CR>
" NERDTree open on vim open
augroup nerdtree_open
    autocmd!
    autocmd VimEnter * NERDTreeCWD | wincmd p
augroup END
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['.git']
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"

autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" https://github.com/preservim/nerdtree/issues/21#issuecomment-907483
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
    if exists("t:NERDTreeBufName")
        if bufwinnr(t:NERDTreeBufName) != -1
            if winnr("$") == 1
                q
            endif
        endif
    endif
endfunction


let g:indentguides_spacechar = '▏' "'┆'
let g:indentguides_tabchar = '|'
autocmd WinEnter * IndentGuidesToggle
