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
`   dotnet --version   ` <br/>
3.2 `   cd curand/CudaRandomSharp   `<br/>
3.3 Copy the generated DLL to the ‘bin/debug/net7.0’.</br>
3.4 `   dotnet run   `<br/>
3.5 execution result
```bash
Z:\cuRand\CudaRandomSharp>dotnet run
Uniform distribution:
0.8154986
0.20479722
0.40697202
0.21035741
0.030037753
0.9186083
0.12852119
0.93051356
0.8977811
0.079594545

Normal distribution (mean 0, standard deviation 1):
-0.27253965
1.6437846
0.4098125
1.1907218
-1.0824282
-0.41187215
1.7437276
-0.37515602
0.08605143
-2.062187

Poisson distribution (lambda 3):
18
17
14
13
18
21
17
29
19
16

