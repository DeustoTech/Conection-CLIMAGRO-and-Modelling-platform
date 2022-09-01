clear; 

fp = folderpath;
cd(fp);

uri = 'localhost';
port = 4000;

isconnected = false;
while ~isconnected
    try 
        itcp = tcpclient(uri,port);
        isconnected = true;
    catch
        fprintf(now_str+':  Cliente de Oscar Esperando!\n\n')
    end
end
pause(2)

r = [];
dt = dt_wait();

while true
    
   while itcp.NumBytesAvailable > 0
        r = read_ast(itcp);
   end
   if ~isempty(r)

       fprintf(now_str+" : "+"Se ha  leido la clave "+jsonencode(r)+"\n\n")
   else
      fprintf(now_str+" : "+'No se se encuentra la clave \n')
      
   end
   
    pause(dt)
end