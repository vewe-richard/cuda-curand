<h1>using cuRand capabilities on C#</h1>
<h2>1.create curand.dll</h2>
<h4>1.1  Create a new project and select Dynamic-link Library(DLL)</h4>
![1 1](https://github.com/xldyswa/cuRand/assets/145743621/eb410ee0-e38d-4753-9324-13fcce734dc8)
<h4>1.2 Add a .cu file by adding/creating an item.</h4>
![1 2](https://github.com/xldyswa/cuRand/assets/145743621/f29c7c96-d826-4c11-8943-73ccdaff521a)
<h4>1.3 Entire Project/Build Dependencies/Check CUDA 12.2.</h4>
![1 3 1](https://github.com/xldyswa/cuRand/assets/145743621/ced263af-ed24-4143-855e-e2a832f7ae98)
![1 3 2](https://github.com/xldyswa/cuRand/assets/145743621/ea60568f-3d8a-4d1e-ba05-4091c3165e62)
<h4>1.4 Set the .cu file: right-click/properties on the .cu file.</h4>
![1 4](https://github.com/xldyswa/cuRand/assets/145743621/5c0b241c-b96c-4e9f-99fc-567e141f060d)
<h4>1.5 Set ‘Exclude from Build’ to ‘No’ and set ‘Item Type’ to ‘CUDA C/C++’.</h4>
![1 5](https://github.com/xldyswa/cuRand/assets/145743621/91888653-9db6-4431-a3fe-c9455c33a801)
<h4>1.6 It uses __declspec(dllexport) to define an exported function called generate_random_numbers, and employs extern “C” to instruct the compiler to decorate the names in a manner consistent with C language conventions.</h4>
![1 6](https://github.com/xldyswa/cuRand/assets/145743621/3c167eb5-f41e-4cf5-a34a-075aa1e44305)
<h4>1.7 Build Solution, Will generate a DLL.</h4>
![1 7](https://github.com/xldyswa/cuRand/assets/145743621/fed26634-cd58-4dac-91ef-062ff575ad8f)
<h2>2.import curand.dll in C#</h2>
<h4>2.1 Move the generated DLL to the ‘bin/debug’ directory of your C# project.</h4>
![2 1](https://github.com/xldyswa/cuRand/assets/145743621/f0181297-9bc7-45d6-9300-d1a3353636c5)
<h4>2.2 Use DllImport to import your CUDA DLL.</h4>
![2 2](https://github.com/xldyswa/cuRand/assets/145743621/bf65a320-0971-416a-8939-6deb687785d2)
<h4>2.3 Finally, cuRand can be implemented in C#.</h4>
![2 3](https://github.com/xldyswa/cuRand/assets/145743621/49f8773d-3e41-49f6-ac51-7402b78d9c54)







