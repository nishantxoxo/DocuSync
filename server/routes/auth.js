const express = require("express");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

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

          const token =  jwt.sign({id: user._id}, "passwordKey")

            res.json({ user: user, token: token})
    } catch (er) {
        res.status(500).json({error: er.message});
    }
})

authrouter.get('/', auth , async (req, res) => {
        // console.log(req.user);
        const user = await User.findById(req.user);
        res.json({user, token: req.token});
});


module.exports = authrouter