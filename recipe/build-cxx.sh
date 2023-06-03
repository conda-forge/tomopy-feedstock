echo nvcc is $CUDACXX
echo CUDA path is $CUDA_PATH
echo CUDA is $USE_CUDA
echo MKL is $USE_MKL
echo OPENCV is $USE_OPENCV
echo CMAKE_ARGS is ${CMAKE_ARGS}

# Conda-forge nvcc compiler flags environment variable doesn't match CMake
# environment variable Redirect it so that the flags are added to nvcc calls
# https://github.com/conda-forge/cuda-nvcc-feedstock/issues/18
export CUDAFLAGS="${CUDAFLAGS} ${CUDA_CFLAGS}"

mkdir build
cd build

cmake $SRC_DIR \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DTOMOPY_USE_CUDA:BOOL=$USE_CUDA \
    -DTOMOPY_USE_MKL:BOOL=$USE_MKL \
    -DTOMOPY_USE_OPENCV:BOOL=$USE_OPENCV \
    -DSKIP_GIT_UPDATE:BOOL=ON \
    ${CMAKE_ARGS}

cmake --build .

cmake --install .
