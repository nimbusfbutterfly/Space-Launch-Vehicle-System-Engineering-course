function dfdt = rocket_simulation(t, F)
    v_xs = F(1);
    v_ys = F(2);
    x = F(3);
    y = F(4);

    % Define the constants and parameters
    M0=[1.0811e5, 20000]
    mdot=[552.83, 45.455]
    tb=[147.15,372.11]
    Th=[1.4595e5, 16000]
    pich=[deg2rad(30), deg2rad(-2.5)];
    H = 200;
    R_earth = 6378.14;
    mu = 3.9862e5;
    g0=9.81;

    h = sqrt(x^2 + (y + R_earth)^2) - R_earth;

    v = sqrt(v_xs^2 + v_ys^2);

    % Calculate t_v
    t_v = 3.9459 * (Th(1) / M0(1))^2 - 23.4866 * Th(1) / M0(1) + 36.6510;

    if t <= t_v
        alpha = 0;
    else
        alpha = deg2rad(2);
    end

    % Call the ATMOSFER function
    [ro, c] = ATMOSFER(h);

    % Call the faero function
    [Fd, Fl] = faero(h, v, alpha);

    g = mu / (h + R_earth)^2;
    theta = atan2(x, (y + R_earth));

    if t <= t_v
        pitch = pi / 2;
    elseif t <= tb(1)
        pitch = ((pi / 2) - pich(1)) * ((tb(1) - t) / (tb(1) - t_v))^2 + pich(1);
    else
        a = (25 * sqrt(3)) / 16872 + 157305124970735525 / 810503817738613424128;
        b = (37211 * sqrt(3)) / 67488 + 92589796557774930015 / 3242015270954453696512;
        pitch = atan(b - a * (t-tb(1)));
    end

    phi = pitch + alpha;

    R = [cos(phi - theta), -sin(phi - theta);
         sin(phi - theta), cos(phi - theta)];

    if t <= tb(1)
        F_xb = Th(1) * g - Fd * cos(alpha) - Fl * sin(alpha);
        F_yb = -Fl * cos(alpha) - Fd * sin(alpha);
    else
        F_xb = Th(2) * g;
        F_yb = 0;
    end

    F_S = R * [F_xb; F_yb];

    if t <= tb(1)
        m = M0(1) - mdot(1) * t;
    else
        m = M0(2) - mdot(2) * (t - tb(1));
    end

    a_xs = F_S(1) / m;
    a_ys = F_S(2) / m;
    g_xs = -g * sin(theta);
    g_ys = -g * cos(theta);
    a_xs = a_xs + g_xs;
    a_ys = a_ys + g_ys;

    T_LS = [cos(theta), -sin(theta);
            sin(theta), cos(theta)];

    a_l = T_LS' * [a_xs; a_ys];
    v_l = T_LS' * [v_xs; v_ys];

    dfdt = [a_l(1); a_l(2); v_l(1); v_l(2)];

end
