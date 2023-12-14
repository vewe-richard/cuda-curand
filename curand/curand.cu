#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include <stdio.h>
#include <stdlib.h>
#include <curand_kernel.h>
#include <curand.h>

extern "C"
{
    __declspec(dllexport) void generate_random_numbers(float* hostData, int n);

}
__global__ void setup_kernel(curandState* state, unsigned long seed) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    curand_init(seed, id, 0, &state[id]);
}

__global__ void generate_kernel(curandState* state, float* data, int n) {
    int id = threadIdx.x + blockIdx.x * blockDim.x;
    if (id < n) {
        data[id] = curand_uniform(&state[id]);
    }
}

void generate_random_numbers(float* hostData, int n) {
    curandState* devStates;
    float* devData;

    // Allocate space for cuRAND states on device
    cudaMalloc((void**)&devStates, n * sizeof(curandState));

    // Allocate space for results on device
    cudaMalloc((void**)&devData, n * sizeof(float));

    // Setup the prng states
    setup_kernel << <(n + 255) / 256, 256 >> > (devStates, time(NULL));

    // Generate random numbers
    generate_kernel << <(n + 255) / 256, 256 >> > (devStates, devData, n);

    // Copy results to host
    cudaMemcpy(hostData, devData, n * sizeof(float), cudaMemcpyDeviceToHost);

    // Cleanup
    cudaFree(devStates);
    cudaFree(devData);
}