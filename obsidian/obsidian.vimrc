nmap j gj
nmap k gk
nmap <C-c> <Esc>
nmap <C-[> <Esc>

" Go back
exmap back obcommand app:go-back
nmap ^ :back<CR>

" Go forward
" exmap forward obcommand app:go-forward
" nmap <C-]> :forward<CR>

" Delete current file
exmap delete obcommand app:delete-file
nmap <C-S-X> :delete<CR>

" file-explorer
exmap folder obcommand app:toggle-left-sidebar
nmap <C-e> :folder<CR>
