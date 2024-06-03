import random
import matplotlib.pyplot as plt
import matplotlib.animation as animation

INITIAL_POPULATION = 100
AREA_SIZE = 100
DURATION = 200
MAX_AGE = 100


class Entity:
    def __init__(self, status, age):
        self.x = random.randint(1, AREA_SIZE)
        self.y = random.randint(1, AREA_SIZE)
        self.speed = random.choice([1, 2, 3])
        self.direction = random.choice(['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'])
        self.age = age if age is not None else random.randint(0, 60)
        self.status = status if status is not None else random.choice(['Z', 'C', 'ZD', 'ZZ'])
        self.frames_in_status = 0
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
        self.frames_in_status += 1
        if self.status == 'Z' and self.frames_in_status >= 2:
            self.status = 'C'
            self.frames_in_status = 0
        elif self.status == 'C' and self.frames_in_status >= 7:
            self.status = 'ZD'
            self.frames_in_status = 0
        elif self.status == 'ZD' and self.frames_in_status >= 5:
            self.status = 'ZZ'
            self.frames_in_status = 0

        if self.status == 'Z':
            self.immunity -= 0.10
        elif self.status == 'C':
            self.immunity -= 0.50
        elif self.status == 'ZD':
            self.immunity += 0.10
        elif self.status == 'ZZ':
            self.immunity += 0.05

        self.update_immunity()

    def update_age(self):
        self.age += 1
        self.update_immunity()

    def is_dead(self):
        return self.age >= MAX_AGE or self.immunity <= 0


def distance(p, q):
    return max(abs(p.x - q.x), abs(p.y - q.y))


def contact(p, q, population):
    if p.status == 'ZZ' and q.status == 'Z':
        if p.immunity <= 3:
            p.status = 'Z'
    elif p.status == 'Z' and q.status == 'ZZ':
        if q.immunity <= 3:
            q.status = 'Z'
    elif p.status == 'ZZ' and q.status == 'C':
        if p.immunity <= 6:
            p.status = 'Z'
        else:
            p.immunity -= 3.0
    elif p.status == 'C' and q.status == 'ZZ':
        if q.immunity <= 6:
            q.status = 'Z'
        else:
            q.immunity -= 3.0
    elif p.status == 'ZZ' and q.status == 'ZD':
        q.immunity += 1.0
    elif p.status == 'ZD' and q.status == 'ZZ':
        p.immunity += 1.0
    elif p.status == 'ZZ' and q.status == 'ZZ':
        p.immunity = max(p.immunity, q.immunity)
        q.immunity = max(p.immunity, q.immunity)
        p.update_immunity()
        q.update_immunity()
    elif p.status == 'C' and q.status == 'Z':
        if q.immunity <= 6:
            q.status = 'C'
        p.frames_in_status = 0
    elif p.status == 'Z' and q.status == 'C':
        if p.immunity <= 6:
            p.status = 'C'
        q.frames_in_status = 0
    elif p.status == 'C' and q.status == 'ZD':
        if q.immunity <= 6:
            q.status = 'Z'
    elif p.status == 'ZD' and q.status == 'C':
        if p.immunity <= 6:
            p.status = 'Z'
    elif p.status == 'C' and q.status == 'C':
        p.immunity = min(p.immunity, q.immunity)
        q.immunity = min(p.immunity, q.immunity)
        p.frames_in_status = 0
        q.frames_in_status = 0
    elif p.status == 'Z' and q.status == 'ZD':
        q.immunity -= 1.0
    elif p.status == 'ZD' and q.status == 'Z':
        p.immunity -= 1.0
    elif p.status == 'Z' and q.status == 'Z':
        p.immunity -= 1.0
        q.immunity -= 1.

    p_directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
    p_directions.remove(p.direction)
    p.direction = random.choice(p_directions)

    q_directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
    q_directions.remove(q.direction)
    q.direction = random.choice(q_directions)

    if 20 <= p.age <= 40 and 20 <= q.age <= 40:
        if random.random() < 0.5:
            new_entities = random.choice([1, 2])
            for _ in range(new_entities):
                newborn = Entity('ZZ', 0)
                newborn.x = random.choice([p.x, q.x])
                newborn.y = random.choice([p.y, q.y])
                population.append(newborn)


def initialize_population(n):
    return [Entity(None, None) for _ in range(n)]


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

        for i in range(len(population)):
            for j in range(i + 1, len(population)):
                if distance(population[i], population[j]) <= 2:
                    contact(population[i], population[j], population)

        frames.append(current_frame)
    return frames


population = initialize_population(INITIAL_POPULATION)
frames = simulate_population(population, DURATION)


def update(frame):
    plt.cla()
    current_population = len(frames[frame])
    sick_population = sum(1 for _, _, status in frames[frame] if status in ('Z', 'C'))
    sick_percentage = (sick_population / current_population) * 100 if current_population > 0 else 0
    for x, y, status in frames[frame]:
        color = 'green' if status == 'ZZ' else 'gold' if status == 'Z' else 'darkorange' if status == 'ZD' else 'red'
        plt.scatter(x, y, color=color)
    plt.xlim(0, AREA_SIZE)
    plt.ylim(0, AREA_SIZE)
    plt.title(f"Tura {frame + 1}")
    plt.text(0, AREA_SIZE + 5, f"Populacja: {current_population}", fontsize=12)
    plt.text(0, AREA_SIZE + 10, f"Procent chorych: {sick_percentage:.2f}%", fontsize=12)


fig, ax = plt.subplots()
ani = animation.FuncAnimation(fig, update, frames=len(frames), repeat=False)
plt.show()
