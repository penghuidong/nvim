"==============================================================================
" vim 内置配置 
"==============================================================================

" 设置 vimrc 修改保存后立刻生效，不用在重新打开
" 建议配置完成后将这个关闭
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 关闭兼容模式
set nocompatible

set nu " 设置行号
set cursorline "突出显示当前行
"set cursorcolumn " 突出显示当前列
set showmatch " 显示括号匹配

" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释

set expandtab       " 将 Tab 转换为空格
set tabstop=4       " 设置一个 Tab 显示为 4 个空格
set shiftwidth=4    " 设置自动缩进时使用 4 个空格
set softtabstop=4   " 按退格键时，删除 4 个空格

" 高亮搜索
set hlsearch
" 定义快捷键的前缀，即<Leader>
let mapleader=";" 

" ==== 系统剪切板复制粘贴 ====
" v 模式下复制内容到系统剪切板
vmap <Leader>c "+yy
" n 模式下复制一行到系统剪切板
nmap <Leader>c "+yy
" n 模式下粘贴系统剪切板的内容
nmap <Leader>v "+p

" 开启实时搜索
set incsearch
" 搜索时大小写不敏感
set ignorecase
set smartcase

set autoread " 当文件在外部被修改时自动读取
syntax enable
syntax on                    " 开启文件类型侦测
filetype plugin indent on    " 启用自动补全

" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php write

" 插件开始的位置
call plug#begin('~/.vim/plugged')

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" 可以快速对齐的插件
Plug 'junegunn/vim-easy-align'

" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
Plug 'vim-airline/vim-airline'
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ayu-theme/ayu-vim' " 主题插件
Plug 'joshdick/onedark.vim' " 主题插件

Plug 'vim-scripts/a.vim'

" 插件结束的位置，插件全部放在此行上面
call plug#end()
" 禁用 Auto-Pairs 的 Enter 键映射
let g:AutoPairsMapCR = 0

" gr命令调用coc-references插件
nmap gr <Plug>(coc-references)
"colorscheme desert
"colorscheme onedark
colorscheme koehler

inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"

" 在保存文件时自动运行 gofmt
" autocmd BufWritePre *.go :silent! execute '!gofmt -w %'

" 自动跳转到上次退出位置
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   execute "normal! g`\"" |
        \ endif
endif



" 保存光标位置并执行搜索
""function! SearchNoJump()
""    let save_pos = getpos('.')      " 保存当前光标位置
""    let pattern = input('Search: ') " 获取搜索内容
""    if pattern != ''
""        let @/ = pattern            " 设置搜索寄存器
""        set hlsearch                " 启用高亮
""    endif
""    call setpos('.', save_pos)      " 恢复光标位置
""endfunction

" 映射 / 和 ? 到自定义函数
""nnoremap <silent> / :call SearchNoJump()<CR>
""nnoremap <silent> ? :call SearchNoJump()<CR>

" 自动检测并刷新文件内容
set autoread

" 自动补全括号
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>

" 设置搜索高亮颜色
highlight Search guifg=black guibg=yellow ctermfg=0 ctermbg=3
highlight IncSearch guifg=white guibg=red ctermfg=7 ctermbg=1
