%% SIOC 202A HW6 - Problem 2
close all;
clear all;
clc;


%% Water-Air Interface
rho = 1.0;
c = 1500;
rho_1 = 1.3*(10^(-3));
c_1 = 332;

theta = 0:1:90;
AirSea.Title = "Air Sea";

[AirSea.R,AirSea.T,AirSea.T_theta] = Reflect_Transm_function(rho,c,rho_1,c_1,theta,AirSea);


%% Water-Mud Interface
rho = 1.0;
c = 1500;
rho_1 = 1.5;
c_1 = 1480;

theta = 0:1:90;
SeaMud.Title = "Sea Mud";

[SeaMud.R,SeaMud.T,SeaMud.T_theta]= Reflect_Transm_function(rho,c,rho_1,c_1,theta,SeaMud);

%% Water-Sand Interface
rho = 1.0;
c = 1500;
rho_1 = 1.8;
c_1 = 1800;

theta = 0:1:90;
SeaSand.Title = "Sea Sand";

[SeaSand.R,SeaSand.T,SeaSand.T_theta]=Reflect_Transm_function(rho,c,rho_1,c_1,theta,SeaSand);
