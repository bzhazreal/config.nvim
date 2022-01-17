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

set mouse=a                                 " Enable mouse support

set noswapfile                              " Disable swap files
set encoding=UTF-8

" -----------------------------------------------------------------------------
" Autocommand on writing buffer
" -----------------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e          " Remove trailing spaces on file write (:w)

" -----------------------------------------------------------------------------
" Vim Plug plugin list
" -----------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

" Theming plugin
" --------------
Plug 'joshdick/onedark.vim'
Plug 'nvim-treesitter/nvim-treesitter'

" Git plugin
" ----------
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" IDE feature plugin
" ------------------
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'preservim/nerdcommenter'

" Coc Nvim
" --------
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Python plugins
" --------------
" Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
call plug#end()

" -----------------------------------------------------------------------------
" Coc nvim configuration
" -----------------------------------------------------------------------------
let g:coc_global_extensions = [
            \'coc-json',
            \'coc-html',
            \'coc-pyright',
            \'coc-markdownlint',
            \'coc-pairs',
            \'coc-tsserver',
            \'coc-docker'
            \]

" pydocstring
" let g:pydocstring_doq_path = '~/.config/coc/extensions/coc-pydocstring-data/doq/venv/bin/doq'

" -----------------------------------------------------------------------------
" Theme comfiguration
" -----------------------------------------------------------------------------
if filereadable(expand('~/.vim/plugged/onedark.vim/autoload/lightline/colorscheme/onedark.vim'))
    syntax on                                   " Enable symtax coloration
    colorscheme onedark                         " Set onedark as vim theme
endif

" One dark specific configurations :
" https://github.com/joshdick/onedark.vim
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
if filereadable(expand('~/.vim/plugged/nerdtree/autoload/nerdtree.vim'))
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
    let NERDTreeShowHidden=1
endif

" -----------------------------------------------------------------------------
" Shortcut configuration
" -----------------------------------------------------------------------------

" Map leader
" ----------
let mapleader=','

" Tabs
" ----
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>
nnoremap <silent> <S-d> :tabclose<CR>

" Split
" -----
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Telescope shortcut
" ------------------
nnoremap <leader>ff <cmd>Telescope find_files<CR>
nnoremap <leader>fg <cmd>Telescope live_grep<CR>
nnoremap <leader>fb <cmd>Telescope buffers<CR>
nnoremap <leader>fh <cmd>Telescope help_tags<CR>

" Split
" -----
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

