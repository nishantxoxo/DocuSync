const express = require("express");
require("dotenv").config();

const mongoose  = require("mongoose");
const authrouter = require("./routes/auth");
const cors = require("cors");
const http = require('http');
const documentRouter = require("./routes/document");
const Document = require("./models/document");


const PORT = process.env.PORT | 3001;


const app = express();
var server = http.createServer(app);

var io = require('socket.io')(server);




// mongoose.connect(process.env.MONGO_URI);

// app.post('/api/signup', (req, res)=>{

// })

// app.get('/api/get', (req, res)=>{
    
// })
app.use(cors());
app.use(express.json())
app.use(authrouter);
app.use(documentRouter);




mongoose.connect(process.env.MONGO_URI).then(() => {
    console.log("mongo connection succesful");
    
}).catch((e)=> {
    console.log(e);
    
})


io.on('connection', (sock) => {
    sock.on('join', (docId) => {
        sock.join(docId)
    console.log("doc joined");

    })


    sock.on('typing', (data) => {
        sock.broadcast.to(data.room).emit('changes', data); 
    })

    sock.on('save', async (data) => {
        // console.log("Saver recieved");
        
        await saver(data);
    })


    sock.on('chat', (data) => {
        // console.log("chat recieved");
        
    io.to(data.room).emit('chat', data);
    });

    console.log("sock connected" + sock.id);
} )


const saver = async (data) => {
    try {
        const document = await Document.findByIdAndUpdate(
            data.room,
            { content: data.delta },
            
        );

    } catch (err) {
        console.log(err);
    }
};

server.listen(PORT, "0.0.0.0" , ()=>{
    console.log("connected at port 3001")
})