$PYTHON setup.py build -- \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DTOMOPY_USE_CUDA:BOOL=$USE_CUDA \
    -DCUDAToolkit_ROOT=$CUDA_PATH \
    -DTOMOPY_USE_MKL:BOOL=$USE_MKL \
    -DTOMOPY_USE_OPENCV:BOOL=$USE_OPENCV \
    -- -j${CPU_COUNT}

$PYTHON -m pip install . \
    --no-deps --ignore-installed --no-index --no-cache-dir -vv \
    --install-option="-GNinja"

