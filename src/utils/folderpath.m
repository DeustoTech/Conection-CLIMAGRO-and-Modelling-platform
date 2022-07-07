function r = folderpath

    name = 'TCP_20_init.m';
    r = which(name);
    r = replace(r,name,'');

end