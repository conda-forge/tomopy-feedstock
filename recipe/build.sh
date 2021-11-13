echo ${CMAKE_ARGS}

$PYTHON -m pip install . \
    --no-deps --ignore-installed --no-index --no-cache-dir -vv \
    --install-option="${CMAKE_ARGS}" \
    --install-option="-DCMAKE_BUILD_TYPE=Release" \
    --install-option="-GNinja" \
    --install-option="-DTOMOPY_USE_CUDA:BOOL=$USE_CUDA" \
    --install-option="-DCUDAToolkit_ROOT=$CUDA_PATH" \
    --install-option="-DTOMOPY_USE_MKL:BOOL=$USE_MKL" \
    --install-option="-DTOMOPY_USE_OPENCV:BOOL=$USE_OPENCV"
