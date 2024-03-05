function [R,T,T_theta] = Reflect_Transm_function(rho,c,rho_1,c_1,theta,Interface)

m = rho_1/rho;
n = c/c_1;

theta = 0:1:90;

R = ( ( m*sind(theta) ) - sqrt( n^(2) - ((cosd(theta)).^(2)) ) ) ./ ( ( m*sind(theta) ) + sqrt( n^(2) - ((cosd(theta)).^(2)) ) );

T = (2*m*sind(theta)) ./ ( m*sind(theta) + sqrt( n^(2) - ((cosd(theta)).^(2)) ) );

T_theta = acosd( (c_1*cosd(theta)) / c );
T_theta = deg2rad(T_theta);

figure('units','normalized','outerposition',[0 0 .6 .8])
hold on, grid on
yyaxis left
plot(theta,abs(R),'LineWidth',3)
ylabel('|R|')

yyaxis right
plot(theta,rad2deg(angle(R)),'LineWidth',3)
ylabel('\theta_{R}')

title([Interface.Title,' Interface'])
xlabel('theta')
xlim([min(theta),max(theta)]);

set(gca,'fontsize',20)
exportgraphics(gcf, strcat( erase(Interface.Title,' ') ,"_Reflect.jpg") )

figure('units','normalized','outerposition',[0 0 .6 .8])
hold on, grid on
yyaxis left
plot(theta,abs(T),'LineWidth',3)
ylabel('|T|')

yyaxis right
plot(theta,rad2deg(angle(T_theta)),'LineWidth',3)
ylabel('\theta_{T}')

title([Interface.Title,' Interface'])
xlabel('theta')
xlim([min(theta),max(theta)]);

set(gca,'fontsize',20)
exportgraphics( gcf,strcat(erase(Interface.Title,' '),"_Transmittance.jpg") )


end