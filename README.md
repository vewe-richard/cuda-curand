# Using cuRand capabilities on C#
## 1.Prepare Environment
1.1 Make sure CUDA Toolkit is installed and CUDA environment variables are correctly set.</br>
`   nvcc --version   `<br/>
1.2 Enter PowerShell <br/>
1.3 `   git clone https://github.com/vewe-richard/cuda-curand.git   `<br/>
1.4 `   cd cuda-curand   `
## 1.Create curand.dll
2.1 `   cd cuRand/cuRandWrapper   `<br/>
2.2 `   nvcc -c -o CuRandWrapper.obj CuRandWrapper.cu   `</br>
2.3 `   nvcc -shared -o CuRandWrapper.dll CuRandWrapper.obj -lcudart   `</br>
2.4 Now a curand.dll has been successfully created<dr/>
## 2.Import curand.dll in C#
3.1 Make sure .NET Framework is installed.<br/>
`   dotnet --version   `   
3.1 Copy the generated DLL to the ‘bin/debug/net7.0’.</br>
3.2 Use DllImport to import your CUDA DLL, please refer to curand/Program.cs.(excample)</br>
`   [DllImport("curand.dll", CallingConvention = CallingConvention.Cdecl)]   `</br>
`   private static extern void generate_uniform_random(float[] array, int n);   `</br>
3.3 Finally, cuRand can be implemented in C#
