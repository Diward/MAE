clc; clear;

url_base = 'https://www.fitbit.com/oauth2/authorize?response_type=code&';
client_id = 'client_id=227XRC';
scope = [ '&scope=activity%20heartrate%20location%20nutrition%20profile' ...
          '%20settings%20sleep%20social%20weight&expires_in=604800' ];
url = strcat(url_base, client_id, scope);
      
[s,browser] = web(url, '-new', '-noaddressbox', '-notoolbar'); 
while s == 0
    cloc = get(browser, 'currentLocation'); 
    if ~isempty(cloc) && strcmp(cloc(8),'1')
        close(browser);
        break
    end
end

token = regexp(cloc,'(?<=token=)(.*)(?=&user_id)', 'match');
token = strjoin(token);
save('token.mat', 'token')








