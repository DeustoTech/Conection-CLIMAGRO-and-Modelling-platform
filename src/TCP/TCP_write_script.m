clear
fp = folderpath;
cd(fp)
uri = '0.0.0.0';
port = 4000;

iscreated = false;

while ~iscreated
    try 
        itcp = tcpserver(uri,port);
        iscreated = true;
    catch err
        
        fprintf(err.message+"\n")
        pause(2)
    end
end

dt = dt_wait();


while ~itcp.Connected
    fprintf(now_str + " : "+'Servidor de Simulacion Esperando!\n')
    pause(1)
end
fprintf(now_str + " : "+'Se ha conectado\n\n')


fp_model = fullfile(fp,'src','model');
fp_out = fullfile(fp_model,'io','out.mat');
%%
while true
    t = now_unix;
    if exist(fp_out,'file')
        try
            load(fp_out)
        catch
            fprintf('Error de lectura')
            pause(1)
            continue
        end
        T_air = rt_yout.signals(1).values(end,2);
        T_retorno = rt_yout.signals(2).values(end);    
    else
        T_retorno = 10;
        T_air = 14;
    end
    
    x.T_air_simu = T_air;
    x.T_retorno_simu = T_retorno;
    x.t = t;
    
    if itcp.Connected
        write_ast(itcp,x)
        fprintf(now_str+" : "+"Se ha escrito un mensaje "+jsonencode(x)+"\n\n")
    else
        fprintf(now_str+" : "+"el cliente no esta conectado\n\n")
    end
    pause(dt)
end
