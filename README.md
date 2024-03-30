#  Zig MongoDb Client

## Install MongoDB C Driver
https://mongoc.org/libmongoc/current/installing.html

## Copy header files

Ubuntu:

cp -r /usr/include/libbson-1.0/bson ./src/bson
cp -r /usr/include/libmongoc-1.0/mongoc ./src/mongoc

## Install MongoDB

https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

Start:

sudo systemctl start mongod

## Build and run

zig build run