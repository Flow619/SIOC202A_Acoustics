%% SIOC 202A
%% Homework #6
%% Problem #4
% Author: Trenton Saunders
% Date: 02-24-2024

% Description: This code approximaes the ray trace for accoustic wave with
% a linearly increasing sound speed profile.
%%
close all;
clear all;
clc;

%% User Defined Variables
dz = 5;    % depth domain grid step (size of layer of constant sound speed)
z_bounds = [0,500];

launch_angle = 5;    % deg
z_source = 250;    % source depth [m]
x_source = 0;

t_end = 10;    % end time of numerical approximation

%% Set up Variables
z = z_bounds(1):dz:z_bounds(2); % depth array

% Sound Speed Profile
c.z = z_bounds(1) + (dz/2):dz: z_bounds(2) - (dz/2); % Average z values for layer (between z array values)
c.profile = 1500 + 0.1.*c.z; % sound speed profile for layer (average value)

dt = (1/2) * dz/max(c.profile); % want to make sure time step small enough to not skip between sound speed layers!

t = 0:dt:t_end;   % Time Series.

%% Ray Trace - Time loop
x_old = x_source;
z_old = z_source;

theta_old = launch_angle;

figure
hold on, grid on
plot(x_old,z_old,'o')
set(gca, 'YDir','reverse')

end_loop = 0;    % Boolean to end following for loop (When reflect off the bottom)


for i = 1:length(t)

    c_old = mean( c.profile( c.z < (z_old + dz) & c.z > (z_old - dz) ) );  % Current sound of speed

    c_x = c_old*cosd(theta_old);
    c_z = c_old*sind(theta_old);

    dx_timestep = c_x*dt;    % dx based on dt time step
    dz_timestep = c_z*dt;    % dz based on dt time step

    x_new = x_old + dx_timestep;    % Update x position
    z_new = z_old + dz_timestep;    % Update z position

    c_new = mean( c.profile( c.z < (z_new + dz) & c.z > (z_new - dz) ) );  %% Check speed of sound at new location!

    if c_new ~= c_old   % If moved between layers!

        theta_new = acosd( (c_new/c_old)*cosd(theta_old) );  % Snell's law, moving between sound speed layers.

        if ~isreal(theta_new)  % if imag. # (assume at bottom boundary)
            theta_new = -theta_old; % flip the angle (@ boundary).
            end_loop = 0;
        end

        c_x = c_new*cosd(theta_new);
        c_z = c_new*sind(theta_new);

        dx_timestep = c_x*dt;
        dz_timestep = c_z*dt;

        x_new = x_old + dx_timestep;
        z_new = z_old + dz_timestep;

        theta_old = theta_new;

    end

    plot(x_new,z_new,'o')

    x_old = x_new;
    z_old = z_new;

    if end_loop == 1
        break
    end

end





