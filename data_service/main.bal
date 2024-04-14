//import ballerina/time;
import ballerinax/mysql.driver as _;
import ballerinax/mysql;
import ballerina/sql;

public type Vehicle record {|
    int id?;
    string brand;
    string model;
    string fueltype;
    boolean available;
    decimal price;
|};

configurable string USER = ?;
configurable string PASSWORD = ?;
configurable string HOST = ?;
configurable int PORT = ?;
configurable string DATABASE = ?;


final mysql:Client dbClient = check new(
    host=HOST, user=USER, password=PASSWORD, port=PORT, database=DATABASE
);


isolated function addVehicle(Vehicle vh) returns int|error {
    sql:ExecutionResult result = check dbClient->execute(`
        INSERT INTO Vehicle (id, brand, model, fueltype, available, price)
        VALUES (${vh.id}, ${vh.brand}, ${vh.model},  
                ${vh.fueltype}, ${vh.available}, ${vh.price})
    `);
    //int|string? lastInsertId = result.lastInsertId;
    int|string? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return affectedRowCount;
    } else {
        return error("Unable to obtain affected Raw Count");
    }
}

isolated function getVehicle(int id) returns Vehicle|error {
    Vehicle vehicle = check dbClient->queryRow(
        `SELECT * FROM Vehicle WHERE id = ${id}`
    );
    return vehicle;
}