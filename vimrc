call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'lifepillar/vim-solarized8'
Plug 'rakr/vim-one'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'Yggdroot/LeaderF', {'do' : 'install.sh'}
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'Yggdroot/indentLine'
Plug 'Chiel92/vim-autoformat'
Plug 'honza/vim-snippets'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'universal-ctags/ctags'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'brooth/far.vim'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'pangloss/vim-javascript'
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server'}
call plug#end()

let mapleader=" "
inoremap jj <Esc>
autocmd FileType php,python,c,bash,javascript,typescript,cpp set ai
autocmd FileType php,python,c,bash,javascript,typescript,cpp set sw=4
autocmd FileType php,python,c,bash,javascript,typescript,cpp set ts=4
autocmd FileType php,python,c,bash,javascript,typescript,cpp set sts=4
autocmd FileType html,css,xml set ai
autocmd FileType html,css,xml set sw=2
autocmd FileType html,css,xml set ts=2
autocmd FileType html,css,xml set sts=2

"检查文件类型
filetype indent on
"设置行号
set nu
"不与vi兼容
set nocompatible
"可修改
set modifiable
"设置系统粘贴板为默认的粘贴板
set clipboard=unnamedplus
"自动转换粘贴模式
let &t_SI .= "\[?2004h"
let &t_EI .= "\[?2004l"
inoremap   [200~ XTermPasteBegin()
function! XTermPasteBegin()
    set pastetoggle=[201~
    set paste
    return ""
endfunction
"高亮
syntax on
set background=dark
set termguicolors

if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif
if (has('termguicolors'))
  set termguicolors
endif

let g:material_terminal_italics = 0
let g:material_theme_style = 'palenight-community'
colorscheme solarized8
let g:airline_theme='one'
"设置背景透明，必须放在colorscheme语句后面,否则会失效
"hi Normal ctermbg=none guibg=none

"在底部显示，当前处于命令模式还是插入模式
set showmode
"设置默认编码
set encoding=utf-8
"自动缩进
set autoindent
"tab换空格
set expandtab
"tab后的空格数
set shiftwidth=4
"光标所在的当前航高亮
set cursorline
"光标遇到圆括号、方括号、大括号时，自动高亮对应的另一个圆括号、方括号和大括号
set showmatch
"搜索时，高亮显示匹配结果
set hlsearch
"输入搜索模式时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch
"搜索时忽略大小写
set ignorecase
"打开英语单词的拼写检查
"set spell spelllang=en_us
"不创建备份文件
set nobackup

"ccls配置
"suggest.autoTrigger": "trigger"
"suggest.triggerAfterInsertEnter": true
"suggest.timeout": 500,
"suggest.minTriggerInputLength": 2
"suggest.snippetIndicator": "►"

"生成compile_commands.json
"nnoremap <Leader>cj :!cmake -H. -BDebug -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES && ln -sf Debug/compile_commands.json .

let g:LanguageClient_serverCommands = {
    \ 'sh': ['bash-language-server', 'start']
    \ }

"coc.nvim配置
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ 'coc-html',
    \ 'coc-tsserver',
    \ 'coc-vetur',
    \]
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"tab选择补全项
inoremap <silent><expr> <TAB>
	    \ pumvisible() ? "\<C-n>" :
	    \ <SID>check_back_space() ? "\<TAB>" :
	    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
    else
	call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <Leader>f  <Plug>(coc-format-selected)
nmap <Leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<Leader>aap` for current paragraph
xmap <Leader>a  <Plug>(coc-codeaction-selected)
nmap <Leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <Leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <Leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"easymotion config
nmap ss <Plug>(easymotion-s2)

"Shougo defx
" 使用 ;e 切换显示文件浏览，使用 ;a 查找到当前文件位置
let g:maplocalleader=';'
nnoremap <silent> <LocalLeader>e
	    \ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()` <CR>
nnoremap <silent> <LocalLeader>a
	    \ :<C-u>Defx -resume -buffer-name=tab`tabpagenr()` -search=`expand('%:p')`<CR>

call defx#custom#option('_', {
	    \ 'columns': 'indent:git:icons:filename',
	    \ 'winwidth': 30,
	    \ 'split': 'vertical',
	    \ 'direction': 'topleft',
	    \ 'show_ignored_files': 0,
	    \ 'root_marker': '≡ ',
	    \ 'ignored_files':
	    \     '.mypy_cache,.pytest_cache,.git,.hg,.svn,.stversions'
	    \   . ',__pycache__,.sass-cache,*.egg-info,.DS_Store,*.pyc,*.swp'
	    \ })

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> c
		\ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
		\ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
		\ defx#do_action('paste')
    " nnoremap <silent><buffer><expr> i
    "             \ defx#do_action('multi',[['drop','split']])
    nnoremap <silent><buffer><expr> o
		\ defx#is_directory() ?
		\ defx#do_action('open_or_close_tree') :
		\ defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> K
		\ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
		\ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
		\ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
		\ defx#do_action('toggle_columns',
		\                'mark:indent:icon:filename:type:size:time')
    "    nnoremap <silent><buffer><expr> S
    "                \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
		\ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
		\ defx#do_action('rename')
    nnoremap <silent><buffer><expr> yy
		\ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
		\ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> h
		\ defx#do_action('close_tree')
    nnoremap <silent><buffer><expr> <Space>
		\ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
		\ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
		\ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
		\ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
		\ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
		\ defx#do_action('print')
endfunction
let g:defx_icons_enable_syntax_highlight = 1

" astyle
let g:formatdef_raysuner = '"astyle --style=ansi --pad-oper"'
let g:formatters_cpp = ['raysuner']
let g:formatters_c = ['raysuner']
nnoremap <F3> :Autoformat<CR>
inoremap <F3> <Esc>:Autoformat<CR>

"asynctask.vim
nnoremap <silent> <Leader>w :ccl<CR>
let g:asyncrun_open = 12
" let g:asynctasks_term_focus = 0
let g:asynctasks_term_pos = 'tab'
let g:asyncrun_rootmarks = ['.git', '.svn', '.root', '.project', '.hg']
noremap <silent><f8> :AsyncTask file-run<cr>
noremap <silent><f9> :AsyncTask file-build<cr>
noremap <silent><Leader>as :AsyncStop<CR>

"vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1

let g:python_host_prog = "/usr/bin/python2"
let g:python3_host_prog = "/usr/bin/python3"

"tagbar
nnoremap <Leader>t :TagbarToggle<CR>

"ctrlp
let g:ctrlp_map = '<c-p>'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\cmake-build-debug|\.(git|hg|svn|ccls-cache|idea)$',
  \ 'file': '\v\.(exe|so|dll|ccls|ccls-root)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'   " MacOSX/Linux
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -l -nocolor --hidden -g ""'
else
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

"emmet
let g:user_emmet_mode='i' "只能在插入模式下使用
let g:user_emmet_install_global = 0  "只能在html和css的情况下使用
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key=','

"prettier
nmap <Leader>p <Plug>(Prettier)
let g:prettier#autoformat_require_pragma = 0
au FileType css,scss let b:prettier_exec_cmd = "prettier-stylelint"

"bracey
nnoremap <Leader>b :Bracey<CR>
