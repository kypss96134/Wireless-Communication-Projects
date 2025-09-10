function w = msinr(Ns, x, a_theta_0, sp)
    x_k = x - (a_theta_0*sp);
    R_in = (x_k * x_k') / Ns ;

    lambda = 1/(a_theta_0' * inv(R_in) * a_theta_0);
    w = lambda * inv(R_in) * a_theta_0;
end