function dydt = vdp1(t, y)
dydt = [y(2); y(1) + 2 * sinh(t)];