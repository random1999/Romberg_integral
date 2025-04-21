% ======================================================================================
% 作者： cx
% 时间： 2025-04-18
% 实现： 变步长梯形公式计算定积分
% ======================================================================================
function [R,I,S]=Iterative_trapezoid_integral(f,a,b,eps) 
% 变步长梯形公式
%f：被积函数
%a：积分下限
%b：积分上限
%eps：要求精度
%R：积分结果
%I：迭代次数
%S：每次迭代估计值

if nargin < 4
    eps = 1e-4; % 默认精度
end

i=1;        %迭代计数
N=2^(i-1);  %划分区间数
h=(b-a)/N;  %步长
err=1;
S(i)=h/2*(f(a)+f(b));
while( err > eps )
    i=i+1;
    N=2^(i-1);
    h=(b-a)/N;
    S(i)=S(i-1)/2;
    for n=1:2:N-1
      S(i)=S(i)+h*f(a+n*h);
    end
    err=abs((S(i)-S(i-1))/S(i));
end
R=S(i);
I=i;
end

%% 测试
clear;clc;close all;
% y=@(x) 4/3.*(4./ (((cos(x)-sin(x)/sqrt(3)).^2).*cos(x).^2)); %定义被积函数
% a=0;b=pi/12;
y=@(x) x.^2.*sin(x)+x.^3.*cos(x); %定义被积函数
a=0;b=5;

R1=integral(y,a,b);
[R2,I,S]=Iterative_trapezoid_integral(y,a,b,1e-4);

disp("matlab内置积分函数结果为:"+R1);
disp("变步长梯形法则积分结果为:"+R2+",划分区间数:"+2^(I-1)+",迭代次数:"+I+" ,相对误差为:"+(R1-R2)/R1);