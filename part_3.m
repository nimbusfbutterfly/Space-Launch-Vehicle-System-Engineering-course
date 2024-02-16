clc
clear all
M0=[289.8550 53.3333].*907.2;
Th=[356.46e3 23.42e3];
m_st=[19.70922 8.361659]*907.2;

a_TO=[0.05 0.096];
gamma_gy=[0.008 0.0455];

% Fuel tank mass and oxidizer of each stage 
mTO1=M0(1) *a_TO(1);
mTO2=M0(2)*a_TO(2);

fprintf("Fuel tank mass and oxidizer of first stage: %s \n",mTO1/907/2);
fprintf("Fuel tank mass and oxidizer of second stage: %s \n",mTO2/907.2);

% engine mass
m_gy1=Th(1)*gamma_gy(1);
m_gy2=Th(2)*gamma_gy(2);

fprintf("engine mass's first stage: %s \n",m_gy1/907.2);
fprintf("engine mass's second stage: %s \n",m_gy2/907.2);


% transfer mass first stage and navigation and control second stage
m_sigma1=m_st(1)-(m_gy1+mTO1);
m_cy2=m_st(2)-(m_gy2+mTO2);

fprintf("transfer mass first stage: %s \n",m_sigma1/907.2);
fprintf("navigation and control second stage: %s \n",m_cy2/907.2);

% parameter of engine and fuel+ox
k=[1.65 2.5];
rho_fuel=[825 825]; %density fuel (kg/m^3)
rho_ox=[1141 1141]; %density ox (kg/m^3)

% volume of fuel and oxidizer thank
v_ox=([262952.0328 48383.15589]./[rho_ox]).*(k./(1+k));
v_fuel=([262952.0328 48383.15589]./[rho_ox]).*(1./(1+k));

fprintf("volume of oxidizer tank first stage and second stage: %s \n",v_ox.*1.1);
fprintf("volume of fuel tank first stage and second stage: %s \n",v_fuel.*1.1);

% volume navigation and control , payload and tranfer part
rho_cy=0.15e3;
rho_pl=0.21e3;
rho_sigma=0.015e3;

v_sigma1=m_sigma1/rho_sigma;
v_pl=9071.85/rho_pl;
v_cy=m_cy2/rho_cy;

fprintf("volume transfer part: %s \n",v_sigma1);
fprintf("volume payload: %s \n",v_pl);
fprintf("volume navigation and control: %s \n",v_cy);




% legenth of ROCKET
D_1=8.5; %Diameter stage 1 (m)
D_2=5; %Diameter stage 2 (m)
L2=[v_ox(2)  v_fuel(2) v_cy  v_pl]./(pi*D_2/4);
L1=[v_ox(1) v_fuel(1) v_sigma1]./(D_1*pi/4);
fprintf("legenth of stages1: %s \n",L1);
fprintf("legenth of stages2: %s \n",L2);

L_ROCKET=L1(1)+L1(2)+L1(3)+L2(1)+L2(2)+L2(3)+L2(4)+3.15+1.25;

ld=L_ROCKET/D_1;

fprintf("Legenth of rocket: %s \n",L_ROCKET);
fprintf("Legenth of rocket/Diameter: %s \n",ld);