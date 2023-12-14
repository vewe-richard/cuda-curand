using System;
using System.Runtime.InteropServices;

class Program
{
    [DllImport("curand.dll", EntryPoint = "generate_random_numbers")]
    private static extern void GenerateRandomNumbers(IntPtr hostData, int n);

    static void Main()
    {
        const int n = 100; 
        float[] randomNumbers = new float[n];
        GCHandle handle = GCHandle.Alloc(randomNumbers, GCHandleType.Pinned);

        try
        {
            GenerateRandomNumbers(handle.AddrOfPinnedObject(), n);

            for (int i = 0; i < n; i++)
            {
                Console.WriteLine(randomNumbers[i]);
            }
        }
        finally
        {
            if (handle.IsAllocated)
                handle.Free();
        }
    }
}
