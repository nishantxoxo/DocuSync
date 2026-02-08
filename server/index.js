const express = require("express");
require("dotenv").config();

const mongoose  = require("mongoose");
const authrouter = require("./routes/auth");


const PORT = process.env.PORT | 3001;


const app = express();


// mongoose.connect(process.env.MONGO_URI);

// app.post('/api/signup', (req, res)=>{

// })

// app.get('/api/get', (req, res)=>{
    
// })

app.use(express.json())
app.use(authrouter);



mongoose.connect(process.env.MONGO_URI).then(() => {
    console.log("mongo connection succesful");
    
}).catch((e)=> {
    console.log(e);
    
})


app.listen(PORT, "0.0.0.0" , ()=>{
    console.log("connected at port 3001")
})