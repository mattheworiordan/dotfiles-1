set term=builtin_ansi

" I am weak, I use arrow keys
noremap <Up> <Up>
noremap <Down> <Down>
noremap <Left> <Left>
noremap <Right> <Right>

" Allow clipper to work https://github.com/wincent/clipper
nnoremap <leader>y :call system('nc localhost 8377', @0)

