import scipy.io as scio
import numpy as np
import numpy.linalg as nplin
import matplotlib.pyplot as plt

# Zadanie 1

f = scio.loadmat("lab11_data1.mat")
data1 = f["data1"]
Xtest = data1[:, 0:2]  # x'', y''
Ztest = data1[:, 2:]  # x', y', x, z

f = scio.loadmat("lab11_data2.mat")
data2 = f["data2"]
Xtrain = data2[:, 0:2].T  # x'', y''
Ztrain = data2[:, 2:].T  # x', y', x, z

Rs = Xtrain @ Ztrain.T
Ps = Ztrain @ Ztrain.T
A1 = Rs @ nplin.inv(Ps)
print(f"A1 = {A1}")

Z2train = np.concatenate((Ztrain, Ztrain ** 2), axis=0)
Rs = Xtrain @ Z2train.T
Ps = Z2train @ Z2train.T
A2 = Rs @ nplin.inv(Ps)
print(f"A2 = {A2}")

# Zadanie 2

xpp = Ztest @ A1[0, :].T
ypp = Ztest @ A1[1, :].T

msex1 = np.mean((xpp - Xtest[:, 0]) ** 2)
msey1 = np.mean((ypp - Xtest[:, 1]) ** 2)
mse1 = (msex1 + msey1) / 2
print(f"A1 --- Err x'': {msex1}, Err y'': {msey1}, avs Err: {mse1}")

xpp = np.concatenate((Ztest, Ztest ** 2), axis=1) @ A2[0, :].T
ypp = np.concatenate((Ztest, Ztest ** 2), axis=1) @ A2[1, :].T

msex2 = np.mean((xpp - Xtest[:, 0]) ** 2)
msey2 = np.mean((ypp - Xtest[:, 1]) ** 2)
mse2 = (msex2 + msey2) / 2
print(f"A2 --- Err x'': {msex2}, Err y'': {msey2}, avg Err: {mse2}")

# Zadanie 3

d2x = lambda dx, dy, x, y: np.array([dx, dy, x, y]) @ A1[0, :].T
d2y = lambda dx, dy, x, y: np.array([dx, dy, x, y]) @ A1[1, :].T
x0 = [60]
y0 = [0]
x1 = [0]
y1 = [0]
x2 = [d2x(x1[-1], y1[-1], x0[-1], y0[-1])]
y2 = [d2y(x1[-1], y1[-1], x0[-1], y0[-1])]

h = 2 ** (-8)
stop = 500

for t in np.arange(h, stop, h):
    # x = x + x' * h
    x0.append(x0[-1] + x1[-1] * h)
    y0.append(y0[-1] + y1[-1] * h)
    x1.append(x1[-1] + x2[-1] * h)
    y1.append(y1[-1] + y2[-1] * h)
    x2.append(d2x(x1[-1], y1[-1], x0[-1], y0[-1]))
    y2.append(d2y(x1[-1], y1[-1], x0[-1], y0[-1]))

plt.figure()
plt.plot(Ztest[:, 2], Ztest[:, 3], 'r')
plt.title('Z PLIKU')
plt.figure()
plt.plot(x0, y0, 'b')
plt.title("Euler")
plt.show()
