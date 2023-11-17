import torch

print(torch.cuda.is_available())  # Should return True if CUDA is available
print(torch.version.cuda)         # Should print the CUDA version


import tensorflow as tf
print(tf.test.is_gpu_available())  # Should return True if CUDA is available
print(tf.test.gpu_device_name())   # Should print the GPU device name if available
