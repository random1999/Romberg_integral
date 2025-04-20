% ======================================================================================
% 作者： cx
% 时间： 2025-04-18
% 实现： Newtion-cotes公式计算定积分
% ======================================================================================
function [R]=trapezoid_integral(f,a,b) 
% 梯形法则
%f：被积函数
%a：积分下限
%b：积分上限
%R：积分结果
R=(b-a)*(f(a)+f(b))/2;
end

function [R]=simpson3point_integral(f,a,b) 
% simpson1/3法则
%f：被积函数
%a：积分下限
%b：积分上限
%R：积分结果
R=(b-a)*(f(a)+4*f((a+b)/2)+f(b))/6;
end

function [R]=simpson4point_integral(f,a,b) 
% simpson3/8法则
%f：被积函数
%a：积分下限
%b：积分上限
%R：积分结果
h=(b-a)/3;
R=(b-a)*(f(a)+3*f(a+h)+3*f(a+2*h)+f(b))/8;
end

function [R]=boole_integral(f,a,b) 
% 布尔法则
%f：被积函数
%a：积分下限
%b：积分上限
%R：积分结果
h=(b-a)/4;
R=(b-a)*(7*f(a)+32*f(a+h)+12*f(a+2*h)+32*f(a+3*h)+7*f(b))/90;
end

%% 测试
clear;clc;close all;
% y=@(x) 4/3.*(4./ (((cos(x)-sin(x)/sqrt(3)).^2).*cos(x).^2)); %定义被积函数
% a=0;b=pi/12;
y=@(x) x.^2.*sin(x)+x.^3.*cos(x); %定义被积函数
a=0;b=5;                          %对于这种较大的积分区间，Newtion-cotes公式的计算精度会明显下降

R1=integral(y,a,b);
R2=trapezoid_integral(y,a,b);
R3=simpson3point_integral(y,a,b);
R4=simpson4point_integral(y,a,b);
R5=boole_integral(y,a,b);

disp("matlab内置积分函数结果为:"+R1);
disp("梯形法则积分结果为:"+R2+" ,相对误差为:"+(R1-R2)/R1);
disp("simpson1/3法则积分结果为:"+R3+" ,相对误差为:"+(R1-R3)/R1);
disp("simpson3/8法则积分结果为:"+R4+" ,相对误差为:"+(R1-R4)/R1);
disp("布尔法则积分结果为:"+R5+" ,相对误差为:"+(R1-R5)/R1);


%验证变步长梯形迭代公式
% h1=(b-a);
% t1=trapezoid_integral(y,a,b)
% h2=(b-a)/2;
% t2_1=trapezoid_integral(y,a,a+h2)+trapezoid_integral(y,a+h2,a+2*h2)
% t2_2=t1/2+h2*(y(a+h2))
% h3=(b-a)/4;
% t3_1=trapezoid_integral(y,a,a+h3)+trapezoid_integral(y,a+h3,a+2*h3)+trapezoid_integral(y,a+2*h3,a+3*h3)+trapezoid_integral(y,a+3*h3,a+4*h3)
% t3_2=t2_1/2+h3*( y(a+h3)+y(a+3*h3) )