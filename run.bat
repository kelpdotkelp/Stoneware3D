:: Generate project build system
:: -S source directory, -B build directory
cmake -S . -B build

::Build the project
cmake --build ./build

::Run the executable
"./build/src/Debug/Stoneware3D.exe"