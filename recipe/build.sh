echo ${CMAKE_ARGS}

mkdir build
cd build

cmake $SRC_DIR \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DTOMOPY_USE_CUDA:BOOL=$USE_CUDA \
    -DCUDAToolkit_ROOT=$CUDA_PATH \
    -DTOMOPY_USE_MKL:BOOL=$USE_MKL \
    -DTOMOPY_USE_OPENCV:BOOL=$USE_OPENCV
    ${CMAKE_ARGS}

cmake --build .

cmake --install .
