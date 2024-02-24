%% 任意の時間応答(ステップ応答)のサンプルコード
%% バージョン：MATLAB 2023b

%% RESET
clear variables; % 変数消去
close all;       % Figure消去
clc;             % コマンドウィンドウの履歴消去
format compact;  % 余計な改行を消去
%% SYMBOLIC VARIABLE DEFINITION
syms R C E q0 t tau
%% DEFINING STATE-SPACE MODEL
a = -1/(R*C);
b = 1/R;
c = 1;
d = 0;
x0 = q0;
u = E;
%% CALCULATING TIME RESPONSE
% 零状態応答
y1 = c * q0 * exp(a*t);
% 零入力応答
f = exp(a*(t-tau))*b*u;
y2 = int(f,tau,[0,t]);
% 時間応答
disp("ステップ応答の解析解")
y = y1 + y2
