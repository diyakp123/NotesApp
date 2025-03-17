
//Initialization
const express = require('express');
const app = express();

const mongoose = require("mongoose");
const Note = require('./models/Note');


const bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
// if extended is true then nested objects are allowed and it would be able to read and understand nested objects
//if extended is false then nested objects are not allowed 

const mongodbPath = "mongodb+srv://hp0563079:N2yNdj0DpECU0FUh@mynotesapp.enmaa.mongodb.net/?retryWrites=true&w=majority&appName=MyNotesApp";

mongoose.connect(mongodbPath).then(function () {
    console.log("Connected");

    //App Routes
    app.get("/", function (req, res) {
        // res.send("This is the Home Page")
        const response = {message : "Home Page"};
        res.json(response);
    });
    app.post("/notes/list", async function (req, res) {
        var notes = await Note.find({ userid: req.body.userid });
        res.json(notes);
      
    });
    
    app.post("/notes/add", async function (req, res) {
        // print("added");
        // res.json(req.body);
        console.log("added");

        await Note.deleteOne({ id: req.body.id });
    
        const newNote = new Note({
            id: req.body.id,
            userid: req.body.userid,
            title: req.body.title,
            content: req.body.content
        });
        await newNote.save();
    
        const response = { message: "New Note Created! " + `id: ${req.body.id}` };
        res.json(response);
        // print("added");
        // var notes = await Note.find();
        // res.json(notes);
        // res.send("This is notes app")
    });
    
    
    app.post("/notes/delete", async function (req, res) {
        await Note.deleteOne({ id: req.body.id });
    
        const response = { message: "Note Deleted " + `id: ${req.body.id}` };
        res.json(response);
    console.debug("delete");
    
    });
    
    // const noteRouter = require("./routes/Routes");
    // app.use('/notes', noteRouter);

    // app.get("/notes/list/:userid", async function (req, res) {
    //     var notes = await Note.find({ userid: req.params.userid });
    //     res.json(notes);
    // });

    
});





//starting a server on a PORT
const PORT =  5000;
app.listen(PORT, function () {
    console.log("server started at port 5000")
});




//pwd of mongodb N2yNdj0DpECU0FUh