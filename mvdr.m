function w = mvdr(Ns, x, a_theta_0)

    R_xx = (x*x') / Ns % 參考講義 ch5 p.24 MVDR的解
    lambda = 1/(a_theta_0'*inv(R_xx)*a_theta_0);

    w = lambda * inv(R_xx) * a_theta_0;
end