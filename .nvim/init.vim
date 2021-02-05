function! Dot(path)
  return "~/.config/nvim/" . a:path
endfunction

for file in split(glob(Dot("plugins/*.vim")), "\n")
  execute "source" file
endfor

for file in split(glob(Dot("modules/*.vim")), "\n")
  execute "source" file
endfor
