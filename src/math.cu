// #include <math.h>
#include "include/math.hh"
#include <cuda_runtime.h>
__global__ void kernelAddVectors(float* a, float* b, float* c, int size) {
    int index = threadIdx.x + blockIdx.x * blockDim.x;
    if (index < size) {
        c[index] = a[index] + b[index];
    }
}

void addVectors(float* a, float* b, float* c, int size) {
    // Allocate device memory
    float *d_a, *d_b, *d_c;
    cudaMalloc((void**)&d_a, size * sizeof(float));
    cudaMalloc((void**)&d_b, size * sizeof(float));
    cudaMalloc((void**)&d_c, size * sizeof(float));

    // Copy data from host to device
    cudaMemcpy(d_a, a, size * sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size * sizeof(float), cudaMemcpyHostToDevice);

    // Define block size and grid size
    int blockSize = 256;
    int numBlocks = (size + blockSize - 1) / blockSize;

    // Launch kernel
    kernelAddVectors<<<numBlocks, blockSize>>>(d_a, d_b, d_c, size);

    // Copy result from device to host
    cudaMemcpy(c, d_c, size * sizeof(float), cudaMemcpyDeviceToHost);

    // Free device memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
}
__global__
void MutVectorGPU(int* a,int*b,int*c,int N){
    // using kernel
    int tid = threadIdx.x * blockDim.x * blockIdx.x;
    c[tid] = a[tid] * b[tid];
}