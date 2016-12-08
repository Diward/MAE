clc; clear;

token_struct = load('token.mat');
token = token_struct.token;

petition_h = http_createHeader('Authorization',strcat('Bearer',{' '},token));
petition_url = 'https://api.fitbit.com/1/user/-/activities/heart/date/today/1d/1sec.json';
response = urlread2(petition_url, 'GET','', petition_h);

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