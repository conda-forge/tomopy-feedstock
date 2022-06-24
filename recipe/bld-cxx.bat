:: Set CUDACXX with call to 'where nvcc'
for /f "tokens=* usebackq" %%f in (`where nvcc`) do (set "dummy=%%f" && call set "CUDACXX=%%dummy:\=\\%%")

echo nvcc is %CUDACXX%
echo CUDA path is %CUDA_PATH%
echo CUDA is %USE_CUDA%
echo MKL is %USE_MKL%
echo OPENCV is %USE_OPENCV%
echo CMAKE_ARGS is %CMAKE_ARGS%

mkdir build
cd build
if errorlevel 1 exit /b 1

cmake %SRC_DIR% ^
    -DCMAKE_BUILD_TYPE=Release^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%^
    -GNinja^
    -DTOMOPY_USE_CUDA:BOOL=%USE_CUDA%^
    -DTOMOPY_USE_MKL:BOOL=%USE_MKL%^
    -DTOMOPY_USE_OPENCV:BOOL=%USE_OPENCV%^
    -DSKIP_GIT_UPDATE:BOOL=ON^
    %CMAKE_ARGS%
if errorlevel 1 exit /b 1

cmake --build .
if errorlevel 1 exit /b 1

cmake --install .
if errorlevel 1 exit /b 1

