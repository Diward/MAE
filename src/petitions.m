
token_struct = load('files/token.mat');
TOKEN = token_struct.token;
%% DEVICE
petition_h = http_createHeader('Authorization',strcat('Bearer',{' '},TOKEN));
petition_url = 'https://api.fitbit.com/1/user/-/devices.json';
[response,e] = urlread2(petition_url, 'GET','', petition_h);
json = loadjson(response);
tracker_id = json{1,1}.id;
%% POST ALARM
% petition_url = strcat('https://api.fitbit.com/1/user/-/devices/tracker/',tracker_id,'/alarms.json');
% time_h = http_createHeader('time','07:15-08:00');
% enabled_h = http_createHeader('enabled','true');
% recurring_h = http_createHeader('recurring','false');
% weekdays_h = http_createHeader('weekDays', 'MONDAY,TUESDAY');
% [queryString,header] = http_paramsToString({'time' '10:40-11:00' 'enabled' 'true' 'recurring' 'false' 'weekDays' 'MONDAY,TUESDAY'}, 1);
% response = urlread2(petition_url, 'POST',queryString , [header petition_h]);
% json = loadjson(response);



%% ALARMS
petition_url = strcat('https://api.fitbit.com/1/user/-/devices/tracker/',tracker_id,'/alarms.json');
response = urlread2(petition_url, 'GET','', petition_h);
alarms = loadjson(response);
%% DELETE

petition_url = strcat('https://api.fitbit.com/1/user/-/devices/tracker/',tracker_id,'/alarms/405459321.json');
[response,e] = urlread2(petition_url, 'DELETE','', petition_h);

e.allHeaders

