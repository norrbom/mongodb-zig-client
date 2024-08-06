# Zig MongoDB C Driver Wrapper

A Zig example project that wraps MongoDB C Driver libraries.

- Zig version: 0.13.0
- OS: Ubuntu 22.04.3 LTS

## Build and install the C driver libraries

In this step we will download the source code, build and install the two libraries required, libmongoc and libbson.

### Install CMake from source

MongoDB is using CMake to generate build scripts and configuration.

```sh
wget "https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2.tar.gz"
tar xf "cmake-3.30.2.tar.gz"
cd cmake-3.30.2
./bootstrap --prefix=~/.local && make install
```

Add ~/.local/bin to $PATH

### Install MongoDB C Driver from source

Download and unpack the mongo-c-driver source code.

```sh
VERSION=1.27.4
wget "https://github.com/mongodb/mongo-c-driver/archive/refs/tags/$VERSION.tar.gz" \
    --output-document="mongo-c-driver-$VERSION.tar.gz"
tar xf "mongo-c-driver-$VERSION.tar.gz"
```

Configure for libbson

```sh
SOURCE=mongo-c-driver-$VERSION
BUILD=$SOURCE/_build
cmake -S $SOURCE -B $SOURCE/_build \
   -D ENABLE_EXTRA_ALIGNMENT=OFF \
   -D ENABLE_AUTOMATIC_INIT_AND_CLEANUP=OFF \
   -D CMAKE_BUILD_TYPE=RelWithDebInfo \
   -D BUILD_VERSION="$VERSION" \
   -D ENABLE_MONGOC=OFF
```

Build libbson

```sh
cmake --build $BUILD --config RelWithDebInfo --parallel
```

Install the libbson library under ./mongo folder

```sh
PREFIX=mongo
cmake --install "$BUILD" --prefix "$PREFIX" --config RelWithDebInfo
```

Configure libmongoc

```sh
cmake -D ENABLE_MONGOC=ON $BUILD
```

Build and install libmongoc under ./mongo folder

```sh
cmake --build $BUILD --config RelWithDebInfo --parallel
PREFIX=mongo
cmake --install "$BUILD" --prefix "$PREFIX" --config RelWithDebInfo
```

### Link to C libraries during zig build

The following lines in `build.zig` where added to let the Zig build system know where to find the header files and how to link libc and the MongoDB libraries.

```zig
exe.addLibraryPath(b.path("mongo/lib"));
exe.linkSystemLibrary("bson-1.0");
exe.linkSystemLibrary("mongoc-1.0");
exe.linkSystemLibrary("c");

exe.addIncludePath(b.path("mongo/include/libbson-1.0"));
exe.addIncludePath(b.path("mongo/include/libmongoc-1.0"));
```

## Build and run the example code under ./src

### Install MongoDB

https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

Start MongoDB

```sh
sudo systemctl start mongod
```

Import the Sample Data Set

```sh
curl "https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_airbnb/listingsAndReviews.json" \
 | mongoimport -h localhost:27017 --db sample_airbnb --collection listings
```

### Build and run the example

```sh
zig build run
```
