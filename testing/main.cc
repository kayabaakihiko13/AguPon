#include <iostream>
#include "../src/include/math.hh"

int main() {
    const int size = 1024;
    float a[size], b[size], c[size];

    // Initialize input arrays
    for (int i = 0; i < size; ++i) {
        a[i] = i;
        b[i] = size - i;
    }

    // Call CUDA function
    addVectors(a, b, c, size);

    // Output result
    for (int i = 0; i < size; ++i) {
        std::cout << c[i] << " ";
    }
    std::cout << std::endl;

    return 0;
}
