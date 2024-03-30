const std = @import("std");
const print = std.debug.print;
extern fn mongoc_init() void;
const c = @cImport({
    @cInclude("mongoc/mongoc.h");
    @cInclude("bson/bson.h");
});

pub fn main() !void {
    mongoc_init();
    const client = c.mongoc_client_new("mongodb://localhost:27017");
    defer c.mongoc_client_destroy(client);
    const command = c.bson_new_from_json("{ \"listDatabases\": 1 }", -1, null);
    const reply = c.bson_new();
    const retval = c.mongoc_client_command_simple(client, "admin", command, null, reply, null);
    print("retval: {any}\n", .{retval});
    var dbs = c.bson_as_json(reply, null);
    print("reply: {s}\n", .{dbs});
}
