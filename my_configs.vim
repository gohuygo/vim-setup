set clipboard=unnamed
set switchbuf=useopen
" get back defaults for the following
autocmd VimEnter * silent! unmap F
syntax on
color dracula
" leader
nmap <Space> <leader>
let maplocalleader = "\<Tab>"
" shortcuts
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
nnoremap <leader>lcd :lcd %:p:h<CR>:pwd<CR>
nnoremap <leader>d :w !git diff --no-index -- % -<CR>
" navigation
autocmd VimEnter * nnoremap gp `[v`]
nmap gd <Plug>(lsp-definition)
nmap gh <Plug>(lsp-hover)
nmap gr <Plug>(lsp-references)
nmap gm <Plug>(lsp-rename)
" customize searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap <C-J> :CtrlPLine<CR> 
" style and indicators
set number 
set colorcolumn=120
highlight ColorColumn ctermbg=8 guibg=Grey8
" configure linters and fixers
let g:ale_linters = {'go': ['go', 'golint', 'errcheck'], 'javascript': ['jshint'], 'python': ['flake8', 'mypy']}
let g:ale_fixers = {'python': ['yapf']}
let g:ale_python_mypy_options = '--ignore-missing-imports'
" configure tab to show relative path
function! Lightline_tab_relativepath(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let _ = fnamemodify((expand('#'.buflist[winnr - 1].':p')), ':~:.')
  return _ !=# '' ? _ : '[No Name]'
endfunction
let g:lightline.tab_component_function = {
    \ 'relativepath': 'Lightline_tab_relativepath' }
let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'relativepath', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ] }
" configure pep8
let g:autopep8_max_line_length=120
let g:autopep8_disable_show_diff=1
" configure CtrlP
let g:ctrlp_extensions = ['line']
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif
" Language Server config
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
endif
