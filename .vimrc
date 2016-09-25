fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  let c.log_to_buf = 1
  let c.auto_install = 1
  let c.shell_commands_run_method = 'system'
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun

call SetupVAM()

filetype on
set hidden
let g:racer_cmd ="/home/dirvine/.cargo/bin/racer"
let $RUST_SRC_PATH="/home/dirvine/Devel/rust/src/"
call vam#ActivateAddons([
\'github:racer-rust/vim-racer',
\'github:tpope/vim-fugitive',
\'github:Shougo/neocomplete.vim',
\'github:kana/vim-operator-user',
\'github:mattn/gist-vim',
\'github:int3/vim-extradite',
\'github:kien/ctrlp.vim',
\'github:rust-lang/rust.vim',
\'github:vim-airline/vim-airline-themes',
\'github:bling/vim-airline',
\'github:zah/nimrod.vim',
\'github:terryma/vim-multiple-cursors',
\'github:jtratner/vim-flavored-markdown',
\'vim-signify',
\'github:proyvind/Cpp11-Syntax-Support',
\'delimitMate',
\'github:lambdatoast/elm.vim',
\'github:scrooloose/syntastic',
\'github:christoomey/vim-tmux-navigator',
\'github:vim-scripts/ZoomWin',
\'github:ternjs/tern_for_vim',
\'github:1995eaton/vim-better-javascript-completion',
\'github:SirVer/ultisnips',
\'github:ternjs/tern_for_vim',
\'github:helino/vim-json',
\'github:pangloss/vim-javascript',
\'github:rking/ag.vim',
\'github:moll/vim-node',
\'github:sidorares/node-vim-debugger',
\'github:honza/vim-snippets',
\'github:xolox/vim-session',
\'github:tomtom/tcomment_vim',
\'github:scrooloose/nerdtree',
\'github:oblitum/rainbow',
\'github:altercation/vim-colors-solarized'])


au BufNewFile,BufRead *.rs set filetype=rust
autocmd BufRead,BufNewFile Cargo.toml,Cargo.lock,*.rs compiler cargo | set makeprg=cargo | set errorformat=%f:%l:%m
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd QuickFixCmdPost *grep* cwindow "open quickfix after a grep
autocmd bufwritepost *.js silent !standard-format -w %
autocmd Filetype markdown setlocal wrap spell
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


"#########Autocompletion###########
let g:acp_enableAtStartup = 1
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 0

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.rust = '[^.[:digit:] *\t]\%(\.\|\::\)\%(\h\w*\)\?'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ###################  RUST  #########################

let RUST_SRC_PATH=$RUST_SRC_PATH
nnoremap <silent> <Leader>b :make build <CR> <bar> :copen <CR>
nnoremap <silent> <Leader>l :!rustup run nightly <CR> <bar> :make test --no-run --features clippy <CR> <bar> :copen <CR>
nnoremap <silent> <leader><Leader>l :make test --no-run --features clippy <CR> <bar> :copen <CR>
nnoremap <silent> <Leader>t :make test -- --nocapture <CR>
let g:rustfmt_autosave = 0
let g:rust_bang_comment_leader = 1
let g:rust_playpen_url = 'https://play.rust-lang.org/'
let g:rustmft_options = 'overwrite'
let g:ftplugin_rust_source_path = $HOME.'/Devel/rust'
let g:rust_conceal_mod_path = 1
let g:rust_shortener_url = 'https://is.gd/'
let g:rust_conceal = 1
let g:rustc_makeprg_no_percent = 1

" ################ Python ################

nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" remove all whitespace on every write
autocmd BufWritePre * :%s/\s\+$//e
let g:airline_theme='solarized'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_detect_paste=1
let g:airline#extensions#hunks#enabled = 1
let g:airline_powerline_fonts = 0
" After you've marked all your locations with Ctrl-n, you can change the visual selection with normal Vim motion commands in Visual mode. You could go to Normal mode
" by pressing v and wield your motion commands there. Single key command to switch to Insert mode such as c or s from Visual mode or i, a, I, A in Normal mode should
" work without any issues.
"
" At any time, you can press <Esc> to exit back to regular Vim.
"
" Two additional keys are also mapped:
"
" Ctrl-p in Visual mode will remove the current virtual cursor and go back to the previous virtual cursor location. This is useful if you are trigger happy with Ctrl-n
" and accidentally went too far.
" Ctrl-x in Visual mode will remove the current virtual cursor and skip to the next virtual cursor location. This is useful if you don't want the current selection to
" be a candidate to operate on later.
" ###################### nim ############################
fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
call GotoDefinition_{&filetype}()
  else
  exe "norm! \<C-]>"
  endif
  endf
" ########################################################
  " Jump to tag
  nn <M-g> :call JumpToDef()<cr>
  ino <M-g> <esc>:call JumpToDef()<cr>i

let g:ctags_statusline=1

set spelllang=en_gb


let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_disable_by_default = 0



let g:ctrlp_use_caching = 1
let g:ctrlp_max_files = 100000
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_switch_buffer = 0
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build*/
nnoremap <silent> <Leader>p :CtrlP <CR>
nmap ; :CtrlPBuffer<CR>
nmap <leader>a :CtrlPTag<CR>
nnoremap <silent> <Leader>n :set nonumber!<CR>

let g:syntastic_cpp_check_header = 0
" let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1 " Put errors on left side
let g:syntastic_auto_loc_list = 0 " Only show errors when I ask
" let g:syntastic_disabled_filetypes = ['html', 'js']
let g:syntastic_javascript_checkers = ['standard']
hi SpellBad ctermfg=007 ctermbg=000
hi SpellCap ctermfg=007 ctermbg=000
if has('unix')
  let g:syntastic_error_symbol='★'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='⚠'
  let g:syntastic_style_warning_symbol='>'
else
  let g:syntastic_error_symbol='!'
  let g:syntastic_style_error_symbol='>'
  let g:syntastic_warning_symbol='.'
  let g:syntastic_style_warning_symbol='>'
endif

" au FileType c,cpp,perl let b:delimitMate_eol_marker = ";"
au FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}"


let g:tmux_navigator_save_on_switch = 1

let g:UltiSnipsExpandTrigger = "<c-j>"
" let g:UltiSnipsListSnippets="<c-s-tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



let g:session_autosave = 'yes'
let g:session_autoload = 'no'

" Prevent :bd inside NERDTree buffer
au FileType nerdtree cnoreabbrev <buffer> bd <nop>
au FileType nerdtree cnoreabbrev <buffer> BD <nop>
au BufRead,BufNewFile *.md set filetype=markdown
" NERDTree settings
let NERDTreeChDirMode=0
let NERDTreeIgnore=['\env','>vim$', '\~$', '>pyc$', '>swp$', '>egg-info$', '>DS_Store$', '^dist$', '^build$']
let NERDTreeSortOrder=['^__>py$', '\/$', '*', '>swp$', '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeHightlight=1

let g:rainbow_active = 1
let g:rainbow_operators = 2
let g:rainbow_ctermfgs = [
            \ 'brown',
            \ 'Darkblue',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'darkmagenta',
            \ 'darkmagenta',
            \ 'Darkblue',
            \ 'darkgreen',
            \ 'darkcyan',
            \ 'darkred',
            \ 'red',
            \ ]

"###################### display settings ##########################
set textwidth=0
set wrapmargin=1
set wrap              " don't wrap lines
set linebreak
set nolist
set fo+=l
set scrolloff=2         " 2 lines above/below cursor when scrolling
set relativenumber
set number              " show line numbers
set showmatch           " show matching bracket (briefly jump)
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set wildmenu            " completion with menu
set wildignore=*.o,*.obj,*.bak,*.exe,*.py[co],*.swp,*~,*.pyc,.svn
set laststatus=2        " use 2 lines for the status bar
set matchtime=2         " show matching bracket for 0.2 seconds
set matchpairs+=<:>     " specially for html
set showtabline=0       " do not want to see how many files are open
set switchbuf=usetab       " switch to another window, possibly in another tab, if the buffer is currently displayed in another window

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set tabstop=2           " number of spaces a tab counts for
set shiftwidth=2       " spaces for autoindents
set expandtab           " turn a tabs into spaces
set foldnestmax=10
set foldlevel=1
set nofoldenable
set fileformat=unix     " file mode is unix
set cc=100              " set colourcolum at 100
"set fileformats=unix,dos    # only detect unix file format, displays that ^M with dos files
set noautochdir
" system settings
set lazyredraw          " no redraws in macros
set confirm             " get a dialog when :q, :w, or :wq fails
set nobackup            " no backup~ files.
set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo file'
set hidden              " remember undo after quitting
set history=100          " keep 100 lines of command history
set mouse=a             " use mouse in visual, normal,insert,command,help mode (shift key disables)
set ttymouse=xterm2
set undodir=~/.vim/undodir
set undofile
set undolevels=10000 "maximum number of changes that can be undone
set undoreload=100000 "maximum number lines to save for undo on a buffer reload
set incsearch
syntax on          " enable colors
set hlsearch       " highlight search (very useful!)
set incsearch       "search incremently (search while typing)
set splitright
set splitbelow

"######################### Function Key Mappings ####################
nmap <F2> :cnext <cr>
nmap <F3> :cprev <cr>
map <F4> :cclose <cr> :lclose <cr>
nmap <F5> :NERDTreeToggle  <CR>
nmap <F6> zi <cr>
nmap <F7> :setlocal spell! spelllang=en_gb<CR>
nnoremap j gj
nnoremap k gk
noremap gr :diffget //3<cr>
noremap gl :diffget //2<cr>
" " Add and delete spaces in increments of `shiftwidth' for tabs
" " Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//
" " Convert all tab characters to two spaces
command! Untab :%s/\t/  /g
"
" set switchbuf=useopen,usetab,newtab
"  map <C-t><up> :tabr<cr>
"  map <C-t><down> :tabl<cr>
"  map <C-t><left> :tabp<cr>
"  map <C-t><right> :tabn<cr>
"################### Miscellaneous ##########################################
if &term =~ "xterm\\|rxvt"
  " use an orange cursor in insert mode
  let &t_SI = "\<Esc>]12;yellow\x7"
  " use a red cursor otherwise
  let &t_EI = "\<Esc>]12;red\x7"
  " silent !echo -ne "\033]12;red\007"
   " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]112\007"
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufWinLeave *.* mkview!
au BufWinEnter *.* silent loadview

au BufWritePost *.* mksession! ~/session.vim
noremap <C-s> :source ~/session.vim

"#### EASY NAVIGATION IN INSERT MODE  ################################
noremap <A-j> <Left>
noremap <A-k> <Down>
noremap <A-l> <Up>
noremap <A-m> <Right>
inoremap <A-j> <Left>
inoremap <A-k> <Down>
inoremap <A-l> <Up>
inoremap <A-m> <Right>

"################### save on lost focus ###########################
au FocusLost * :wa
" save on lost focus/make etc.
set autoread autowrite
"######################### Easy window navigation #################
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"forgot to sudo before editing a file that requires root privileges
cmap w!! w !sudo tee % >/dev/null

let g:solarized_termcolors = 16
set t_Co=16
colorscheme solarized
set background=dark
