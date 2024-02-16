%% Define atmosphere function

function [ro,c]=ATMOSFER(h)
% calculation of ro and sound velocity verces hight
g=9.806;mo=28.966;R=8314.34;
if (h<=0) ro=1.22;c=340;end 

if (h>=0 && h<=11000) 
   hb=0 ; lm=-0.0065;   
   pb=101325.0;rob=1.2266;tmb=287.827;
   
   tm=tmb+lm*(h-hb);
   ro=rob*(tmb/tm)^(1+g*mo/(R*lm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*(tmb/tm)^(g*mo/(R*lm));
end
%------------------------------------------------
if (h>11000 && h<=25000) 
   hb=11000 ; lm=0.0;   
   pb=22589;rob=.3638;tmb=216.327;
   
   tm=tmb;
   ro=rob*exp(-g*mo*(h-hb)/(R*tm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*exp(-g*mo*(h-hb)/(R*tm));
end
%------------------------------------------------
if (h>25000 && h<=60960) 
   hb=25000 ; lm=0.001033;   
   pb=2475.8;rob=0.0399;tmb=216.327;
   
   tm=tmb+lm*(h-hb);
   ro=rob*(tmb/tm)^(1+g*mo/(R*lm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*(tmb/tm)^(g*mo/(R*lm));
end
%------------------------------------------------
if (h>=60960 && h<=76200) 
   hb=60960 ; lm=-0.003739;   
   pb=13.1121;rob=1.8035e-4;tmb=253.4737;
   
   tm=tmb+lm*(h-hb);
   ro=rob*(tmb/tm)^(1+g*mo/(R*lm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*(tmb/tm)^(g*mo/(R*lm));
end
%------------------------------------------------
if (h>76200 && h<=91440) 
   hb=76200 ; lm=0.0;   
   pb=1.2801;rob=2.2712e-5;tmb=196.4913;
   
   tm=tmb;
   ro=rob*exp(-g*mo*(h-hb)/(R*tm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*exp(-g*mo*(h-hb)/(R*tm));
end
%------------------------------------------------
if (h>91440) 
   hb=91440 ; lm=0.003531;   
   pb=0.0905;rob=1.6051e-6;tmb=196.4913;
   
   tm=tmb+lm*(h-hb);
   ro=rob*(tmb/tm)^(1+g*mo/(R*lm));
   c=sqrt(1.4*R*tm/mo);
   p=pb*(tmb/tm)^(g*mo/(R*lm));
end
%------------------------------------------------

% 
 %yy(1)=ro;
 %yy(2)=c;

end
