function write_st_ast(tcp,x)

write(tcp,jsonencode(x)+"*",'string')


end

