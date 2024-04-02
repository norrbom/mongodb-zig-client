#  Zig MongoDB C Driver Wrapper - as a learning exercise

Wrapping MongoDB C Driver as an exercise to get familiar with Zig.

- Zig version: 0.11.0
- OS: Ubuntu 22.04.3 LTS

## Setup

### Install MongoDB C Driver

https://mongoc.org/libmongoc/current/installing.html


### Link to C libraries

The following lines in `build.zig` where added to let the Zig build system know where to find the header files and how to link libc and the MongoDB libraries.

```zig
exe.addIncludePath(std.build.LazyPath{ .path = "/usr/include/libmongoc-1.0" });
exe.addIncludePath(std.build.LazyPath{ .path = "/usr/include/libbson-1.0" });
exe.linkSystemLibrary("c");
exe.linkSystemLibrary("bson-1.0");
exe.linkSystemLibrary("mongoc-1.0");
```

## Install MongoDB

https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

Start MongoDB

```sh
sudo systemctl start mongod
```

## Import the Sample Data Set

```sh
curl https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_airbnb/listingsAndReviews.json | mongoimport -h localhost:27017 --db sample_airbnb --collection listings
```

## Build and run

```sh
zig build run
```