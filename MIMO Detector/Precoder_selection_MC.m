function [ precoder ] = Precoder_selection_MC(codebook,H,Da_Str,noise_power)

codebook_size = 8;
%% Maximum Capacity Criterion
MC_value = zeros(1,codebook_size);
for ii=1:codebook_size
    F_ii = codebook(:, :, ii);  %Ch5 p.158
    MC_value(1,ii) = log(det( eye(Da_Str) + (1/noise_power)*(F_ii')*(H')*H*F_ii ));
end
[~,F_index] = max(MC_value);
precoder = codebook(:,:,F_index);

end
