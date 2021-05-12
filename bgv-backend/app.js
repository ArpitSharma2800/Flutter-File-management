const express = require("express");
const multer = require('multer');
const cors = require("cors");
var connection = require("./helpers/db")
const bodyParser = require("body-parser");
const {
    v4: uuidv4
} = require("uuid");
const app = express();

app.use(bodyParser.json({
    limit: "50mb"
}))
app.use(bodyParser.urlencoded({
    limit: "50mb",
    extended: true,
    parameterLimit: 50000
}))
app.use(cors());

app.use("*", cors());

app.use(express.static("public"));
app.use(express.json());

app.get("/", (req, res) => {
    res.status(200).send({
        message: "server running...."
    });
});
var base64ToImage = require('base64-to-image');

//multer file upload

const multerStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "public/");
    },
    filename: (req, file, cb) => {
        cb(null, `${file.originalname}`);
    },
});

const upload = multer({
    storage: multerStorage,
});

//allfile
app.get('/orgfile', (req, res, next) => {
    const query = `SELECT files.FilesId AS FilesId, files.FileLink AS FileLink, files.userId AS userId, User.userName AS userName FROM files INNER JOIN User ON User.userId = files.userId`;
    connection.query(query, function (err, result) {
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not list files",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(result));
        }
    });
});

//personel file
app.get('/file/:id', (req, res, next) => {
    console.log(req.params.id);
    const query = `SELECT files.FilesId AS FilesId, files.FileLink AS FileLink, files.userId AS userId, User.userName AS userName FROM files INNER JOIN User ON User.userId = files.userId WHERE files.userId='${req.params.id}'`;
    connection.query(query, function (err, result) {
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not list files",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(result));
        }
    });
});

//upload file
app.post('/uploadfile', upload.single('myFile'), (req, res, next) => {
    const uuid = uuidv4();
    const file = req.file
    if (!file) {
        const error = new Error('Please upload a file')
        error.httpStatusCode = 400
        return next(error)
    }
    const query = `INSERT INTO Files (filesid,filelink,userid) VALUES ('${uuid}','${file.filename}','${req.body.userId}')`;
    connection.query(query, function (err, result, fields) {
        console.log(result);
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not upload file",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            var response = {
                message: "File Uploaded",
            };
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        }
    });
    // res.send(file)
})

//base64upload file
app.post('/upload', (req, res, next) => {
    const uuid = uuidv4();
    var filename = req.body.filename
    var base64url = req.body.base64url
    var base64Str = "data:image/png;base64," + base64url
    var path = './public/';
    var optionalObj = {
        'fileName': filename,
        'type': 'png'
    };
    base64ToImage(base64Str, path, optionalObj);
    var imageInfo = base64ToImage(base64Str, path, optionalObj);
    var fileLink = '/' + filename
    const query = `INSERT INTO Files (filesid,filelink,userid) VALUES ('${uuid}','${req.body.filename}','${req.body.userId}')`;
    connection.query(query, function (err, result) {
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not upload",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            var response = {
                message: "Files Added succesfully",
            };
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        }
    });
});

//delete file
app.delete('/deletefile', (req, res, next) => {
    const query = `DELETE FROM Files WHERE Filesid='${req.body.fileId}'`;
    connection.query(query, function (err, result, fields) {
        console.log(result);
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not delete file",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            var response = {
                message: "File deleted",
            };
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        }
    });
    // res.send(file)
})

//login
app.post('/login', (req, res, next) => {
    const query = `SELECT * FROM User WHERE userName='${req.body.username}'`;
    connection.query(query, function (err, result, fields) {
        console.log(result);
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not create user",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        };
        if (result[0] == null) {
            res.status(403).send({
                messgae: "no user found"
            })
        } else {
            if (req.body.pwd == result[0].pwd) {
                var response = {
                    message: "Signed In",
                    userId: result[0].userId
                };
                res.writeHead(200, {
                    "Content-Type": "application/json",
                });
                return res.end(JSON.stringify(response));
            } else {
                console.log(err)
                var response = {
                    message: "Error: Credentials incorrect",
                };
                res.writeHead(404, {
                    "Content-Type": "application/json",
                });
                return res.end(JSON.stringify(response));
            }
        }
    });
});

//insert alert

app.post('/alert', (req, res, next) => {
    console.log(req.body.filename);
    const uuid = uuidv4();
    const query = `INSERT INTO Alert (AlertId,FileName,userId) VALUES ('${uuid}','${req.body.filename}','${req.body.userId}');`;
    connection.query(query, function (err, result, fields) {
        console.log(result);
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not generated alert",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            var response = {
                message: "Alert generated",
            };
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        }
    });
    // res.send(file)
})
//get alert
app.get('/alert/:id', (req, res, next) => {
    const query = `SELECT * FROM alert WHERE userId='${req.params.id}'`;
    connection.query(query, function (err, result) {
        if (err) {
            console.log(err);
            var response = {
                message: "Error: Could not get alerts",
            };
            res.writeHead(404, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(response));
        } else {
            res.writeHead(200, {
                "Content-Type": "application/json",
            });
            return res.end(JSON.stringify(result));
        }
    });
});



const port = 3000;
app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`)
})