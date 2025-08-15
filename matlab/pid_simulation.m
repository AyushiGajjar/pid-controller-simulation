% PID Controller Simulation (MATLAB)
clear; clc; close all;

% ======== Config ========
plantType = 'first';     % 'first' or 'second'
tau  = 1.0;              % first-order param
wn   = 2.0; zeta = 0.3;  % second-order params

Kp = 1.5; Ki = 0.5; Kd = 0.05;
tEnd = 10; dt = 1e-3;

% ======== Build Plant ========
params = struct('tau', tau, 'wn', wn, 'zeta', zeta);
[A,B,C] = plant_models(plantType, params);
D = 0;

% State dimension
n = size(A,1);
x = zeros(n,1);

% Time & signals
t = 0:dt:tEnd;
r = ones(size(t));           % unit step
y = zeros(size(t));
u = zeros(size(t));

% PID states
e_int = 0; e_prev = 0;

% ======== Simulation Loop ========
for k = 1:length(t)
    yk = C * x;                  % output
    y(k) = yk;

    e = r(k) - yk;               % error
    e_int = e_int + e*dt;        % integral
    if k > 1, de = (e - e_prev)/dt; else, de = 0; end
    e_prev = e;

    u(k) = Kp*e + Ki*e_int + Kd*de;

    % Euler integration
    x = x + (A*x + B*u(k))*dt;
end

% ======== Metrics ========
y_final = y(end);
y10 = 0.1*y_final; y90 = 0.9*y_final;
idx10 = find(y >= y10, 1, 'first');
idx90 = find(y >= y90, 1, 'first');
if ~isempty(idx10) && ~isempty(idx90)
    t_rise = t(idx90) - t(idx10);
else
    t_rise = NaN;
end
OS = max(0, (max(y)-y_final)/max(1e-9,y_final)*100);
tol = 0.02*max(1,abs(y_final));
t_settle = NaN;
for k = 1:length(t)
   if all(abs(y(k:end)-y_final) <= tol)
       t_settle = t(k); break;
   end
end
sse = abs(y_final - 1.0);

% ======== Plot ========
figure; hold on; grid on;
plot(t, r, 'DisplayName','Reference');
plot(t, y, 'DisplayName','Output');
title(sprintf('PID Step Response (%s-order)', plantType));
xlabel('Time (s)'); ylabel('Amplitude'); legend('show');

fprintf('\n=== Step Metrics ===\n');
fprintf('Rise time:     %.4g s\n', t_rise);
fprintf('Overshoot:     %.4g %%\n', OS);
fprintf('Settling time: %.4g s\n', t_settle);
fprintf('SSE:           %.4g\n', sse);
