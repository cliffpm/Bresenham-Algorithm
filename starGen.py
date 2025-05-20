import math


width = 640
height = 480

center_x = width // 2
center_y = height // 2
outer_radius = 100
inner_radius = 40
num_points = 5


points = []
angle_offset = -math.pi / 2 

for i in range(num_points * 2):
    angle = angle_offset + (i * math.pi / num_points)
    r = outer_radius if i % 2 == 0 else inner_radius
    x = int(center_x + r * math.cos(angle))
    y = int(center_y + r * math.sin(angle))
    points.append((x, y))


lines = []
for i in range(len(points)):
    x0, y0 = points[i]
    x1, y1 = points[(i + 1) % len(points)]
    lines.append((x0, y0, x1, y1))
for i, (x0, y0, x1, y1) in enumerate(lines):
    print(f"{i}: x0={x0}, y0={y0}, x1={x1}, y1={y1}")
