clear 

uri = '0.0.0.0';
port = 8000;
itcp = tcpserver(uri,port);


dt = dt_wait();

while ~itcp.Connected
    fprintf(now_str + " : "+'Servidor de Oscar Esperando!\n')
    pause(1)
end
    fprintf(now_str + " : "+'Se ha conectado\n')

while true
    t = now_unix;
    x.QSOFC = 1000*sin(2*pi*t/60);
    x.flow = 1;
    x.t = t;
    write_ast(itcp,x)
    pause(dt)
    fprintf(now_str+" : "+"Se ha escrito un mensaje"+ jsonencode(x)+"\n")
end
