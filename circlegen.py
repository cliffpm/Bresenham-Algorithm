import math

cx, cy = 320, 240
R = 100
N = 36

for i in range(N):
    theta0 = 2 * math.pi * i / N
    theta1 = 2 * math.pi * (i+1) / N

    x0 = int(round(cx + R * math.cos(theta0)))
    y0 = int(round(cy + R * math.sin(theta0)))
    x1 = int(round(cx + R * math.cos(theta1)))
    y1 = int(round(cy + R * math.sin(theta1)))

    print(f"{i}: x0={x0}, y0={y0}, x1={x1}, y1={y1}")

