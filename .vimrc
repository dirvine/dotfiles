fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 0})
endfun

call SetupVAM()


call vam#ActivateAddons(['github:tpope/vim-surround'])
call vam#ActivateAddons(['github:tpope/vim-dispatch'])
call vam#ActivateAddons(['github:tpope/vim-abolish'])
call vam#ActivateAddons(['github:tpope/vim-repeat'])
call vam#ActivateAddons(['github:terryma/vim-multiple-cursors'])
" ###################  RUST  #########################
call vam#ActivateAddons(['github:phildawes/racer'])
let g:racer_cmd = "/home/dirvine/racer/target/release/racer"
 let $RUST_SRC_PATH="/home/dirvine/Devel/rust/src"
call vam#ActivateAddons(['github:rust-lang/rust.vim'])
nnoremap <silent> <Leader>b :!cargo build <CR>
nnoremap <silent> <Leader>t :!cargo test <CR>
" ###################### nim ############################
call vam#ActivateAddons(['github:zah/nimrod.vim'])

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
" slow multiple_cursors &amp; YCM
function! Multiple_cursors_before()
  let g:ycm_auto_trigger = 0
  endfunction

function! Multiple_cursors_after()
  let g:ycm_auto_trigger = 1
  endfunction
call vam#ActivateAddons(['github:peterhoeg/vim-qml'])
call vam#ActivateAddons(['vimproc'])
" call vam#ActivateAddons(['github:vim-scripts/taglist.vim'])
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 50
" let Tlist_Auto_Highlight_Tag = 1
" let Tlist_Auto_Update = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_File_Fold_Auto_Close = 1
" let Tlist_Highlight_Tag_On_BufEnter = 1
" let Tlist_Use_Right_Window = 0
" let Tlist_Use_SingleClick = 1

let g:ctags_statusline=1

call vam#ActivateAddons(['github:jtratner/vim-flavored-markdown'])
set spelllang=en_gb
autocmd Filetype markdown setlocal wrap spell

" call vam#ActivateAddons(['TaskList'])
call vam#ActivateAddons(['vim-signify'])
let g:signify_vcs_list = [ 'git', 'hg' ]
let g:signify_disable_by_default = 0


call vam#ActivateAddons(['github:kana/vim-operator-user'])

call vam#ActivateAddons(['github:rhysd/vim-clang-format'])
let g:clang_format#auto_format = 1
let g:clang_format#auto_format_on_insert_leave = 1
let clang_format#command = '/usr/bin/clang-format-3.5'
let g:clang_format#detect_style_file = 0 

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
let g:clang_format#style_options = {
\"AccessModifierOffset": -1,
\"ConstructorInitializerIndentWidth": 4,
\"AlignEscapedNewlinesLeft": "true",
\"AlignTrailingComments": "true",
\"AllowAllParametersOfDeclarationOnNextLine": "true",
\"AllowShortIfStatementsOnASingleLine": "false",
\"AllowShortLoopsOnASingleLine": "false",
\"AlwaysBreakTemplateDeclarations": "true",
\"AlwaysBreakBeforeMultilineStrings": "true",
\"BreakBeforeBinaryOperators": "false",
\"BreakConstructorInitializersBeforeComma": "false",
\"BinPackParameters": "true",
\"ColumnLimit":     100,
\"ConstructorInitializerAllOnOneLineOrOnePerLine": "true",
\"Cpp11BracedListStyle": "true",
\"DerivePointerBinding": "false",
\"ExperimentalAutoDetectBinPacking": "false",
\"IndentCaseLabels": "true",
\"MaxEmptyLinesToKeep": 3,
\"NamespaceIndentation": "None",
\"ObjCSpaceBeforeProtocolList": "false",
\"PenaltyBreakComment": 60,
\"PenaltyBreakString": 1000,
\"PenaltyBreakFirstLessLess": 120,
\"PenaltyExcessCharacter": 1000000,
\"PenaltyReturnTypeOnItsOwnLine": 200,
\"PointerBindsToType": "true",
\"SpacesBeforeTrailingComments": 2,
\"SpacesInParentheses": "false",
\"SpacesInAngles": "false",
\"SpaceInEmptyParentheses": "false",
\"SpacesInCStyleCastParentheses": "false",
\"SpaceAfterControlStatementKeyword": "true",
\"Standard":        "Cpp11",
\"IndentWidth":     2,
\"UseTab":          "false",
\"BreakBeforeBraces": "Attach",
\"IndentFunctionDeclarationAfterType": "true",
\"Language": "Cpp"}

call vam#ActivateAddons(['github:mattn/webapi-vim']) " for gist

call vam#ActivateAddons(['github:mattn/gist-vim'])
"requires git config --global github.user Username

" call vam#ActivateAddons(['github:vimoutliner/vimoutliner'])

call vam#ActivateAddons(['github:int3/vim-extradite'])

call vam#ActivateAddons(['github:kien/ctrlp.vim'])
let g:ctrlp_use_caching = 1
let g:ctrlp_max_files = 100000
let g:ctrlp_clear_cache_on_exit = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/build*/
nnoremap <silent> <Leader>p :CtrlP <CR>
nmap ; :CtrlPBuffer<CR>
nnoremap <silent> <Leader>n :set nonumber!<CR>

call vam#ActivateAddons(['github:proyvind/Cpp11-Syntax-Support'])

" call vam#ActivateAddons(['github:jlanzarotta/bufexplorer'])
" nnoremap <leader>z :BufExplorerHorizontalSplit<CR>

call vam#ActivateAddons(['github:Valloric/YouCompleteMe'])
nnoremap <leader>j :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>h :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>c :YcmCompleter GoToDefinition<CR>
set ttimeoutlen=50 " for faster InsertLeave triggering
let g:ycm_extra_spacing = 0  " Controls spaces around function parameters
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_confirm_extra_conf = 0

call vam#ActivateAddons(['github:scrooloose/syntastic'])
let g:syntastic_cpp_check_header = 0
let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1 " Put errors on left side
let g:syntastic_auto_loc_list = 0 " Only show errors when I ask
let g:syntastic_disabled_filetypes = ['html', 'js']
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

call vam#ActivateAddons(['delimitMate'])
" au FileType c,cpp,perl let b:delimitMate_eol_marker = ";"
au FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}"


call vam#ActivateAddons(['github:ervandew/supertab'])
call vam#ActivateAddons(['github:SirVer/ultisnips'])
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
call vam#ActivateAddons(['github:honza/vim-snippets'])
" call vam#ActivateAddons(['github:vim-scripts/Conque-Shell'])
" let g:ConqueTerm_PyVersion = 3

call vam#ActivateAddons(['github:majutsushi/tagbar'])
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_zoomwidth = 0
let g:tagbar_autofocus = 1
let g:tagbar_show_visibility = 1
let g:tagbar_singleclick = 1
" let g:tagbar_previewwin_pos = "aboveleft"
" let g:tagbar_autopreview = 1


" call vam#ActivateAddons(['github:gilligan/vim-lldb'])
let g:lldb_map_Lnext = "<leader>n"
let g:lldb_map_Lstep = "<leader>s"

call vam#ActivateAddons(['github:szw/vim-tags'])
" Create an empty tags dir in project root"
let g:vim_tags_project_tags_command = "/usr/bin/ctags -R --sort=foldcase --c++-kinds=+p --fields=+IaS --extra=+q /home/dirvine/Devel/MaidSafe-dirvine/src 2>/dev/null"
let g:vim_tags_use_language_field = 1

let g:vim_tags_auto_generate = 1
let g:vim_tags_ignore_files = ['.gitignore', '.svnignore', '.cvsignore', 'build*']
let g:vim_tags_main_file = 'tags'

nmap <A-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nmap <C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

call vam#ActivateAddons(['github:tpope/vim-fugitive'])

" call vam#ActivateAddons(['github:xolox/vim-session'])
" let g:session_autosave = 'yes'
" let g:session_autoload = 'no'

 call vam#ActivateAddons(['github:tomtom/tcomment_vim'])

call vam#ActivateAddons(['github:scrooloose/nerdtree'])
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
"
call vam#ActivateAddons(['github:Lokaltog/vim-easymotion'])
nmap <Space>w <Plug>(easymotion-w)

call vam#ActivateAddons(['github:altercation/vim-colors-solarized'])
let g:solarized_termcolors = 16
syntax enable
set t_Co=16
set background=dark
colorscheme solarized
call vam#ActivateAddons(['github:oblitum/rainbow'])
let g:rainbow_active = 1
let g:rainbow_operators = 2
let  g:rainbow_ctermfgs = [
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
call vam#ActivateAddons(['github:terryma/vim-multiple-cursors'])

" call vam#ActivateAddons(['github:wesleyche/SrcExpl'])

"call vam#ActivateAddons(['github:wesleyche/Trinity'])
let g:SrcExpl_pluginList = [  "__Tag_List__", "[BufExplorer]",  "Source_Explorer"," _NERD_tree_"  ]
let g:SrcExpl_isUpdateTags = 0
" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100
"
"################### C++ ##########################################
au FileType cpp,objcpp set syntax=cpp11
au BufNewFile,BufRead *
\ if expand('%:e') =~ '^\(h\|hh\|hxx\|hpp\|ii\|ixx\|ipp\|inl\|txx\|tpp\|tpl\|cc\|cxx\|cpp\)$' |
\   if &ft != 'cpp'                                                                           |
\     set ft=cpp                                                                              |
\   endif                                                                                     |
\ endif                                                                                       |

au FileType c,cpp,objc,objcpp call rainbow#activate()
autocmd BufRead *.lyx set syntax=lyx foldmethod=syntax foldcolumn=3
autocmd BufRead *.lyx syntax sync fromstart

" set makeprg=clang++\ -std=c++11\ -o\ %<\ %


call vam#ActivateAddons(['github:xuhdev/SingleCompile'])
" nmap <F9> :SCCompile<cr> 
" nmap <F10> :SCCompileRun<cr>
call SingleCompile#ChooseCompiler('cpp', 'clang')
autocmd Filetype cpp nmap <buffer> <F9> :SCCompileAF -std=c++11 <CR>
autocmd Filetype cpp nmap <buffer> <F10> :SCCompileRunAF -std=c++11 <CR>

augroup csrc
  au!
  autocmd FileType * set nocindent smartindent
  autocmd FileType c,cpp,cc  set cindent
  au BufNewFile,BufRead *.cpp,*.cc.,*.h,*.hpp set syntax=cpp11
augroup END

set errorformat^=%-GIn\ file\ included\ %.%#
set path=../src/*/include,../src/*/src/,../src/,../src/third_party_libs/boost/,../src/,/usr/include/

"###################### display settings ##########################
set textwidth=0
set wrapmargin=1
set wrap              " don't wrap lines
set linebreak
set nolist
set fo+=l
set scrolloff=2         " 2 lines above/below cursor when scrolling
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

" editor settings
set esckeys             " map missed escape sequences (enables keypad keys)
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
set smartindent         " smart auto indenting
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode

set tabstop=2           " number of spaces a tab counts for
set shiftwidth=2        " spaces for autoindents
set expandtab           " turn a tabs into spaces

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
set undodir=~/.vim/undodir
set undofile
set undolevels=10000 "maximum number of changes that can be undone
set undoreload=100000 "maximum number lines to save for undo on a buffer reload
set incsearch
syntax on          " enable colors
set hlsearch       " highlight search (very useful!)
set incsearch       "search incremently (search while typing)

" ################### FOLDING #############################################
augroup vimrc
  au BufReadPre * setlocal foldmethod=syntax
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" set fdm=syntax 
set foldlevel=2
au BufRead * normal zi
"######################### Function Key Mappings ####################
nmap <F2> :cnext <cr>
nmap <F3> :cprev <cr>
map <F4> :TagbarToggle <cr>
nmap <F5> :NERDTreeToggle  <CR>
nmap <F6> zi <cr>
set tags=tags;
map <C-> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F7> :setlocal spell! spelllang=en_gb<CR>
nmap <F8> :Lhide backtrace<CR> :Lhide breakpoints<CR> :Lhide disassembly<CR> :Lhide locals<CR> :Lhide registers<CR> :Lhide threads<CR>
nmap <F11> :TagsGenerate <CR>
nnoremap j gj
nnoremap k gk
" open quickfix after a grep
autocmd QuickFixCmdPost *grep* cwindow
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

"## ctr R for search and replace in visual mode
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>"
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
"####################### Status Line ##############################
set statusline=
set statusline+=%{fugitive#statusline()}
set statusline+=[%n]                                  "buffernr
set statusline+=%<%F\                                "File+path
set statusline+=\ %y\                                  "FileType
set statusline+=\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=\ col:%03c\                            "Colnr
set statusline+=\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
