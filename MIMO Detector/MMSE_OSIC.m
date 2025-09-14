function [ symbol_MMSE_OSIC ] = MMSE_OSIC(Da_Str,y,H,NPW)

F = H'*H;
in_match = H'*y;
symbol_MMSE_OSIC = zeros(Da_Str,1);
dec_table = 1:Da_Str;

for k = 1:Da_Str    %Ch5 p.125
    G = pinv(F*F' + NPW*F)*F;
    [~, idx] = sort(diag(G'*G));
    o_n = idx(1);
    w_o_n = G(:, o_n);
    z_o_n = w_o_n' * in_match;
    if real(z_o_n) >= 0
        x_hat_o_n_r = 1;
    else
        x_hat_o_n_r = -1;
    end
    if imag(z_o_n) >= 0
        x_hat_o_n_i = 1;
    else
        x_hat_o_n_i = -1;
    end
    x_hat_o_n = ( x_hat_o_n_r + 1i*x_hat_o_n_i );
    symbol_MMSE_OSIC(dec_table(o_n),1) = x_hat_o_n/sqrt(2);
    y = y - H(:, o_n) * x_hat_o_n/sqrt(2);

    dec_table(o_n) = [];
    H(:,o_n) = [];
    in_match = H'*y;
    F = H'*H;
end

symbol_MMSE_OSIC = qamdemod(symbol_MMSE_OSIC,4);
end
