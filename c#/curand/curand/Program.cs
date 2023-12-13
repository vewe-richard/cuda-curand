using System;
using System.Runtime.InteropServices;

class Program
{
    // Assume "cuda_dll.dll" is the name of your CUDA DLL and
    // "generate_random_numbers" is exported from that DLL.
    // Here we declare the external CUDA function.
    [DllImport("curand_dll.dll")]
    private static extern unsafe void generate_random_numbers(float* hostData, int n);

    static unsafe void Main()
    {
        int n = 10000;
        float* hostData = (float*)Marshal.AllocHGlobal(n * sizeof(float)).ToPointer();

        generate_random_numbers(hostData, n);

        for (int i = 0; i < 10; i++)
        {
            Console.WriteLine(hostData[i]);
        }
    }
}