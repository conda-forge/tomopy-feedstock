:: Set CUDACXX with call to 'where nvcc'
for /f "tokens=* usebackq" %%f in (`where nvcc`) do (set "dummy=%%f" && call set "CUDACXX=%%dummy:\=\\%%")

echo nvcc is %CUDACXX%
echo CUDA path is %CUDA_PATH%
echo CUDA is %USE_CUDA%
echo MKL is %USE_MKL%
echo OPENCV is %USE_OPENCV%
echo CMAKE_ARGS is %CMAKE_ARGS%

%PYTHON% setup.py build --^
    %CMAKE_ARGS%^
    -GNinja^
    -DCMAKE_BUILD_TYPE=Release^
    -DTOMOPY_USE_CUDA:BOOL=%USE_CUDA%^
    -DCUDAToolkit_ROOT=%CUDA_PATH%^
    -DTOMOPY_USE_MKL:BOOL=%USE_MKL%^
    -DTOMOPY_USE_OPENCV:BOOL=%USE_OPENCV%^
    -- -j%CPU_COUNT%
if errorlevel 1 exit /b 1

%PYTHON% -m pip install .^
    --no-deps --ignore-installed --no-index --no-cache-dir -vv^
if errorlevel 1 exit /b 1
