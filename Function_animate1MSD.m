% k = 1のみに変更するひつようあり

function Function_animate1MSD(Time, Displacement,Target,Control_Input,animation_sampling,wide)
    %% 初期設定
    % 質点の設定
    Nmass = 1; % 慣性体の数を設定
    w = wide;  % 慣性体の幅の設定
    h = 2.2;   % 慣性体の高さの設定
    y = 0;     % 慣性体の位置の設定
    % 変数設定
    t = linspace(Time(1), Time(end), animation_sampling); % シミュレーション時間をアニメーションステップ数に分割して時間ベクトルを生成
    x = zeros(animation_sampling, Nmass); % 質点の位置の空行列を定義
    u = zeros(animation_sampling, Nmass); % 制御入力の空行列を定義
    % ルックアップテーブルを使用して各質点の位置や入力をアニメーション時間に対して離散点を補間する
    for k = 1:Nmass 
        x(:, k) = interp1(Time, Displacement(:, k), t);  % 質点の位置 
        u(:,k)  = interp1(Time, Control_Input(:, k), t); % 制御入力
    end
    spacing = fix(2 * max(abs(x), [], "all")); % 初期位置設定
    remainder = mod(spacing,5);
    difference = 5 - remainder;
    if (remainder ~= 0)
    spacing = spacing + difference;
    end
    xmax = spacing * 2; % x軸の範囲を設定
    %% 動画の保存準備
    filename = 'Animation.mp4'; % 保存する動画ファイル名
    vidObj = VideoWriter(filename, 'MPEG-4'); % VideoWriterオブジェクトの作成
    open(vidObj); % 動画ファイル起動 
    %% アニメーションの描画
    fig = figure;
    set(fig, 'Position', get(0,'Screensize')); % ディスプレイに対してフルスクリーンでグラフ描画
    for j = 1:numel(t)
        % 質点の挙動(アニメーション)を表示するサブプロットを作成
        subplot(3,1,1)
        cla % サンプリングごとの慣性体,ばね,ダンパの履歴消去
        hold on
        x0k = 0; % ばね，ダンパの左端点の位置
        for k = 1:Nmass
            % ばねの描画
            xc = spacing * k + x(j,k);     % 慣性体の位置(重心)設定       
            xs = linspace(x0k,xc,spacing); % ばねのギザギザ具合の設定1
            ys = 0.3*(-1).^(1:numel(xs));  % ばねのギザギザ具合の設定2
            plot(xs,ys + 1.65,"k");        % ばねの描画(ばねの高さもオフセットして設定)
            % ダンパの描画
            yd = 0.5; % ダンパの高さ位置設定
            xd = x0k + (xc-x0k)*0.5+0.1;
            xd2 = x0k + (xc-x0k)*0.5;
            xd3 = x0k + (xc-x0k)*0.5 + 0.5;
            plot([x0k,xd,NaN,xd,xd],[yd,yd,NaN,yd-0.3,yd+0.3],"k")
            plot([xd2,xd3,NaN,xd2,xd3,NaN,xd3,xd3,NaN,xd3,xc],[yd-0.5,yd-0.5,NaN,yd+0.5,yd+0.5,NaN,yd-0.5,yd+0.5,NaN,yd,yd],"k")
            % 慣性体の位置を更新
            x0k = xc + w;
            % 慣性体の描画
            x1 = spacing*k + x(j,k) - w/2;
            rectangle("Position",[x1 y w h],"FaceColor","k")
            % Plot x1, x2 distances
            if (x(j,k) > 0)
                quiver(spacing*k, y+h*1.1, x(j,k),0,"k-","MaxHeadSize",1/(x(j,k))^1,'AutoScale','off','LineWidth',3)
            elseif (x(j,k) < 0)
                quiver(spacing*k, y+h*1.1, x(j,k),0,"k-","MaxHeadSize",1/(-x(j,k))^1,'AutoScale','off','LineWidth',3)
            else
                quiver(spacing*k, y+h*1.1, 0,0,"k-","MaxHeadSize",1,'AutoScale','off','LineWidth',3)
            end
            %quiver(spacing*k, y+h*1.1, x(j,k),0,"k-","MaxHeadSize",1/(x(j,k))^1,'AutoScale','off','LineWidth',3,'ShowArrowHead','off')
            plot([1;1]*[spacing*k, spacing*k+x(j,k)],[0.95;1.1]*(y*[1,1]+h*1.1),"k-","markersize",12)
            text((spacing*k + spacing*k+x(j,k))/2,(y+h*1.3),"q(t)",'FontAngle', 'italic',"HorizontalAlignment","Center",'FontSize',25)
            plot(spacing*k+x(j,k)-w/4,-0.25,'ko','MarkerSize',25,'MarkerFaceColor','k')
            plot(spacing*k+x(j,k)+w/4,-0.25,'ko','MarkerSize',25,'MarkerFaceColor','k')
        end
        axis([0, xmax, -0.5, 3]) % 軸の範囲を変更
        set(gca, "ytick", [])    % y軸消去
        h_axes = gca;
        h_axes.XAxis.FontSize = 22; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 22; % y軸フォントサイズの設定
        tick_values1 = linspace(0, xmax, fix(xmax/5)+1);
        tick_values2 = linspace(-spacing, spacing, fix(xmax/5)+1);
        xticks(tick_values1);
        xticklabels(arrayfun(@num2str, tick_values2, 'UniformOutput', false));
        xlabel("Displacement [m]")
        hold off
        % シミュレーション結果の描画(慣性体の位置)
        subplot(3,1,2) 
        cla
        hold on
        plot(Time, Target,':k','LineWidth',4.0)
        plot(t, x,'-b','LineWidth',4.0)
        for k = 1:Nmass
            plot(t(j), x(j, k), "bo", "MarkerFaceColor", 'b', 'MarkerSize', 10)
        end
        grid on;
        h_axes = gca;
        h_axes.XAxis.FontSize = 22; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 22; % y軸フォントサイズの設定
        %xlim([0,max(Time)])
        %ylim([max(-Displacement)-2,max(Displacement)+2])
        xlabel("Time [s]")
        ylabel("Displacement [m]")
        hold off
        % シミュレーション結果の描画(制御入力)
        subplot(3,1,3)
        cla % サンプリングごとのマーカー履歴消去
        hold on % グラフの保持
        plot(t, u,'-b','LineWidth',4.0)
        for k = 1:Nmass
            plot(t(j), u(j, k), "bo", "MarkerFaceColor", 'b', 'MarkerSize', 10)
        end
        grid on;
        h_axes = gca;
        h_axes.XAxis.FontSize = 22; % x軸フォントサイズの設定
        h_axes.YAxis.FontSize = 22; % y軸フォントサイズの設定
        xlabel("Time [s]")
        ylabel("Control input [N]")
        hold off
        % アニメーション& 動画処理
        drawnow % アニメーションの確実な実行
        writeVideo(vidObj, getframe(fig)); % フレームを動画に書き込む
    end
    close(vidObj); % 動画ファイルを閉じる
end