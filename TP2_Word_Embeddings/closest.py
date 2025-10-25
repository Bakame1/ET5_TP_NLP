import numpy as np
#2.2.3
def closest(vectors, vector, n=10):
    # Increase n by 1 to include the vector itself in the results
    n = n + 1

    # Normalize the vectors to ensure that the dot product is equivalent to cosine similarity
    normalized_vectors = vectors / np.linalg.norm(vectors, axis=1, keepdims=True)
    normalized_vector = vector / np.linalg.norm(vector)

    # Calculate the dot product between each vector in the matrix 'vectors' and the target vector 'vector'
    # This gives a measure of similarity (the higher the score, the more similar the vectors are)
    scores = np.dot(normalized_vectors, normalized_vector.T)

    # Use np.argpartition to get the indices of the n highest scores
    # np.argpartition is more efficient than np.argsort when you only want the top n elements
    indices = np.argpartition(scores, -n)[-n:]

    # Sort the indices of the n highest scores to get them in ascending order
    indices = indices[np.argsort(scores[indices])]

    # Initialize a list to store the results
    output = []

    # Iterate over the indices of the n highest scores
    for i in [int(x) for x in indices]:
        # Append a pair (score, index) to the output list
        output.append((scores[i], i))

    # Return the list of (score, index) pairs in descending order of scores
    return reversed(output)
