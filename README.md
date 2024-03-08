# ★Modern_Control_Theory★

現代制御理論(解析やシミュレーション)に関するソースコード，関数，Simulinkをまとめたリポジトリ

Notionに技術資料(理論)をまとめています．：　https://placid-dosa-db9.notion.site/489b9b8b105349a3bb0fb0c298434f33?pvs=4

# ◎開発環境

### 〇 開発言語
 
・MATLAB & Simulink

### 〇 バージョン

・2023b
 
### 〇 アドオン(ライブラリ)

 
・Simulink バージョン23.2

　：　シミュレーションのモデル作成

・Control System Toolbox バージョン23.2 

　：　線形制御システムの時間領域や周波数領域における動作の解析，設計，調整
    
・Simulink Control Design バージョン23.2

　：　Simulink でモデル化された制御システムの設計と解析
    
・Symbolic Math Toolbox バージョン23.2

　：　シンボリックな微分、積分、単純化、変換、方程式の求解などを解析的に実行


# ◎ソースコード

 
 ・Primary_system_response_time.m
 
　：　線形1次システムの時間応答解析解の導出
 
 ・n_Secondary_system_response_time.m
 
　：　線形n次システムの時間応答解析解の導出

 ・SET_Sim_of_regulator_control.m
 
　：　レギュレータ制御シミュレーション設定&実行ファイル

 ・SET_Sim_of_integral_servo_I_PD.m
 
　：　積分型サーボ制御(I-PD制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_State_deviation_FB_PD.m
 
　：　状態偏差FB制御(PD制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_State_deviation_FB_P_D.m
 
　：　(微分先行型)状態偏差FB制御(P-D制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_state_deviation_FB_and_output_integral_PID.m
 
　：　状態偏差FB&出力偏差積分制御(PID制御)の性能評価シミュレーション設定&実行ファイル

 ・SET_Sim_of_state_deviation_FB_and_output_integral_PI_D.m
 
　：　(微分先行型)状態偏差FB&出力偏差積分制御(PI-D制御)の性能評価シミュレーション設定&実行ファイル

# ◎関数

 
 ・Function_animate1MSD
 
　：　1慣性機械(マス・ばね・ダンパ)システムのアニメーション描画関数

# ◎Simulink

 ・Model_Sim_of_regulator.slx
 
　：　レギュレータ制御の性能評価シミュレーションSimulinkモデル
 
 ・Model_Sim_of_integral_servo_I_PD.m
 
　：　積分型サーボ制御(I-PD制御)の性能評価シミュレーションSimulinkモデル

 ・Model_Sim_of_State_deviation_FB_PD.m
 
　：　状態偏差FB制御(PD制御)の性能評価シミュレーションSimulinkモデル

 ・Model_Sim_of_State_deviation_FB_P-D_.m
 
　：　(微分先行型)状態偏差FB制御(P-D制御)の性能評価シミュレーションSimulinkモデル

 ・Model_Sim_of_State_deviation_FB_PID_.m
 
　：　状態偏差FB&出力偏差積分制御(PID制御)の性能評価シミュレーションSimulinkモデル

 ・Model_Sim_of_state_deviation_FB_and_output_integral_PI_D.m
 
　：　(微分先行型)状態偏差FB&出力偏差積分制御(PI-D制御)の性能評価シミュレーションSimulinkモデル
 　 
# ◎シミュレーション

 ・レギュレータ制御

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/3f5427c0-83d5-4340-92c3-03a76a1e0f2a

 ・積分型サーボ(I-PD)制御

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/dbc9a7ec-2a10-4e1a-af93-5da3e2852d06

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/b7d78ba7-1f5e-49bb-94da-5360d67c2d14

 ・状態偏差FB制御(PD制御)

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/98f0b807-3419-48f7-8dca-a47416dccb57

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/2f43b704-d55f-4575-bb22-77d01d06f9be

 ・(微分先行型)状態偏差FB制御(P-D制御)

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/2732ffb3-8c89-45ce-b505-01560f211f15

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/847ab0d1-bb5d-4328-b1db-aaa7f66b8018

 ・状態偏差FB&出力偏差積分制御(PID制御)

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/bc24c924-d426-4915-a127-fd87477b7cb7

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/01081db2-c890-4b58-ab0c-e3eadfd95595

 ・(微分先行型)状態偏差FB&出力偏差積分制御(PI-D制御)

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/97d39752-aaa4-46b3-a03c-b2a03c2faa4f

https://github.com/yukichibitamaro/Modern_Control_Theory/assets/127653395/ace3c317-90f9-4997-a81c-dd1938850c87


