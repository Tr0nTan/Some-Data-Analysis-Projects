% without
I0 = 100; 
S0 = 167400000-I0; 
R0 = 0; 
D0 = 0;
y0 = [S0; I0; R0; D0];
tspan = [0 365]; % days
% solve the ODEs
[t, y] = ode45(@ebolaModel, tspan, y0);
% Results
figure;
plot(t, y(:, 1), '-b', 'DisplayName', 'Susceptible');
hold on;
plot(t, y(:, 2), '-r', 'DisplayName', 'Infected');
plot(t, y(:, 3), '-g', 'DisplayName', 'Recovered');
plot(t, y(:, 4), '-c', 'DisplayName', 'Dead');
xlabel('Time (days)');
ylabel('Population');
legend('show');
title('Ebola Outbreak without Quarantine Measures');
hold off;