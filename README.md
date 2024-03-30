#  Zig MongoDB Client

## Install MongoDB C Driver
https://mongoc.org/libmongoc/current/installing.html


## Link to C libraries

Let the `build.zig` know where to find the header files and how to link libc and MongoDB libraries.

On Ubuntu:

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

sudo systemctl start mongod

## Build and run

zig build run