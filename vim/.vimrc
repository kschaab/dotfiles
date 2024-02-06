" Enable modern Vim features not compatible with Vi spec.
set nocompatible

syntax on

" Extend timeout for my slow brain to catch up
set timeoutlen=3000

" 
set tabstop=2 expandtab shiftwidth=2 smarttab

" Automatically change directory to the buffer's directory
autocmd BufWinEnter * lcd %:p:h

" Use system clipboards
set clipboard=unnamed,unnamedplus

" Set folding to syntax based
set foldmethod=syntax
set foldlevel=99

" Set column indiator
set colorcolumn=140

" Smart case sensitive search
set smartcase

" Visual paste keep yank
vnoremap <unique><silent> p p:let @"=@0<CR>:let @*=@0<CR>:let @+=@0<CR>

" Map leader to space
let mapleader=" "

set maxmempattern=3000

""""""""""""
"  Vundle  "
""""""""""""
set rtp+=$HOME/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasiser/vim-code-dark'
Plugin 'easymotion/vim-easymotion'
Plugin 'justinmk/vim-sneak'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'wesQ3/vim-windowswap'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'RRethy/vim-illuminate'

call vundle#end()
filetype on

"""""""""""""
"  Airline  "
"""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse=0
let g:airline#extensions#tabline#fnametruncate=0
let g:airline_theme = 'codedark'

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
nmap gT <Plug>AirlineSelectPrevTab
nmap gt <Plug>AirlineSelectNextTab

""""""""""""""
"  NerdTree  "
"""""""""""""""
" Open NERDTree in the directory of the current file (or /home if no file is open)
nmap <silent> <leader>o :call NERDTreeToggleInCurDir()<cr>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  elseif bufname('%')
    exe ":NERDTreeFind"
  else
    exe ":NERDTreeCWD"
  endif
endfunction
let NERDTreeQuitOnOpen=1

" Close if the nerdtree is the only open pane left in tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"""""""""""""
"  Markify  "
"""""""""""""
let g:markify_autocmd = 1
let g:markify_error_text = '>>'
let g:markify_warning_text = '>>'
let g:markify_info_text = '>>'

"""""""""""""
"  Signify  "
"""""""""""""

""""""""""""""
" easymotion "
""""""""""""""
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)m

" Gif config
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

""""""""""""
"  tagbar  "
""""""""""""

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set termguicolors

set number
set signcolumn=yes

" Highlight current line
set cursorline
hi CursorLine term=underline cterm=underline
hi CursorLineNr term=bold ctermfg=Yellow

set wildchar=<Tab> wildmenu wildmode=full
set history=1000 undolevels=1000


" Map next/prev error
nnoremap gq :cn<CR>
nnoremap gQ :cp<CR>

""""""""""
" Google "
""""""""""
if isdirectory('/usr/share/vim/google') 

  source /usr/share/vim/google/google.vim

  " Load the blaze plugins, with the ,b prefix on all commands.
  " Thus, to Blaze build, you can do <leader>bb.
  " Since we've set the mapleader to ',' above, this should be ,bb in practice
  Glug blaze plugin[mappings]='<leader>b'

  " Loads youcompleteme, the awesomest autocompletion engine.
  " See go/ycm for more details.
  Glug youcompleteme-google

  " GTImporter is a script that uses GTags to find and sort Java imports. This is
  " only useful for Java, so you will want to remove these lines if you don't use
  " Java. You can use with codefmt to auto-sort on write with:
  " autocmd FileType java AutoFormatBuffer gtimporter
  Glug gtimporter
  " Import the work under the cursor
  nnoremap <leader>si :GtImporter<CR>
  " Sort the imports in the (java) file
  nnoremap <leader>ss :GtImporterSort<CR>

  " Load the code formatting plugin. We first load the open-source version. Then,
  " we load the internal google settings. Then, we automatically enable formatting
  " when we write the file for Go, BUILD, proto, and c/cpp files.
  " Use :h codefmt-google or :h codefmt for more details.
  Glug codefmt
  Glug codefmt-google

  " Wrap autocmds inside an augroup to protect against reloading this script.
  " For more details, see:
  " http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
  augroup autoformat
    autocmd!
    " Autoformat BUILD files on write.
    autocmd FileType bzl AutoFormatBuffer buildifier
    " Autoformat go files on write.
    autocmd FileType go AutoFormatBuffer gofmt
    " Autoformat proto files on write.
    autocmd FileType proto AutoFormatBuffer clang-format
    " Autoformat c and c++ files on write.
    autocmd FileType c,cpp AutoFormatBuffer clang-format
  augroup END

  " Load the G4 plugin, which allows G4MoveFile, G4Edit, G4Pending, etc.
  " Use :h g4 for more details about this plugin
  Glug g4

  " Load the Related Files plugin. Use :h relatedfiles for more details
  Glug relatedfiles
  nnoremap <unique> <leader>rf :RelatedFilesWindow<CR>

  " Enable the corpweb plugin, which allows us to open codesearch from vim
  Glug corpweb
  " search in codesearch for the word under the cursor
  nnoremap <leader>ws :CorpWebCs <cword> <CR>
  " search in codesearch for the current file
  nnoremap <leader>wf :CorpWebCsFile<CR>

  " Load the Critique integration. Use :h critique for more details
  Glug critique

  nnoremap <Leader>O :PiperSelectActiveFiles<CR>
  nnoremap <Leader>a :!hg amend && hg uc<cr>
endif

nnoremap <C-h> <C-w><h>
nnoremap <C-j> <C-w><j>
nnoremap <C-k> <C-w><l>
nnoremap <C-l> <C-w><l>

nnoremap <Bslash> $

" Flow splits
set splitbelow
set splitright

" Incremental search
set incsearch

" Load all plugins before this line
filetype plugin indent on

set background=dark
colorscheme codedark

highlight link WintabsActive Visual

" Don't extend comment lines
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically redistribute windows on resize
autocmd VimResized * wincmd =

" Relative line numbers
set rnu

" Support modeline
set modelines=4

augroup illuminate_augroup
  autocmd!
  autocmd VimEnter * hi illuminatedWord guibg=#3A3F49
  autocmd VimEnter * hi illuminatedCurWord guibg=#3A3F49 cterm=underline gui=underline
augroup END

let &t_SI = "\<Esc>]50;CursorShape=2;BlinkingCursorEnabled=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0;BlinkingCursorEnabled=0\x7"
