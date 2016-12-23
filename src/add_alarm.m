function [ y ] = add_alarm( hour, days )
%ADD_ALARM Summary of this function goes here
%   Detailed explanation goes here
token_struct = load('files/token.mat');
TOKEN = token_struct.token;
%% DEVICE
petition_h = http_createHeader('Authorization',strcat('Bearer',{' '},TOKEN));
petition_url = 'https://api.fitbit.com/1/user/-/devices.json';
[response,e] = urlread2(petition_url, 'GET','', petition_h);
json = loadjson(response);
tracker_id = json{1,1}.id;
%% POST ALARM
petition_url = strcat('https://api.fitbit.com/1/user/-/devices/tracker/',tracker_id,'/alarms.json');
string = strcat('time=',hour,'&enabled=true&recurring=false&weekDays=',days);
[queryString,header] = http_paramsToString({'time' hour 'enabled' 'true' 'recurring' 'false' 'weekDays' days}, 1);
response = urlread2(petition_url, 'POST',string , [petition_h]);
json = loadjson(response);
end

