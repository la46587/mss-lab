import random
import matplotlib.pyplot as plt
import matplotlib.animation as animation

INITIAL_POPULATION = 100
AREA_SIZE = 100
DURATION = 100
MAX_AGE = 100


class Entity:
    def __init__(self):
        self.x = random.randint(1, AREA_SIZE)
        self.y = random.randint(1, AREA_SIZE)
        self.speed = random.choice([1, 2, 3])
        self.direction = random.choice(['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'])
        self.age = random.randint(0, 60)
        self.status = random.choice(['Z', 'C', 'ZD', 'ZZ'])
        self.immunity = self.calculate_immunity()

    def calculate_immunity(self):
        if self.age < 15 or self.age >= 70:
            return random.uniform(0, 3)
        elif 15 <= self.age < 40:
            return random.uniform(6, 10)
        else:
            return random.uniform(3, 6)

    def move(self):
        if self.direction == 'N':
            self.y = max(1, self.y - self.speed)
        if self.direction == 'NE':
            self.y = max(1, self.y - self.speed)
            self.x = min(AREA_SIZE, self.x + self.speed)
        elif self.direction == 'E':
            self.x = min(AREA_SIZE, self.x + self.speed)
        elif self.direction == 'SE':
            self.y = min(AREA_SIZE, self.y + self.speed)
            self.x = min(AREA_SIZE, self.x + self.speed)
        elif self.direction == 'S':
            self.y = min(AREA_SIZE, self.y + self.speed)
        elif self.direction == 'SW':
            self.y = min(AREA_SIZE, self.y + self.speed)
            self.x = max(1, self.x - self.speed)
        elif self.direction == 'W':
            self.x = max(1, self.x - self.speed)
        elif self.direction == 'NW':
            self.y = max(1, self.y - self.speed)
            self.x = max(1, self.x - self.speed)

        if self.y == AREA_SIZE and self.direction == 'S':
            self.direction = 'N'
        if self.y == AREA_SIZE and self.direction == 'SW':
            self.direction = 'NW'
        if self.y == AREA_SIZE and self.direction == 'SE':
            self.direction = 'NE'
        if self.x == AREA_SIZE and self.direction == 'E':
            self.direction = 'W'
        if self.x == AREA_SIZE and self.direction == 'NE':
            self.direction = 'NW'
        if self.x == AREA_SIZE and self.direction == 'SE':
            self.direction = 'SW'
        if self.y == 1 and self.direction == 'N':
            self.direction = 'S'
        if self.y == 1 and self.direction == 'NW':
            self.direction = 'SW'
        if self.y == 1 and self.direction == 'NE':
            self.direction = 'SE'
        if self.x == 1 and self.direction == 'W':
            self.direction = 'E'
        if self.x == 1 and self.direction == 'NW':
            self.direction = 'NE'
        if self.x == 1 and self.direction == 'SW':
            self.direction = 'SE'

    def update_immunity(self):
        if self.age < 15 or self.age >= 70:
            self.immunity = min(self.immunity, 3)
        elif 15 <= self.age < 40:
            self.immunity = min(self.immunity, 10)
        else:
            self.immunity = min(self.immunity, 6)

    def update_status(self):
        if self.status == 'Z':
            self.status = 'C'
            self.immunity -= 0.10
        elif self.status == 'C':
            self.status = 'ZD'
            self.immunity -= 0.50
        elif self.status == 'ZD':
            self.status = 'ZZ'
            self.immunity += 0.10
        elif self.status == 'ZZ':
            self.immunity += 0.05

        self.update_immunity()

    def update_age(self):
        self.age += 1
        self.update_immunity()

    def is_dead(self):
        return self.age >= MAX_AGE or self.immunity <= 0


def initialize_population(n):
    return [Entity() for _ in range(n)]


def simulate_population(population, duration):
    frames = []
    for _ in range(duration):
        current_frame = []
        for entity in population[:]:
            entity.move()
            entity.update_age()
            entity.update_status()
            if entity.is_dead():
                population.remove(entity)
            else:
                current_frame.append((entity.x, entity.y, entity.status))
        frames.append(current_frame)
    return frames

population = initialize_population(INITIAL_POPULATION)
frames = simulate_population(population, DURATION)


def update(frame):
    plt.cla()
    for x, y, status in frames[frame]:
        color = 'green' if status == 'ZZ' else 'yellow' if status == 'Z' else 'orange' if status == 'ZD' else 'red'
        plt.scatter(x, y, color=color)
    plt.xlim(0, AREA_SIZE)
    plt.ylim(0, AREA_SIZE)
    plt.title(f"Tura {frame + 1}")

fig, ax = plt.subplots()
ani = animation.FuncAnimation(fig, update, frames=len(frames), repeat=False)
plt.show()
