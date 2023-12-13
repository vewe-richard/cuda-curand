# using cuRand capabilities on C#
## 1.create curand.dll
 1.1  Create a new project and select Dynamic-link Library(DLL)
![1.1.png](image%2F1.1.png)
1.2 Add a .cu file by adding/creating an item.

![1.2.png](image%2F1.2.png)

1.3 Entire Project/Build Dependencies/Check CUDA 12.2.

![1.3.1.png](image%2F1.3.1.png)

![1.3.2.png](image%2F1.3.2.png)

1.4 Set the .cu file: right-click/properties on the .cu file.

![1.4.png](image%2F1.4.png)

1.5 Set ‘Exclude from Build’ to ‘No’ and set ‘Item Type’ to ‘CUDA C/C++’.

![1.5.png](image%2F1.5.png)

1.6 It uses __declspec(dllexport) to define an exported function called generate_random_numbers, and employs extern “C” to instruct the compiler to decorate the names in a manner consistent with C language conventions.

![1.6.png](image%2F1.6.png)

1.7 Build Solution, Will generate a DLL.

![1.7.png](image%2F1.7.png)

## 2.import curand.dll in C#

2.1 Move the generated DLL to the ‘bin/debug’ directory of your C# project.

![2.1.png](image%2F2.1.png)

2.2 Use DllImport to import your CUDA DLL.

![2.2.png](image%2F2.2.png)

2.3 Finally, cuRand can be implemented in C#.

![2.3.png](image%2F2.3.png)







