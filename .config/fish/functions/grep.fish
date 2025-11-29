function grep --wraps='rg' --description 'alias grep=rg'
  rg $argv | delta;
end
