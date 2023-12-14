#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <curand_kernel.h>
#include <curand.h>
#include <ctime>

extern "C"
{
    __declspec(dllexport) void generate_uniform_random(float* hostData, int n);
    __declspec(dllexport) void generate_normal_random(float* hostData, int n, float mean, float stddev);
    __declspec(dllexport) void generate_poisson_random(unsigned int* hostData, int n, double lambda);
}

__global__ void setup_kernel(curandState* state, unsigned long seed) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    curand_init(seed, id, 0, &state[id]);
}

__global__ void generate_uniform_kernel(curandState* state, float* data, int n) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    if (id < n) {
        data[id] = curand_uniform(&state[id]);
    }
}

__global__ void generate_normal_kernel(curandState* state, float* data, int n, float mean, float stddev) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    if (id < n) {
        data[id] = curand_normal(&state[id]) * stddev + mean;
    }
}

__global__ void generate_poisson_kernel(curandState* state, unsigned int* data, int n, double lambda) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    if (id < n) {
        data[id] = curand_poisson(&state[id], lambda);
    }
}

// Wrapper functions to be called from C#

void generate_uniform_random(float* hostData, int n) {
    curandState* devStates;
    float* devData;

    // Allocate space for cuRAND states on device
    cudaMalloc((void**)&devStates, n * sizeof(curandState));

    // Allocate space for results on device
    cudaMalloc((void**)&devData, n * sizeof(float));

    // Setup the prng states
    setup_kernel << <(n + 255) / 256, 256 >> > (devStates, time(NULL));

    // Generate random numbers
    generate_uniform_kernel << <(n + 255) / 256, 256 >> > (devStates, devData, n);

    // Copy results to host
    cudaMemcpy(hostData, devData, n * sizeof(float), cudaMemcpyDeviceToHost);

    // Cleanup
    cudaFree(devStates);
    cudaFree(devData);
}

void generate_normal_random(float* hostData, int n, float mean, float stddev) {
    curandState* devStates;
    float* devData;

    cudaMalloc((void**)&devStates, n * sizeof(curandState));
    cudaMalloc((void**)&devData, n * sizeof(float));

    setup_kernel << <(n + 255) / 256, 256 >> > (devStates, time(NULL));
    generate_normal_kernel << <(n + 255) / 256, 256 >> > (devStates, devData, n, mean, stddev);

    cudaMemcpy(hostData, devData, n * sizeof(float), cudaMemcpyDeviceToHost);

    cudaFree(devStates);
    cudaFree(devData);
}

void generate_poisson_random(unsigned int* hostData, int n, double lambda) {
    curandState* devStates;
    unsigned int* devData;

    cudaMalloc((void**)&devStates, n * sizeof(curandState));
    cudaMalloc((void**)&devData, n * sizeof(unsigned int));

    setup_kernel << <(n + 255) / 256, 256 >> > (devStates, time(NULL));
    generate_poisson_kernel << <(n + 255) / 256, 256 >> > (devStates, devData, n, lambda);

    cudaMemcpy(hostData, devData, n * sizeof(unsigned int), cudaMemcpyDeviceToHost);

    cudaFree(devStates);
    cudaFree(devData);
}
