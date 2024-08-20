% Initial conditions
clear all
N = 167400000;
I0 = 100; 
Q0 = 0;
R0 = 0; 
D0 = 0;
S0 = N-I0; 
tspan = [0 365]; % 1 year
% solve the ODEs
% [t, y] = ode45(@QebolaModel1, tspan, [S0; I0; Q0; R0; D0]);

options = odeset('Events', @event1);
[t1, y1, te, ye, ie] = ode45(@QebolaModel1, tspan, [S0; I0; Q0; R0; D0], options);

[t2, y2] = ode45(@QebolaModel2, [te, 365], [ye(1); ye(2); ye(3); ye(4); ye(5)]);

t = cat(1, t1, t2);
y = cat(1, y1, y2);
y = max(y,0);
% Results
% plot(t, y(:, 1), '-b', 'DisplayName', 'Susceptible');

plot(t, y(:, 2), '-r', 'DisplayName', 'Infected');
hold on;
plot(t, y(:, 3), '-k', 'DisplayName', 'Quarantined');
plot(t, y(:, 4), '-g', 'DisplayName', 'Recovered');
plot(t, y(:, 5), '-c', 'DisplayName', 'Death');
xlabel('Time (days)');
ylabel('Population');
legend('show');
title('Ebola Outbreak with Quarantine Measures');
hold off;