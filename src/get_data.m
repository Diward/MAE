function [ steps, kcal, hr, floors ] = get_data( date, hour_period )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
token_struct = load('files/token.mat');
TOKEN = token_struct.token;

petition_h = http_createHeader('Authorization',strcat('Bearer',{' '},TOKEN));
%% STEPS PETITION
petition_url = strcat('https://api.fitbit.com/1/user/-/activities/steps/date/',...
                       datestr(date,'yyyy-mm-dd'),'/1d/5min/time/',hour_period,'.json');
response = urlread2(petition_url, 'GET','', petition_h);
steps = loadjson(response);
%% CALORIES PETITION
petition_url = strcat('https://api.fitbit.com/1/user/-/activities/calories/date/',...
                       datestr(date,'yyyy-mm-dd'),'/1d/time/',hour_period,'.json');
response = urlread2(petition_url, 'GET','', petition_h);
kcal = loadjson(response);
%% FLOORS PETITION
petition_url = strcat('https://api.fitbit.com/1/user/-/activities/floors/date/',...
                       datestr(date,'yyyy-mm-dd'),'/1d/time/',hour_period,'.json');
response = urlread2(petition_url, 'GET','', petition_h);
floors = loadjson(response);
%% HEART RATE PETITION
petition_url = strcat('https://api.fitbit.com/1/user/-/activities/heart/date/',...
                       datestr(date,'yyyy-mm-dd'),'/1d/time/',hour_period,'.json');
response = urlread2(petition_url, 'GET','', petition_h);
hr = loadjson(response);
end




