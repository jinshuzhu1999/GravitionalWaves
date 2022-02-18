%how to see whether the random number is pseudo or not?

%Default seed
rng('default') 
rand() % One trial value
rand() % Another trial value
disp('----reset seed-----')
rng('default')
rand() % One trial value
rand() % Another trial value

disp('----reset seed by myself 1-----')
rng(3)
rand() % One trial value
rand() % Another trial value

disp('----reset seed by myself 2 with the same seed-----')
rng(3)
rand() % One trial value
rand() % Another trial value