function [A,B,C] = plant_models(type, params)
% type: 'first' or 'second'
% params: struct with fields:
%   first:  tau
%   second: wn, zeta

switch lower(type)
    case 'first'
        tau = params.tau;
        A = -1/tau;
        B = 1/tau;
        C = 1;
    case 'second'
        wn = params.wn; zeta = params.zeta;
        A = [0 1; -wn^2, -2*zeta*wn];
        B = [0; wn^2];
        C = [1 0];
    otherwise
        error('Unknown plant type');
end
end
