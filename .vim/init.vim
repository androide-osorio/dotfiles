"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Main VIm configuration file. This setup uses
" modules and VIM scripting to define the editor's config,
" in order to make it more maintainable and searchable.
"
" Maintainer:
"       Andrés Osorio - @androide-osorio
"
" Inspiration:
"       awesome-vim repository:
"           https://github.com/amix/vimrc
"
" Sections:
"    -> Setup
"    -> Plugin configuration
"    -> Base configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" -------------------------------------------------------------
" -> Setup
" -------------------------------------------------------------

" find a config module inside designated config folder
function! Dot(path)
  let root = "~/.config/vim/"
  return root . a:path
endfunction

" -------------------------------------------------------------
" -> Plugin configuration
" -------------------------------------------------------------
for file in split(glob(Dot("plugins/*.vim")), "\n")
  execute "source" file
endfor

" -------------------------------------------------------------
" -> Base configuration
" -------------------------------------------------------------
for file in split(glob(Dot("modules/*.vim")), "\n")
  execute "source" file
endfor
