" -----------------------------------------------------------------------------
" Vim initialization
" -----------------------------------------------------------------------------

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" -----------------------------------------------------------------------------
" General configuration
" -----------------------------------------------------------------------------
set number                                  " Display line number
set linebreak                               " Break lines at word
set showbreak=+++                           " Wrap-broken line prefix
set textwidth=100                           " Line wrap (number of cols)
set showmatch                               " Highlight matching brace
set ruler                                   " Show row and column ruler information

set hlsearch                                " Highlight all search results
set smartcase                               " Enable smart-case search
set ignorecase                              " Always case-insensitive
set incsearch                               " Searches for strings incrementally

set autoindent                              " Auto-indent new lines
set expandtab                               "
set shiftwidth=4                            " Number of auto-indent spaces
set smartindent                             " Enable smart-indent
set smarttab                                " Enable smart-tabs
set softtabstop=4                           " Number of spaces per Tab
set backspace=indent,eol,start              " Backspace behaviour

" -----------------------------------------------------------------------------
" Autoclosing characters
" -----------------------------------------------------------------------------
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" -----------------------------------------------------------------------------
" Autocommand on writing buffer
" -----------------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e          " Remove trailing spaces on file write (:w)

" -----------------------------------------------------------------------------
" Vim Plug plugin list
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')           " Vim plug start dependancies plugin declaration

" IDE plugin
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'davidhalter/jedi-vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

call plug#end()                             " Vim plug end dependancies plugin declaration

" -----------------------------------------------------------------------------
" Theme comfiguration
" -----------------------------------------------------------------------------
syntax on                                   " Enable symtax coloration
colorscheme onedark                         " Set onedark as vim theme

"One dark specific configurations :
"https://github.com/joshdick/onedark.vim
if (has("termguicolors"))
  set termguicolors
endif

" -----------------------------------------------------------------------------
" Lightline configuration
" -----------------------------------------------------------------------------
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

" -----------------------------------------------------------------------------
" nerdtree configuration
" -----------------------------------------------------------------------------
" start nerdtree and leave the cursor in it.
autocmd vimenter * NERDTree
" start nerdtree and put the cursor back in the other window.
autocmd vimenter * NERDTree | wincmd p
" start nerdtree when vim is started without file arguments.
autocmd stdinreadpre * let s:std_in=1
autocmd vimenter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" exit vim if nerdtree is the only window remaining in the only tab.
autocmd bufenter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" close the tab if nerdtree is the only window remaining in it.
autocmd bufenter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" open the existing nerdtree on each new tab.
autocmd bufwinenter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" -----------------------------------------------------------------------------
" Shortcut configuration
" -----------------------------------------------------------------------------

"" Map leader
let mapleader=','

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-d> :tabclose<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
