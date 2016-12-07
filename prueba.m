clc;clear;

client_id = '227XRC';

url = 'https://www.fitbit.com/oauth2/authorize?response_type=token&client_id=227XRC&scope=activity%20heartrate%20location%20nutrition%20profile%20settings%20sleep%20social%20weight&expires_in=604800';
web(url, '-browser');

header1 = http_createHeader('Authorization','Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzR1AzWUsiLCJhdWQiOiIyMjdYUkMiLCJpc3MiOiJGaXRiaXQiLCJ0eXAiOiJhY2Nlc3NfdG9rZW4iLCJzY29wZXMiOiJ3aHIgd251dCB3cHJvIHdzbGUgd3dlaSB3c29jIHdzZXQgd2FjdCB3bG9jIiwiZXhwIjoxNDgwNjA2MDY2LCJpYXQiOjE0ODAwMDEyNjZ9.bEV3N02NqzhdQ676w3tHeMZO0gp_wbEssYrp6AR1Nyk');
url2 = 'https://api.fitbit.com/1/user/-/activities/heart/date/today/1d/1sec.json';
response = urlread2(url2, 'GET','', header1);

json = loadjson(response);

L = length(json.activities_0x2D_heart_0x2D_intraday.dataset);
y=zeros(1,L);
x=zeros(1,L);
for i=1:L
    y(i) = json.activities_0x2D_heart_0x2D_intraday.dataset{i}.value;
    x(i) = formatInSec(json.activities_0x2D_heart_0x2D_intraday.dataset{i}.time(:));
end

function y = formatInSec(x)
    y = str2num(x(8))+str2num(x(7))*10;
    y = y + (str2num(x(5))+str2num(x(4))*10)*60;
    y = y +(str2num(x(2))+str2num(x(1))*10)*3600;
end





