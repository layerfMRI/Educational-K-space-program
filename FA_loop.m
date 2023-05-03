% this is for looping FAs without solving equation

%initial conditions
Mim1 = 0.2 ; 
omegaim1 = 14; 
T1 = 0.72 ;
TR = 0.10 ; 
s=4; %this is the number of sclies
Mxyim1 = sind(omegaim1)* Mim1; 

fprintf('slice 1')
fprintf('FA is  %f\n', omegaim1)
fprintf('Mz is  %f\n', Mim1)
fprintf('Mxy is  %f\n', Mxyim1)

for r = 2:s
       
    fprintf('slice %i\n', r)
   
     
    omegai=  asind((Mim1*sind(omegaim1))/(1-((1-cosd(omegaim1)*Mim1)*exp(-TR/T1)))) ;

    Mi = 1-((1-Mim1*cosd(omegai))*exp(-TR/T1));

    Mxyim1 = sind(omegai)* Mi;

    fprintf('FA is  %f\n', omegai)
    omegaim1 = omegai ;

    fprintf('Mz is  %f\n', Mi1)
    Mim1  = Mi ; 

    fprintf('Mxy is  %f\n', Mxyim1)

end 