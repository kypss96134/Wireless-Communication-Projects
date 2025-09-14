function [ symbol_ML ] = ML(Da_Str,y,H,Q,R,NPW)
    symbol_ML = zeros(Da_Str, 1);
    symbols = [(1+1i)/sqrt(2); (1-1i)/sqrt(2); (-1+1i)/sqrt(2); (-1-1i)/sqrt(2)];
    symbol_combinations = combvec(symbols', symbols', symbols', symbols');

    % 計算每個符號組合的誤差
    errors = zeros(1, size(symbol_combinations, 2));
    for i = 1: size(symbol_combinations, 2)
        estimated_y = H * symbol_combinations(:,i); %4*1
        errors(i) = norm(y-estimated_y);       
    end
    %找到最小誤差項的組合
    [~, idx] = min(errors);
    symbol_combination = symbol_combinations(:, idx);

    % 將符號組合進行解調
    real_p = (real(symbol_combination) >= 0) - (real(symbol_combination) < 0);
    imag_p = (imag(symbol_combination) >= 0) - (imag(symbol_combination) < 0);
    symbol_ML = (real_p + 1i * imag_p) / sqrt(2);

    % QAM 解調
    symbol_ML = qamdemod(symbol_ML, 4);
end