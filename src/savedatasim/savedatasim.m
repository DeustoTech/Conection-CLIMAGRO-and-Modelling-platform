clear;

fp = folderpath;
cd(fp)
%
%%



every_iter = 20;
%every_iter = 5;

dt = 2*dt_wait();
dt = 60;

iter = 0;

while true

   iter = iter + 1;
   if exist('src/model/io/out.mat','file')
       
        try
           load('src/model/io/out.mat')
        catch
           fprintf('Error en la lectura de rc/model/io/out.mat \n\n')
           pause(1)
           continue
        end
        
        try
        for irt =  rt_yout.signals
            label = replace(replace(irt.label,'<',''),'>','');
            sample.(label) = irt.values(end,:);
        end
        sample.t = posixtime(dat_time);
        catch 
            fprintf('Error en el parseo de rt_yout a tipo estructura  \n\n')
            pause(1)
            continue 
        end 
   else
        fprintf('No existe el fichero src/model/io/out.mat\n\n')
        pause(1)
        continue 
        
   end
   id = mod(iter,every_iter);  
   
   if id == 0
     data(every_iter) = sample;
     fprintf(every_iter+"\n")
     
      file = now_str() + "_simulation.mat";
      save(fullfile('src','model','data',file),'data')
      clear data;
      fprintf(file+"\n")
   else
      data(id) = sample;
      fprintf(id+"\n")
   end


   
   pause(dt)
end