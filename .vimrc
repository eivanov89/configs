"----------------------------------------------------------- BEGIN of VUNDLE STUFF

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"----------------------------------------------------------- END of VUNDLE STUFF

map <Tab> :b#<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <Leader>b :make<CR>
nnoremap <Leader>c :cope<CR>
nnoremap <Leader>g :YcmCompleter GoTo<CR>
nnoremap <Leader>t  :YcmCompleter GetType<CR>
nnoremap <Leader>p  :YcmCompleter GetParent<CR>
nnoremap <Leader>l :set colorcolumn=80<CR>
nnoremap <Leader>lo :set colorcolumn=0<CR>

nnoremap <Up>     <NOP>
nnoremap <Down>   <NOP>
nnoremap <Left>   <NOP>
nnoremap <Right>  <NOP>

" Alt + left/right
"nmap <Esc>[1;3D :call TabManagment_tab_prev()<CR>
"nmap <Esc>[1;3C :call TabManagment_tab_next()<CR>
nmap <F9>  :call TabManagment_tab_prev()<CR>
nmap <F10> :call TabManagment_tab_next()<CR>

au FileType c set makeprg=tbm
au FileType cpp set makeprg=tbm

syntax on

set smartindent
set expandtab 
set softtabstop=4
set shiftwidth=4

set guioptions-=T
set vb t_vb=
set ruler

set showmatch " jump to the another bracket, when bracket is inserted
set hls
set incsearch " 'partial' search (no word boundaries)

set autowrite
set backspace=2 " make backspace work like most other apps
set pastetoggle=<F2> " Easily copy from clipboard

set fileencodings=utf-8

" Disable preview window
set completeopt-=preview

let g:localvimrc_ask=0

let g:ycm_extra_conf_globlist = '/home/eiva'
let g:ycm_confirm_extra_conf = 0
let g:ycm_show_diagnostics_ui = 0

" Задаем собственные функции для назначения имен заголовкам табов -->
    function MyTabLine()
        let tabline = ''

        " Формируем tabline для каждой вкладки -->
            for i in range(tabpagenr('$'))
                " Подсвечиваем заголовок выбранной в данный момент вкладки.
                if i + 1 == tabpagenr()
                    let tabline .= '%#TabLineSel#'
                else
                    let tabline .= '%#TabLine#'
                endif

                " Устанавливаем номер вкладки
                let tabline .= '%' . (i + 1) . 'T'

                " Получаем имя вкладки
                let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
            endfor
        " Формируем tabline для каждой вкладки <--

        " Заполняем лишнее пространство
        let tabline .= '%#TabLineFill#%T'

        " Выровненная по правому краю кнопка закрытия вкладки
        if tabpagenr('$') > 1
            let tabline .= '%=%#TabLine#%999XX'
        endif

        return tabline
    endfunction

    function MyTabLabel(n)
        let label = ''
        let buflist = tabpagebuflist(a:n)

        " Имя файла и номер вкладки -->
            let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

            if label == ''
                let label = '[No Name]'
            endif

            let label .= ' (' . a:n . ')'
        " Имя файла и номер вкладки <--

        " Определяем, есть ли во вкладке хотя бы один
        " модифицированный буфер.
        " -->
            for i in range(len(buflist))
                if getbufvar(buflist[i], "&modified")
                    let label = '[+] ' . label
                    break
                endif
            endfor
        " <--

        return label
    endfunction

    function MyGuiTabLabel()
        return '%{MyTabLabel(' . tabpagenr() . ')}'
    endfunction

    set tabline=%!MyTabLine()
    set guitablabel=%!MyGuiTabLabel()
" Задаем собственные функции для назначения имен заголовкам табов <--


function! TabManagment_tab_next()
    if tabpagenr() < tabpagenr('$')
        tabnext
    endif
endfunction

  
function! TabManagment_tab_prev()
    if tabpagenr() > 1
        tabprev
    endif
endfunction


function ShowTabs()
	syntax match Tab /\t/
	hi Tab gui=underline guifg=blue ctermbg=blue 
endfunction


function HighlightLong()
	match ErrorMsg '\%>80v.\+'
endfunction

" ~/.vimrc ends here
