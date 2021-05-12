var mysql = require("mysql");
var connection = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "bgv",
});
connection.connect(function (err) {
    if (err) {
        console.log("Error connecting to Db", err);
        return;
    }
    console.log("Connection established");
});

module.exports = connection;