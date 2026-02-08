const express = require("express");
const User = require("../models/user");


// const app = express()

const authrouter = express.Router()

authrouter.post('/api/signup', async (req, res) =>{
    try {
        const {name, email, profilePic} =  req.body;
            let user = await User.findOne({email: email});

            if(!user){
                user = new User({
                    email: email,
                    profilePic: profilePic,
                    name: name,
                });
                user  = await user.save()
            }

            res.json({ user: user})
    } catch (er) {
        res.status(500).json({error: er.message});
    }
})

module.exports = authrouter