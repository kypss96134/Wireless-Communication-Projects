function [ symbol_MMSE ] = MMSE(Da_Str,y,H,NPW)%函數返回檢測到的符號 symbol_MMSE

symbol_MMSE = zeros(Da_Str,1);
W_mmse = H *inv(H'*H + Da_Str*NPW*eye(Da_Str)); % Ch5 p.118
z = W_mmse'*y;

%將檢測結果 z 進行解調
symbol_MMSE = (((real(z)>=0)-(real(z)<0))+1i*((imag(z)>=0)-(imag(z)<0)))/sqrt(2);
symbol_MMSE = qamdemod(symbol_MMSE,4);
end