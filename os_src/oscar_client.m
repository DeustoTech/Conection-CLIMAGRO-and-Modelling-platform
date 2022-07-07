clear; 

fp = folderpath;
cd(fp);

uri = '0.0.0.0';
port = 4000;
itcp = tcpclient(uri,port);
pause(1)

r = [];
dt = dt_wait();

while true
    
   while itcp.NumBytesAvailable > 0
        r = read_ast(itcp);
   end
   if ~isempty(r)
       Ti = r.Ti;
       Tw = r.Tw;

       fprintf(now_str+" : "+"Se ha  leido la clave "+jsonencode(r)+"\n\n")

   else
      Ti = 0;
      Tw = 0;
      fprintf(now_str+" : "+'No se se encuentra la clave \n')
   end
   
    pause(dt)
end