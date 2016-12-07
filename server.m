t = tcpip('127.0.0.1', 8080, 'NetworkRole', 'server');
fopen(t);
data = fread(t, t.BytesAvailable);
disp(data);

