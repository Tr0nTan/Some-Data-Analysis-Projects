function pdot = QebolaModel3(t, p)
thresholdCrossed = false;
pi = 8255.342; % Birth rate per day
mu = 1/26280; % Death rate per day
k = 0; % Quarantine rate
e = 0; % Normal rate of home quarantine
r = 1/8; 
beta = 1.4e-9; % Transmission rate
gamma_Q = 1/12; % Quarantined recovery rate per day
gamma_U = 1/24; % Untreated recovery rate per day
theta_Q = 1/16;
theta_U = 1/8;
maxQ = 133920; % Maximum quarantine capacity due to hospital beds
S = p(1);
I = p(2);
Q1 = p(3);
Q2 = p(4);
R = p(5);
D = p(6);
%infection level, only run once
if ~thresholdCrossed && I > 0.01*167400000
k = 1/6;
thresholdCrossed = true;
end
% Home quarantine rate adjustment
if Q2 >= 0.1*167400000
e = 1/4;
else
e = 0;
end

% The ODEs
dSdt = pi + r .* Q2 - e .* S - beta .* S .* I - mu .* S;
dIdt = beta .* S .* I - k .* I - theta_U .* I - gamma_U .* I - mu .* I;
dQ2dt = e .* S - r .* Q2 - mu .* Q2;

if Q1 < maxQ
    dQ1dt = k .* I - theta_Q .* Q1 - gamma_Q .* Q1 - mu .* Q1;
    dRdt = gamma_U .* I + gamma_Q .* Q1 - mu .* R;
    dDdt = theta_U .* I + theta_Q .* Q1;
    pdot = [dSdt; dIdt; dQ1dt; dQ2dt; dRdt; dDdt];
else
    dQ1dt = 0 .* I - theta_Q .* Q1 - gamma_Q .* Q1 - mu .* Q1;
    dRdt = gamma_U .* I + gamma_Q .* Q1 - mu .* R;
    dDdt = theta_U .* I + theta_Q .* Q1;
    pdot = [dSdt; dIdt; dQ1dt; dQ2dt; dRdt; dDdt];
end
end