clc;
clear all;

% the initial conditions
v_x0 = 0;
v_y0 = 0;
x0 = 0;
y0 = 0;

F0 = [v_x0; v_y0; x0; y0]; 

tspan = 0:0.1:510;

% Solve the ODE
[t, F] = ode23(@rocket_simulation, tspan, F0);

v_xs = F(:, 1);
v_ys = F(:, 2);
x = F(:, 3);
y = F(:, 4);


% % Plot Gravity 
% plot(t, g);
% ylabel('Gravity (m/s^2)');
% xlabel('Time (s)');
% grid on;




% Plot the results
subplot(3, 2, 1)
plot(t,x);
ylabel('Position in x-direction (star coordinate)');
xlabel('Time');
grid on

subplot(3, 2, 2)
plot(t, y);
ylabel('Position in y-direction (star coordinate)');
xlabel('Time');
grid on

subplot(3, 2, 3)
plot(t,v_xs);
ylabel('Velocity in x-direction');
xlabel('Time');
grid on

subplot(3, 2, 4)
plot(t, v_ys);
ylabel('Velocity in y-direction');
xlabel('Time');
grid on





