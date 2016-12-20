function [ steps, days, error ] = get_steps( start_date, end_date, from_h, to_h )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
token_struct = load('files/token.mat');
TOKEN = token_struct.token;

petition_h = http_createHeader('Authorization',strcat('Bearer',{' '},TOKEN));

numdays = datenum(end_date) - datenum(start_date);
x = cell(1,numdays);
y = zeros(0,numdays);
error.success = 1;
for i=0:numdays
    try
        d = datenum(start_date);
        petition_url = strcat('https://api.fitbit.com/1/user/-/activities/steps/date/',...
            datestr(d+i,'yyyy-mm-dd'),'/1d/15min/time/',from_h,'/',to_h,'.json');
        response = urlread2(petition_url, 'GET','', petition_h);
        json = loadjson(response);
        y(i+1) = str2double(json.activities_0x2D_steps{1,1}.value);
        x(i+1) = {datestr(json.activities_0x2D_steps{1,1}.dateTime,'dd/mm')};
    catch
        if (json.success)
            y(i+1) = 0;
            x(i+1) = {datestr(datenum(start_date)+i,'dd/mm')};
        else
            error = json; 
        end
    end
end
steps = y;
days = x;
end




