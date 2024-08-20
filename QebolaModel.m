function pdot = QebolaModel(t, p)
pi = 8255.342; % Birth rate per day
mu = 1/26280; % Death rate per day
k = 0.2; % Quarantine rate
q = 0.1; % Release rate from quarantine
beta = 1.4e-9; % Transmission rate
gamma_U = 1/24; % Untreated recover rate
gamma_Q = 1/12; % Quarantined recover rate
theta_U = 1/8; % Untreated dead rate
theta_Q = 1/16; % Quarantined dead rate
maxQ = 13392000; % Maximum quarantine capacity due to hospital beds
% R = (beta*pi)/(mu*(k+theta_U+gamma_U+mu));

S = p(1);
I = p(2);
Q = p(3);
R = p(4);
D = p(5);
% The ODEs
dSdt = pi + q.*Q - beta.*(S.*I) - mu.*S;
dIdt = beta.*(S.*I) - k.*I - gamma_U.*I -theta_U.*I - mu.*I;
if Q < maxQ
    dQdt = k.*I - q.*Q - gamma_Q.*Q - theta_Q.*Q - mu.*Q;
    dRdt = gamma_U.*I + gamma_Q.*Q - mu.*R;
    dDdt = theta_U.*I + theta_Q.*Q;
else
    dQdt = 0.*I - q.*Q - gamma_Q.*Q -theta_Q.*Q - mu.*Q;
    dRdt = gamma_U.*I + gamma_Q.*Q - mu.*R;
    dDdt = theta_U.*I + theta_Q.*Q;
end
pdot = [dSdt; dIdt; dQdt; dRdt; dDdt];
end