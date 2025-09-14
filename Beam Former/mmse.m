function w = mmse(Ns, x, a_theta_0, sp)

    % 計算x與s之間的correlation和x的關係矩陣
    r_xs = (x * (a_theta_0*sp)') / Ns;
    R_xx = (x*x') / Ns;

    w = inv(R_xx) * r_xs;
end