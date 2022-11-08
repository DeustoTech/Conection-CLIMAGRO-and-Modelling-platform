function [stotal] = read_ast(tcp_real)

stotal = repmat(string,1,100);
index = 0;
s = ' ';
while tcp_real.NumBytesAvailable > 0&&~strcmp(s,'*')
    s = read(tcp_real,1,'string');
    if ~strcmp(s,'*')
        index = index + 1;
        stotal(index) = s;
    end
end
stotal = stotal(1:index);
stotal = char(stotal')';
if ~isempty(stotal)
    try
    stotal = jsondecode(stotal);
    catch
        
        fprintf("Formato recibido no es un json! - -"+stotal+"\n")
        stotal = [];
    end
else
    stotal = [];
end
end

