import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


# Równanie Lotki-Volterry
def lotka_volterra(t, y, alpha, beta, delta, gamma):
    prey, predator = y
    dprey_dt = alpha * prey - beta * prey * predator
    dpredator_dt = delta * prey * predator - gamma * predator
    return np.array([dprey_dt, dpredator_dt])


# Metoda Rungego-Kutty
def rk4(func, t, y, dt, *args):
    k1 = func(t, y, *args)
    k2 = func(t + dt / 2, y + dt * k1 / 2, *args)
    k3 = func(t + dt / 2, y + dt * k2 / 2, *args)
    k4 = func(t + dt, y + dt * k3, *args)
    return y + dt * (k1 + 2 * k2 + 2 * k3 + k4) / 6


# Parametry
alpha = 0.1
beta = 0.02
delta = 0.01
gamma = 0.1


y0 = np.array([40, 9])
t = np.linspace(0, 200, 1000)
dt = t[1] - t[0]

# Rozwiązywanie układu równań różniczkowych
prey = np.zeros_like(t)
predator = np.zeros_like(t)
y = y0
for i in range(len(t)):
    prey[i] = y[0]
    predator[i] = y[1]
    y = rk4(lotka_volterra, t[i], y, dt, alpha, beta, delta, gamma)

fig, ax = plt.subplots()
ax.set_xlim(0, 100)
ax.set_ylim(0, 100)
prey_scatter, = ax.plot([], [], 'bo', markersize=3, label='Ofiary')
predator_scatter, = ax.plot([], [], 'ro', markersize=3, label='Drapieżniki')
ax.legend()


def init():
    prey_scatter.set_data([], [])
    predator_scatter.set_data([], [])
    return prey_scatter, predator_scatter


def update(frame):
    num_prey = int(prey[frame])
    num_predator = int(predator[frame])

    prey_x = np.random.rand(num_prey) * 100
    prey_y = np.random.rand(num_prey) * 100
    predator_x = np.random.rand(num_predator) * 100
    predator_y = np.random.rand(num_predator) * 100

    prey_scatter.set_data(prey_x, prey_y)
    predator_scatter.set_data(predator_x, predator_y)

    return prey_scatter, predator_scatter


anim = animation.FuncAnimation(fig, update, frames=len(t), init_func=init, blit=True, interval=20, repeat=False)

plt.xlabel('Pozycja X')
plt.ylabel('Pozycja Y')
plt.title('Animacja')
plt.grid()
plt.show()

# Wizualizacja populacji w czasie
plt.figure(figsize=(12, 6))
plt.plot(t, prey, 'b', label='Ofiary')
plt.plot(t, predator, 'r', label='Drapieżniki')
plt.xlabel('Czas')
plt.ylabel('Populacja')
plt.title('Populacje drapieżników i ofiar')
plt.legend()
plt.grid()
plt.show()

# Wizualizacja fazowa
plt.figure(figsize=(6, 6))
plt.plot(prey, predator, 'b', label='Trajektoria fazowa')
plt.xlabel('Populacja ofiar')
plt.ylabel('Populacja drapieżników')
plt.title('Portret fazowy')
plt.legend()
plt.grid()
plt.show()
