# using cuRand capabilities on C#
## 1.create curand.dll
1.1  Make sure CUDA Toolkit is installed and CUDA environment variables are correctly set.</br>
1.2  Create curand.cu files</br>
1.3 It uses __declspec(dllexport) to define an exported function called generate_random_numbers, and employs extern “C” to instruct the compiler to decorate the names in a manner consistent with C language conventions.<br/>
1.3  Compile the CUDA code and generate object files (.obj) using the nvcc compiler provided by NVIDIA.</br>
`   nvcc -c -o curand.obj curand.cu   `</br>
1.4  Link the object files with other dependencies and generate the DLL file. During the linking process, you need to specify the appropriate options and libraries.</br>
`   nvcc -shared -o curand.dll curand.obj -lcudart   `</br>
## 2.import curand.dll in C#
2.1  Move the generated DLL to the ‘bin/debug’ directory of your C# project.</br>
2.2  Use DllImport to import your CUDA DLL.</br>
`   [DllImport("curand.dll")]   `</br>
`   private static extern unsafe void generate_random_numbers(float* hostData, int n);   `</br>
2.3  Finally, cuRand can be implemented in C#
