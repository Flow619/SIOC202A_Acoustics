%% SIOC 202A
% Homework 7
% Problem 3
%%
% Author: Trenton Saunders
% Date: 03/11/2024

%%
close all;
clear all;
clc;

%% Define Variables
z_o = 25; % Source Depth [m]
f = 25; % Source Freq, Hz
h = 100; % water depth

c = 1500; % Sound Speed [m/s]

% Grid Resolution
dr = 1;
dz = 1;

%%
k = (2*pi()*f)/c;

r = 0:dr:1500;
z = 0:dz:h;

p_old = zeros(length(z),length(r));
p_new = zeros(length(z),length(r));
%%

figure

for n = 1:1000

    alpha_n = (n)*(pi()/h);
    krn = sqrt( (k^(2)) - (alpha_n^(2)) );
     
    p_new = p_old + ( ( sin(alpha_n*z_o) .* sin(alpha_n*z)' ) * ( ( exp(1i*krn*r) ./ sqrt(krn*r) ) ) );

    p_old = p_new;

    % p = ( ( ( 2*sqrt( 2*pi() ) ) * exp((1i*pi())/4) ) / h ) .* p_new;

    % db = 20*real(log10(p));

    % surf(r,z,db)  % Do I want just the real part?
    % pause(1);

    % clear p db
end

p_new = ( ( ( 2*sqrt( 2*pi() ) ) * exp((1i*pi())/4) ) / h ) .* p_new;
p_new(1,:) = 0;
p_new(end,:) = 0;
db = 20*log10(p_new);


figure
% contourf(r(2:end),z(2:end-1),real(db(2:end-1,2:end)))  % Do I want just the real part?
contourf(r,z,real(db))  % Do I want just the real part?

colorbar
colormap('turbo')
clim([-80,-20])
set(gca, 'YDir','reverse')