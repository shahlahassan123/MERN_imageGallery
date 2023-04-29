const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const imageRoute = require("./routes/imageRoute")
const mongoose = require("mongoose");
const path = require("path");

const app = express();

dotenv.config();
app.use(cors());
app.use(express.json());
app.use(express.static(path.join(__dirname,'public')));

mongoose.connect(process.env.DB_URL, {
    useNewUrlParser : true,
    useUnifiedTopology : true
}).then(()=>{
    console.log("MongoDB connected successfully")
}).catch((err)=>console.log(err))

app.use(imageRoute)

const PORT = process.env.PORT | "3003";

app.listen(PORT,()=>{
    console.log(`Server listening on ${PORT}`)
})
