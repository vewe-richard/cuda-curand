using System;
using System.Runtime.InteropServices;

public class CudaRandomNumbers
{
    [DllImport("curand.dll", CallingConvention = CallingConvention.Cdecl)]
    private static extern void generate_uniform_random(float[] array, int n);

    [DllImport("curand.dll", CallingConvention = CallingConvention.Cdecl)]
    private static extern void generate_normal_random(float[] array, int n, float mean, float stddev);

    [DllImport("curand.dll", CallingConvention = CallingConvention.Cdecl)]
    private static extern void generate_poisson_random([MarshalAs(UnmanagedType.LPArray)] uint[] array, int n, double lambda);

    public static float[] GenerateUniform(int n)
    {
        float[] result = new float[n];
        generate_uniform_random(result, n);
        return result;
    }

    public static float[] GenerateNormal(int n, float mean, float stddev)
    {
        float[] result = new float[n];
        generate_normal_random(result, n, mean, stddev);
        return result;
    }

    public static uint[] GeneratePoisson(int n, double lambda)
    {
        uint[] result = new uint[n];
        generate_poisson_random(result, n, lambda);
        return result;
    }
    static void Main()
    {
        // Setting parameters for uniform distribution
        int uniformCount = 10;

        // Setting parameters for normal distribution
        int normalCount = 10;
        float mean = 0.0f;
        float stddev = 1.0f;

        // Setting parameters for Poisson distribution
        int poissonCount = 10;
        double lambda = 3.0;

        // Generating random numbers from uniform distribution
        float[] uniformRandomNumbers = CudaRandomNumbers.GenerateUniform(uniformCount);
        Console.WriteLine("Uniform distribution:");
        foreach (var num in uniformRandomNumbers)
        {
            Console.WriteLine(num);
        }

        // Generating random numbers from a normal distribution
        float[] normalRandomNumbers = CudaRandomNumbers.GenerateNormal(normalCount, mean, stddev);
        Console.WriteLine("\nNormal distribution (mean 0, standard deviation 1):");
        foreach (var num in normalRandomNumbers)
        {
            Console.WriteLine(num);
        }

        // Generating random numbers from a Poisson distribution
        uint[] poissonRandomNumbers = CudaRandomNumbers.GeneratePoisson(poissonCount, lambda);
        Console.WriteLine("\nPoisson distribution (lambda 3):");
        foreach (var num in poissonRandomNumbers)
        {
            Console.WriteLine(num);
        }
    }
}
