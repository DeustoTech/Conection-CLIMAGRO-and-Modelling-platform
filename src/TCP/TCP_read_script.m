clear; 

fp = folderpath;
cd(fp);

while ~exist('itcp')
    
    fprintf(now_str+" : Cliente de Simulacion esperando a Oscar\n")
    try
        uri = '0.0.0.0';
        port = 8000;
        itcp = tcpclient(uri,port);
        fprintf(now_str+" : Se ha conectado\n\n")
    end
    pause(1)
end

dt = dt_wait();

r = [];

count = 1;
while true
   if itcp.NumBytesAvailable == 0
       count = count + 1;      
   else
       count = 1;
   end
       
   if count > 5
        r = [];
   end
   
   while itcp.NumBytesAvailable > 0
        r = read_ast(itcp);
   end
   
   
   if ~isempty(r)
       QSOFC = r.QSOFC;
       flow  = r.flow;
       fprintf("Se ha  leido la clave  "+jsonencode(r)+" \n")

   else
      QSOFC = 0;
      flow  = 0;
      fprintf('No se se encuentra la clave .QSOFC\n')
      try 
        itcp = tcpclient(uri,port);
        fprintf(now_str+" : Se ha conectado\n\n")
      catch
        fprintf(now_str+" : No se ha conectado\n\n")
      end
   end

   save('src/model/io/in.mat','QSOFC','flow')
   fprintf(now_str+" : "+'Se ha actualizado src/model/io/in.mat \n\n')
   pause(dt)
   
end