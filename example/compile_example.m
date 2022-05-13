clear 
r = which('compile_example');
r = replace(r,'compile_example.m','');
cd(fullfile(r,'compile_files'))

open_system("example_model")

slbuild("example_model")

cd ../..