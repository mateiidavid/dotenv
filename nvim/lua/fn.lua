P = function(v)
  print(vim.inspect(v))
  return v
end

R = function(name)
  package.loaded[name] = nil
  require(name)
end
