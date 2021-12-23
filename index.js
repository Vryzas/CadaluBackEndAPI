//node\express application (backend)
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
const mysql = require("mysql");

const cookieParser = require("cookie-parser");
const session = require("express-session");
const req = require("express");
const res = require("express");
const nodemailer = require("nodemailer");

let transport = nodemailer.createTransport({
    host: "smtp.mailtrap.io",
    port: 2525,
    auth: {
        user: "9db14de76f88ef",
        pass: "413ef6b0e81f06"
    }
});
const db = mysql.createPool({
    host: "localhost",
    user: "root",
    password: "",
    database:"cadalu"
});

app.use(cors({
    origin:["http://localhost:3000"],
    methods: ["GET,HEAD,PUT,PATCH,POST,DELETE"],
    credentials: true
}));

app.use(cookieParser());
app.use(express.json());
app.use(bodyParser.urlencoded({extended: true}));

//session cookie
app.use(session({
    key: "userid",
    secret: "somethingcomplicated",
    resave: false,
    saveUninitialized: false,
    cookie: {
        sameSite: 'strict',
        expires: 60*60*24,
    }
}));

db.query(
    "SELECT * From pais WHERE identidade = ?",
    [2],
    /*[username, password],*/
    (err, result) => {/*
        if (err) {
            //res.send({err: err});
            console.log(err);
        }
        if (result.length > 0) {
            //req.session.user = result;
            //res.send(result);
            console.log("?");
        } else {
            console.log(result);
            res.send({message: "Nome de Utilizador ou Password errado!"});
        }*/
        console.log(result[0].nome);
    }
);
app.post("/login", (req, res) => {

    db.query(
        "SELECT * From pais WHERE identidade = ?",
        [2],
        (err, result) => {
            if (err) {
                res.send({err: err});
            }
            if (result.length > 0) {
                req.session.user = result;
                res.send(result[0].nome);
            } else {
                res.send({message: "Nome de Utilizador ou Password errado!"});
            }
        }
    );
});


app.listen(3001, () => {
    console.log("running on port 3001")
});