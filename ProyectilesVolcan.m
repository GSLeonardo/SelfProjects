clear all
clc
g = 9.81;
dr = 2000;
da = 3.05;
dt = 0.1;
cd = 0.47;
x(2) = 0;
y(2) = 4750;
v(1) = 150;

diams = zeros(1,3);
ms = zeros(1,3);
as = zeros(1,3);
voxs = zeros(1,3);
voys = zeros(1,3);
bs = zeros(1,3);
xn_1s = zeros(1,3);
yn_1s = zeros(1,3);
angs = zeros(1,3);

for i = 1:3
    fprintf('Diámetro de la roca %d: ',i)
    diam = input('');
    fprintf('Ángulo %d: ',i)
    an = input('');
    [vox, voy] = velocidades(v(1), an);
    [yn_1, xn_1] = posiciones_anteriores(x(2), y(2), dt, g, vox, voy);
    [a, b, m, vol] = rocas(diam, dr, da, cd);
    diams(i) = diam;
    angs(i) = an;
    ms(i) = m;
    as(i) = a;
    voxs(i) = vox;
    voys(i) = voy;
    bs(i) = b;
    xn_1s(i) = xn_1;
    yn_1s(i) = yn_1;
end
ani(1) = animatedline('Color','r','Marker','.');
ani(2) = animatedline('Color','y','Marker','o');
ani(3) = animatedline('Color','b','Marker','O');
axis([0 4000 0 6000]);

datos = strings(4,12); 
datos(1, 2) = strjust('Posición inicial en x(m)','center');
datos(1, 3) = strjust('Posición inicial en y(m)','center');
datos(1, 4) = strjust('Masa de la roca (kg)','center');
datos(1, 5) = strjust('Densidad de la roca (kg/m3)','center');
datos(1, 6) = strjust('Angulo (°)','center');
datos(1, 7) = strjust('Radio (m)','center');
datos(1, 8) = strjust('Velocidad inicial (m/s)','center');
datos(1, 9) = strjust('Velocidad final (m/s)','center');
datos(1, 10) = strjust('Altura máxima (m)','center');
datos(1, 11) = strjust('Alcance máximo (m)','center');
datos(1, 12) = strjust('Tiempo de vuelo (s)','center');


for r = 1:3
    x(1) = xn_1s(r);
    y(1) = yn_1s(r);
    for i = 2:501
      if (((2*ms(r))/(2*ms(r) + bs(r)*dt)) * ((2*y(i)) + ((((bs(r)*dt)/(2*ms(r)))-1)*y(i-1))) - (g*dt^2)) > 0
          x(i+1) = ((2*ms(r))/(2*ms(r) + bs(r)*dt)) * ((2*x(i)) + ((((bs(r)*dt)/(2*ms(r)))-1)* x(i-1)));
          y(i+1) = ((2*ms(r))/(2*ms(r) + bs(r)*dt)) * ((2*y(i)) + ((((bs(r)*dt)/(2*ms(r)))-1)*y(i-1))) - (g*dt^2);
          addpoints(ani(r),x(i+1),y(i+1));
      else
          y(i+1) = 0;
          x(i+1) = x(i);
          addpoints(ani(r),x(i+1),y(i+1));
          break
      end
      title('Klutchevskoi');
      xlabel('Distancia (m)');
      ylabel('Altura (m)');
      drawnow
    end
    
    vfy = (y(end-1)-y(end-3)) /(2*dt);
    vfx = (x(end-1) - x(end-3)) / (2*dt);
    vf = sqrt(vfx^2 + vfy^2);
    t = dt * (i-1);
    s = 'Roca ';
    
    datos(r+1,1) = strjust(strcat(s,num2str(r)),'center');
    datos(r+1,2) = strjust(num2str(x(2)),'center');
    datos(r+1,3) = strjust(num2str(y(2)),'center');
    datos(r+1,4) = strjust(num2str(ms(r)),'center');
    datos(r+1,5) = strjust(num2str(dr),'center');
    datos(r+1,6) = strjust(num2str(angs(r)),'center');
    datos(r+1,7) = strjust(num2str(diams(r)/2),'center');
    datos(r+1,8) = strjust(num2str(v(1)),'center');
    datos(r+1,9) = strjust(num2str(vf),'center');
    datos(r+1,10) = strjust(num2str(max(y)),'center');
    datos(r+1,11) = strjust(num2str(max(x)),'center');
    datos(r+1,12) = strjust(num2str(t),'center');

    hold on
end
legend('Partícula 1', 'Partícula 2', 'Partícula 3');
fprintf('\nPartículas\n\n');
tabla = datos';
disp(tabla);
hold off

function [vox, voy] = velocidades(vo, angulo)
    vox = vo * cosd(angulo);
    voy = vo * sind(angulo);
end
function [yn_1, xn_1] = posiciones_anteriores(xo, yo, dt, g, vox, voy)
    xn_1 = xo - vox*dt;
    yn_1 = yo - voy*dt - ((g/2)*dt^2);
end
function [a, b, m, vol] = rocas(diametro, dr, da, cd)
    a = 4 * pi * (diametro/2)^2;
    b = 0.5 * da * cd * a;
    vol = (4/3) * pi * (diametro/2)^3;
    m = vol * dr;
end
    