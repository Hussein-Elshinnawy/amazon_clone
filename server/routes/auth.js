const express = require('express');//import libray
const User = require('../models/user');
const authRouter= express.Router();// we use express.router not express() to have access instead using app=express()

authRouter.get("/api/signup", async (req, res)=>{
    const {name, email, password}= req.body;

    const existingUser = await User.findOne({ email });
    if(existingUser){ //existingUser is not boolen it just check if existing is not null
        //and we use return to stop the application
        return res.status(400).json({msg:"user with same email already exist!"});
    }
    //create a new user model with an object
    //and making type let because we gona change it let = var but few diff
    let user = new User({
    //all of these are required
        email,
        password,
        name,
    })
    user= await user.save();
    res.json(user);
});


//this make authRouter visible to others and to be used
module.exports = authRouter;