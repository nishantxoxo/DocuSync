const express = require("express");

const mongoose  = require("mongoose");


const PORT = process.env.PORT | 3001;


const app = express();

const db = "mongodb+srv://nishantpriya:nishantpriya@clusterdocusync.eqo1rxa.mongodb.net/?appName=Clusterdocusync";
mongoose.connect(db).then(() => {
    console.log("mongo connection succesful");
    
}).catch((e)=> {
    console.log(e);
    
})


app.listen(PORT, "0.0.0.0" , ()=>{
    console.log("connected at port 3001")
})