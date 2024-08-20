function pdot = QebolaModel2(t, p)
pi = 8255.342; % Birth rate per day
mu = 1/26280; % Death rate per day
k = 1/3; % Quanratine rate
beta = 1.4e-9; % Transmission rate
gamma_Q = 1/12; % Quarantined recovery rate
gamma_U = 1/24; % Untreated recovery rate
theta_Q = 1/16; % Quarantined death rate
theta_U = 1/8; % Untreated death rate
maxQ = 133920; % Maximum quarantine capacity due to hospital beds
R=(beta*pi)/(mu*(k+gamma_U+theta_U+mu));

S = p(1);
I = p(2);
Q = p(3);
R = p(4);
D = p(5);

% The ODEs
dSdt = pi - beta .* S .* I - mu .* S;
dIdt = beta .* S .* I - k .* I - theta_U .* I - gamma_U .* I - mu .* I;

if Q < maxQ
    dQdt = k .* I - theta_Q .* Q - gamma_Q .* Q - mu .* Q;
    dRdt = gamma_U .* I + gamma_Q .* Q - mu .* R;
    dDdt = theta_U .* I + theta_Q .* Q;
    pdot = [dSdt; dIdt; dQdt; dRdt; dDdt];
else
    dQdt = 0 .* I - theta_Q .* Q - gamma_Q .* Q - mu .* Q;
    dRdt = gamma_U .* I + gamma_Q .* Q - mu .* R;
    dDdt = theta_U .* I + theta_Q .* Q;
    pdot = [dSdt; dIdt; dQdt; dRdt; dDdt];
end
end
