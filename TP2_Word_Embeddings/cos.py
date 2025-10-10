from scipy import spatial
import numpy as np

def cosine_similarity_numpy(A, B):
    # Compute the dot product of A and B
    dot_product = np.dot(A, B)

    # Compute the magnitude of A and B
    norm_A = np.linalg.norm(A)
    norm_B = np.linalg.norm(B)

    # Compute the cosine similarity
    cosine_sim = dot_product / (norm_A * norm_B)

    return cosine_sim

def cosine_similarity_scipy(A, B):
    # Compute the cosine similarity
    cos_sim = 1 - spatial.distance.cosine(A, B)

    return cos_sim
"""
TESTS
# Example vectors
A = np.array([1, 2, 3])
B = np.array([4, 5, 6])

cos_sim = cosine_similarity_scipy(A, B)
print(cos_sim)

# Example vectors
A = np.array([1, 2, 3])
B = np.array([4, 5, 6])

cos_sim = cosine_similarity_numpy(A, B)
print(cos_sim)"""
