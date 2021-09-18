:: Set CUDACXX with call to 'where nvcc'
for /f "tokens=* usebackq" %%f in (`where nvcc`) do (set "dummy=%%f" && call set "CUDACXX=%%dummy:\=\\%%")

echo nvcc is %CUDACXX%
echo CUDA path is %CUDA_PATH%
echo CUDA is %USE_CUDA%
echo MKL is %USE_MKL%
echo OPENCV is %USE_OPENCV%

%PYTHON% -m pip install .^
 --no-deps --ignore-installed --no-index --no-cache-dir -vv^
 --install-option="-GNinja"^
 --install-option="-DTOMOPY_USE_CUDA:BOOL=%USE_CUDA%"^
 --install-option="-DTOMOPY_USE_MKL:BOOL=%USE_MKL%"^
 --install-option="-DTOMOPY_USE_OPENCV:BOOL=%USE_OPENCV%"

