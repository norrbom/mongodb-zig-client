const std = @import("std");
const print = std.debug.print;

pub const c = @cImport({
    @cInclude("mongoc/mongoc.h");
    @cInclude("bson/bson.h");
});

pub fn main() !void {
    c.mongoc_init();
    const client = c.mongoc_client_new("mongodb://localhost:27017");
    defer c.mongoc_client_destroy(client);

    try printDatabases(client);

    const listings = c.mongoc_client_get_collection(client, "sample_airbnb", "listings");
    defer c.mongoc_collection_destroy(listings);

    const count = try countDocuments(listings, c.bson_new());
    print("listings docs: {any}\n", .{count});
}

pub fn printDatabases(client: ?*c.mongoc_client_t) !void {
    const command = c.bson_new_from_json("{ \"listDatabases\": 1 }", -1, null);
    defer c.bson_destroy(command);

    const doc = c.bson_new();
    defer c.bson_destroy(doc);

    _ = c.mongoc_client_command_simple(client, "admin", command, null, doc, null);
    print("databases: {s}\n", .{c.bson_as_json(doc, null)});
}

pub fn countDocuments(collection: ?*c.mongoc_collection_t, filter: [*c]c.bson_t) !i64 {
    const doc = c.bson_new();
    defer c.bson_destroy(doc);
    const n = c.mongoc_collection_count_documents(collection, filter, null, null, doc, null);
    return n;
}
