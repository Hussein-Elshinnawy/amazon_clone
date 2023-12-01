const express = require('express');
const mongoose = require('mongoose');
const DB="mongodb+srv://clorkthefirst:uw0IyNc6CmVYKNbD@cluster0.wesy67v.mongodb.net/?retryWrites=true&w=majority";


const authRouter= require("./routes/auth.js");// this to import ath auth.js to use it

const PORT = 3000;
const app= express();
//middleware
app.use(authRouter);

// to connect to data base and since it's future promise we use then() works like await
mongoose.connect(DB).then(()=>{
    console.log('connection successful');
}).catch((e)=>{
    console.log(e);
});

app.use(authRouter);

app.listen(PORT, "0.0.0.0", ()=>{
    console.log('connected at port ${PORT}'+ PORT);
});

