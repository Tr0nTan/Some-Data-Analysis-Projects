function pdot = ebolaModel(t, p)
pi = 8255.342; % Birth rate per year
mu = 1/26280; % Death rate per year
beta = 1.4e-9; % Transmission rate
gamma_U = 1/24; % Untreated recover rate
theta_U = 1/8; % Untreated dead rate
R = (beta*pi)/(mu*(theta_U+gamma_U+mu)); % The basic reproductive ratio

S = p(1);
I = p(2);
R = p(3);
D = p(4);
% The ODEs
dSdt = pi-beta.*(S.*I) - mu.*S;
dIdt = beta.*(S.*I) - gamma_U.*I -theta_U.*I- mu.*I;
dRdt = gamma_U.*I - mu.*R;
dDdt = theta_U.*I;

pdot = [dSdt; dIdt; dRdt; dDdt];
end