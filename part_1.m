clc
clear all

% SPACE LAUNCH VEHICLE SYSTEM ENGINEERING PROJECT PART 1
% fatemeh moghadasian

global M0 mdot tb Th m_st

% GTO PARAMETERS
r = 200; % perigee (km)
a = 42164; % semi-major axis (km)

% Earth PARAMETERS
mu = 398620; % Acceleration of gravity (km^2/s^2)
R_earth = 6378.14; % Radius of Earth (km)
w_e = 0.0041780746; % Angular velocity of Earth (degree/s)
g0 = 0.00981; % Gravity (km/s^2)
phi = 35; % Intercept elevation launch origin (degree)
az = 135; % Azimuth launch origin (degree)

% Orbital calculations
v_c = sqrt((2 * mu / r) - (mu / a));
v_earth = R_earth * w_e * cosd(phi);
cosi = cosd(phi) * sind(az);
v_f = sqrt(v_c^2 + v_earth^2 - 2 * v_c * v_earth * cosi);

fprintf('Velocity Elliptic: %s \n', num2str(v_c));
fprintf('Velocity Earth: %s \n', num2str(v_earth));
fprintf('Velocity Final: %s \n', num2str(v_f));

% Statistical data
i_sp1 = 3851; % Specific impulse stage-1
i_sp2 = 3880; % Specific impulse stage-2
muf1 = 0.573; % μ stage-1 final mass
muf2 = 0.5467; % μ stage-2 final mass
no1 = 6.2405; % Thrust/weight stage-1
no2 = 2.8850; % Thrust/weight stage-2
mupl1 = 0.118; % μ payload stage-1
mupl2 = 0.23; % μ payload stage-2
mupl = mupl1 * mupl2; % Total payload μ
m_p = 10; % Payload mass (ton)

% Calculate Average Velocity
v_av1 = 0;
v_av2 = 0;
v_av = 0;
while v_av <= v_f
    v_av1 = -(g0) * (i_sp1 * log(muf1));
    v_av2 = -(g0) * (i_sp2 * log(muf2));
    v_av = v_av1 + v_av2;
    v_av = 0.75 * v_av;
    muf1 = muf1 - 0.01;
    muf2 = muf2 - 0.01;
end

fprintf("Average Velocity: %s \n", num2str(v_av));
fprintf("μ Final Stage 1: %s \n", muf1);
fprintf("μ Final Stage 2: %s \n", muf2);

% Calculate the mass of the stages
M01 = 10 / mupl; % Mass of the first stage (ton)
mp1 = M01 * (1 - muf1); % Payload of first stage (ton)
M02 = M01 * mupl2; % Mass of the second stage (ton)

fprintf("Mass of the first stage: %s \n", M01);
fprintf("Payload of first stage: %s \n", mp1);
fprintf("Mass of the second stage: %s \n", M02);

% Calculate the mass of the blocks
m01 = M01 - M02; % Mass of the first block
m02 = M02 - m_p; % Mass of the second block

fprintf("Mass of the first block: %s \n", m01);
fprintf("Mass of the second block: %s \n", m02);

% Calculate thrust of the stages
th1 = no1 * M01; % Thrust of the first stage (kN)
th2 = no2 * M02; % Thrust of the second stage (kN)

fprintf("Thrust of the first stage: %s \n", th1);
fprintf("Thrust of the second stage: %s \n", th2);

% Calculation of burning time (performance) of each stage
t_b1 = (i_sp1 * (1 - muf1)) / no1; % Burning time of the first stage (s)
t_b2 = (i_sp2 * (1 - muf2)) / no2; % Burning time of the second stage (s)

fprintf("Burning time of the first stage: %s \n", t_b1);
fprintf("Burning time of the second stage: %s \n", t_b2);

% Calculate the mass of the propellant for each stage
m_p1 = M01 * (1 - muf1); % Mass of propellant for the first stage (ton)
m_p2 = M02 * (1 - muf2); % Mass of propellant for the second stage (ton)

fprintf("Mass of propellant for the first stage: %s \n", m_p1);
fprintf("Mass of propellant for the second stage: %s \n", m_p2);

% Calculate the structure mass for each stage
m_st1 = (muf1 * M01) - M02; % Structure mass for the first stage (ton)
m_st2 = (muf2 * M02) - 10; % Structure mass for the second stage (ton)

fprintf("Structure mass for the first stage: %s \n", m_st1);
fprintf("Structure mass for the second stage: %s \n", m_st2);

% Calculate the density of propellant for each stage
mdot1 = th1 / i_sp1; % Density of propellant for the first stage (ton/s)
mdot2 = th2 / i_sp2; % Density of propellant for the second stage (ton/s)

fprintf("Density of propellant for the first stage: %s \n", mdot1);
fprintf("Density of propellant for the second stage: %s \n", mdot2);

M0 = [M01 * 907.2, M02 * 907.2];
mdot = [mdot1 * 1000, mdot2 * 1000];
tb = [t_b1, t_b2];
Th = [th1 * 1000, th2 * 1000];
m_st = [m_st1, m_st2] .* 907.2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a_TO=[0.099 0.096];
gamma_gy=[0.008 0.0455];

% Fuel tank mass and oxidizer of each stage 
mTO1=M0(1) *a_TO(1);
mTO2=M0(2)*a_TO(2);

fprintf("Fuel tank mass and oxidizer of first stage: %s \n",mTO1);
fprintf("Fuel tank mass and oxidizer of second stage: %s \n",mTO2);

% engine mass
m_gy1=Th(1)*gamma_gy(1);
m_gy2=Th(2)*gamma_gy(2);

fprintf("engine mass's first stage: %s \n",m_gy1);
fprintf("engine mass's second stage: %s \n",m_gy2);


% transfer mass first stage and navigation and control second stage
m_sigma1=m_st(1)-(m_gy1+mTO1);
m_cy2=m_st(2)-(m_gy2+mTO2);

fprintf("transfer mass first stage: %s \n",m_sigma1);
fprintf("navigation and control second stage: %s \n",m_cy2);

% parameter of engine and fuel+ox
k=[4 2.8];
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
D_1=9; %Diameter stage 1 (m)
D_2=5; %Diameter stage 2 (m)
L2=[v_ox(2)  v_fuel(2) v_cy  v_pl]./(pi*D_2/4);
L1=[v_ox(1) v_fuel(1) v_sigma1]./(D_1*pi/4);
fprintf("legenth of stages1: %s \n",L1);
fprintf("legenth of stages2: %s \n",L2);

L_ROCKET=L1(1)+L1(2)+L1(3)+L2(1)+L2(2)+L2(3)+L2(4)+3.15+1.25;

ld=L_ROCKET/D_1;

fprintf("Legenth of rocket: %s \n",L_ROCKET);
fprintf("Legenth of rocket/Diameter: %s \n",ld);

