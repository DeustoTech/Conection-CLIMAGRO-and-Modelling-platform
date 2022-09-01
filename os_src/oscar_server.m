clear 

iscreated = false;
uri = '0.0.0.0';
port = 8000;
while ~iscreated
    try
        itcp = tcpserver(uri,port);
        iscreated = true;
    catch err
        fprintf(err.message+"\n")
    end
    pause(2)
end

dt = dt_wait();

while ~itcp.Connected
    fprintf(now_str + " : "+'Servidor de Oscar Esperando!\n')
    pause(1)
end
    fprintf(now_str + " : "+'Se ha conectado\n')

while true
    t = now_unix;
    x.T_ida_real =   273.15 + 20 +10*sin(2*pi*t/60);
    x.T_retorno_real = 273.15 + 20 + 10*cos(2*pi*t/60);
    x.AR_state_real = 1;
    x.flow_real = 8;
    x.t = t;
    write_ast(itcp,x)
    pause(dt)
    fprintf(now_str+" : "+"Se ha escrito un mensaje"+ jsonencode(x)+"\n")
end
