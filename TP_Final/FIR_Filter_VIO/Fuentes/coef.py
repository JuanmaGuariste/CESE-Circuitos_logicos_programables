import numpy as np

fs = 12.5e6
fc = 350e3
N  = 32
L  = N + 1
n  = np.arange(L)

# 1) Respuesta ideal
fc_norm = fc/fs
h_ideal = 2*fc_norm * np.sinc(2*fc_norm*(n - N/2))

# 2) Ventana de Hamming
w = 0.54 - 0.46 * np.cos(2*np.pi*n/N)

# 3) FIR con ventana
h_win = h_ideal * w

# 4) Escalado a 12 bits (Q11)
scale = 2**11 - 1
h_int = np.round(h_win * scale).astype(int)


print("Coeficientes FIR:")
for coef in h_int:
    print(f"{coef:.10f}")