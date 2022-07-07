function r = now_str()

r = replace(replace(string(datetime('now','Format','yyyy-MM-dd HH:mm:ss')),' ','_'),':','_');

end

