import torch

device = torch.device('mps')
a = torch.tensor([3])
print(a.to(device))
print('test')