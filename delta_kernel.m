function dydt = delta_kernel(x, t)
dydt = x - t + (rand - 0.5) * 2 * 0.5;