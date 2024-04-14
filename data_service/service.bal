import ballerina/http;

service /vehicles on new http:Listener(8080) {
	isolated resource function post .(@http:Payload Vehicle vh) returns int|error? {
        return addVehicle(vh);
    }

	isolated resource function get [int id]() returns Vehicle|error? {
        return getVehicle(id);
    }

}