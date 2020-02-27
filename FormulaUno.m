%Leonardo Galindo Sanchez                   A01637341
%Samuel Alejandro Díaz del Guante Ochoa     A01637592
%Monica Jaqueline Iñiguez Moncada           A01637127
clear all
clc
clf

%Límites intefior, superior, incremento y número de intervalos
a = 100;
b = 2600;
h = 5;
n = (b - a) / h;

%Coordenadas tentativas para crear la función
xgeo = [100 2600 174 396 1185 1663 2541];
ygeo = [2900 800 2108 541 486 2041 1241];

p = polyfit(xgeo,ygeo,3);

format long
%Función de la pista
f = @(x) p(1).*x.^3 + p(2).*x.^2 + p(3).*x + p(4);
fprintf("\nLa función es: %fx^3 + %fx^2 - %fx + %f\n", p(1), p(2), abs(p(3)), p(4));
%Derivada de la función
df = @(x) 3.*p(1).*x.^2 + 2.*p(2).*x + p(3);

%Función para sacar la longitud de la pista
long = @(x) sqrt(((3.*p(1).*x.^2 + 2.*p(2).*x + p(3)).^2) + 1);

%Función para determinar los radios críticos
rc = @(x) ((1 + (3.*p(1).*x.^2 + 2.*p(2).*x + p(3)).^2).^(3/2)) / abs(6.*p(1).*x + 2.*p(2));

%X y Y de la pista, y su gráfica.
x = a:h:b;
y = polyval(p,x);

%Validación de la longitud de la función
longitud = simpson(long,a,b,n,x);
fprintf("\nLongitud: %.2fm\n", longitud);

%Puntos máximos y mínimos
[xmin, ymin, xmax, ymax] = formula_general(p);
fprintf("\nPunto mínimo: (%.2f, %.2f)\n", xmin, ymin);
fprintf("Punto máximo: (%.2f, %.2f)\n", xmax, ymax);
pmin = [xmin, ymin];
pmax = [xmax, ymax];

%Despliegue de radios críticos
%radios_criticos(rc,a,b,h);

%Radios críticos en puntos máximo y mínimo
rmin = rc(xmin);
rmax = rc(xmax);
fprintf("\nRadio en punto mínimo %.2fm", rmin);
fprintf("\nRadio en punto máximo %.2fm\n", rmax);

%Barrido más fino (0.01) para encontrar zonas críticas.
hfino = 0.1;

amin = 735;
bmin = 780;
%radios_criticos(rc, amin, bmin, hfino);
amax = 2045;
bmax = 2095;
%radios_criticos(rc, amax, bmax, hfino);

%Zona crítica 1
x1_inicial = 736.8;
x1_final = 779.5;


y1_inicial = f(x1_inicial);
y1_final = f(x1_final);

fprintf("\nZona crítica 1:\nDe (%.2f, %.2f) hasta (%.2f, %.2f)\n", x1_inicial, y1_inicial, x1_final, y1_final);

%Zona crítica 2
x2_inicial = 2048.7;
x2_final = 2091.4;

y2_inicial = f(x2_inicial);
y2_final = f(x2_final);

fprintf("\nZona crítica 2: \nDe (%.2f, %.2f) hasta (%.2f, %.2f)\n", x2_inicial, y2_inicial, x2_final, y2_final);

fprintf("\nRadio crítico en punto de derrape 1: %.2fm\n", rc(x1_inicial));
fprintf("Radio crítico en punto de derrape 2: %.2fm\n", rc(x2_inicial));

%Puntos de derrape
p1 = [x1_inicial, y1_inicial];
p2 = [x2_inicial, y2_inicial];
fprintf("\nPunto de derrape 1: (%.2f, %.2f)", p1(1), p1(2));
fprintf("\nPunto de derrape 2: (%.2f, %.2f)\n", p2(1), p2(2));

%Pendientes
m1 = df(x1_inicial);
m2 = df(x2_inicial);

fprintf("\nPendiente 1 = %.2f", m1);
fprintf("\nPendiente 2 = %.2f\n", m2);

%Ecuaciones de tangentes
b1 = y1_inicial - m1*x1_inicial;
e_tan1 = @(x) m1.*x + b1;
y_tan1 = tangentes(e_tan1, x, n);
fprintf("\nEcuación de tangente 1:\n y = %.2fx - %.2f\n", m1, abs(b1));

b2 = y2_inicial - m2*x2_inicial;
e_tan2 = @(x) m2.*x + b2;
y_tan2 = tangentes(e_tan2, x, n);
fprintf("\nEcuación de tangente 2:\n y = %.2fx + %.2f\n", m2, b2);

%Ecuaciones paralelas
dist = 20;
[x1_pa, y1_pa] = pitagoras(dist, m1);
[x2_pa, y2_pa] = pitagoras(dist, m2);

ep_tan1 = @(x) m1.*x + b1 - y1_pa;
yp_tan1 = tangentes(ep_tan1, x, n);
fprintf("\nEcuación de paralela 1:\n y = %.2fx - %.2f\n", m1, abs(b1 - y1_pa));

ep_tan2 = @(x) m2.*x + b2 + y2_pa;
yp_tan2 = tangentes(ep_tan2, x, n);
fprintf("\nEcuación de paralela 2:\n y = %.2fx + %.2f\n", m2, abs(b2 + y2_pa));

%Graficacion de las gradas
punto1_gradas = [677.47, -299.219];
punto2_gradas = [2048.68, 2774.72];

xg1 = [punto1_gradas(1) 727.3 727.3 punto1_gradas(1) punto1_gradas(1)];
yg1 = [punto1_gradas(2), -313.3, -323.3, punto1_gradas(2)-10, punto1_gradas(2)];

xg2 = [punto2_gradas(1) 1982 1982 punto2_gradas(1) punto2_gradas(1)];
yg2 = [punto2_gradas(2), 2762, 2772, punto2_gradas(2)+10, punto2_gradas(2)];


%Velocidades de derrape
c_ad = 0.9;
per = tand(12);
v_derrape = @(x) 11.3 * sqrt((c_ad*rc(x) + per) / (1 - c_ad*per));
v1 = v_derrape(p1(1));
v2 = v_derrape(p2(1));
fprintf("\nVelocidad  de derrape en punto 1: %.2f km/h\n", v1);
fprintf("Velocidad  de derrape en punto 2: %.2f km/h\n", v2);

%Gráficas
hold on

plot(x,y);

%plot(pmin(1), pmin(2), "O");
%plot(pmax(1), pmax(2), "O");

plot(xg1, yg1,"magenta");
plot(xg2, yg2,"magenta");

plot(x,y_tan1);
plot(x,yp_tan1);

plot(x,y_tan2);
plot(x,yp_tan2);

plot(x1_inicial, y1_inicial,"O");
plot(x2_inicial, y2_inicial,"O");

%plot(x1_final, y1_final,"O");
%plot(x2_final, y2_final,"O");

hold off

function [y] = simpson(f,a,b,n,x)
    pares = 0;
    impares = 0;
    for i = 2:n
        if (mod(i, 2) == 0)
            pares = pares + f(x(i));
        else
            impares = impares + f(x(i));
        end
    end
    y = f(a) + 4*impares + 2*pares + f(b);
    y = ((b-a)*(y)) / (3*n);
end

function [x1, y1, x2, y2] = formula_general(p)
    
    format long;
    c = [3*p(1) 2*p(2) p(3)];
    
    format long;
    x1 = (-c(2) + sqrt(c(2)^2 - 4 * c(1) * c(3))) / (2 * c(1));
    x2 = (-c(2) - sqrt(c(2)^2 - 4 * c(1) * c(3))) / (2 * c(1));
    y1 = polyval(p,x1);
    y2 = polyval(p,x2);
end

function radios_criticos(rc, a, b, h)
    for i = a:h:b
        radios = rc(i);
        fprintf(" X = %d  Radio:  %f \n", i, radios);
    end
end

function [y] = tangentes(tangente, x, n)
    y  = zeros(1,n+1);
    for i = 1:n+1
        y(i) = tangente(x(i));
    end
end

function [x,y] = pitagoras(hip,m)
    angulo = rad2deg(atan(m));
    x = abs(hip * sind(angulo));
    y = abs(hip * cosd(angulo));
end