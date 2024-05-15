#! /bin/bash

set -e
set -x

export CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"

if [[ "$PKG_NAME" == "python-uhdm" ]]; then
  CMAKE_ARGS="$CMAKE_ARGS -DPYTHON_EXECUTABLE=$PYTHON -DPython3_EXECUTABLE=$PYTHON -DUHDM_WITH_PYTHON=ON"
else
  CMAKE_ARGS="$CMAKE_ARGS -DUHDM_WITH_PYTHON=OFF"
fi

mkdir -p build
cd build

cmake .. \
    ${CMAKE_ARGS} \
    -DCMAKE_CXX_STANDARD=17 \
    -DBUILD_SHARED_LIBS=ON \
    -DUHDM_BUILD_TESTS=OFF \
    -DUHDM_USE_HOST_CAPNP=ON

make -j${CPU_COUNT}
make install
