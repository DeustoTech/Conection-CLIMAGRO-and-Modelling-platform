clear
fp = folderpath;
cd(fp)
uri = '0.0.0.0';
port = 4000;
itcp = tcpserver(uri,port);

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
        Ti = rt_yout.signals(1).values(end,2);
        Tw = rt_yout.signals(2).values(end);    
    else
        Tw = 10;
        Ti = 14;
    end
    
    x.Ti = Ti;
    x.Tw = Tw;
    x.t = t;
    
    if itcp.Connected
        write_ast(itcp,x)
        fprintf(now_str+" : "+"Se ha escrito un mensaje "+jsonencode(x)+"\n\n")
    else
        fprintf(now_str+" : "+"el cliente no esta conectado\n\n")
    end
    pause(dt)
end
