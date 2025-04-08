Ts = 0.1;
s = tf('s');
Hyu = 1/(2*s^2 + 3*s + 1);
Hyud = c2d(Hyu, Ts, 'zoh')
Hyud.Variable = 'q^-1'

[B, A] = tfdata(Hyud, 'v');
Hyud2 = filt(B, A, Ts)