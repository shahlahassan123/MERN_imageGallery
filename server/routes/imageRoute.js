const express = require("express");
const uploadMiddleware = require("./../middleware/uploadMiddleware")
const imageModel = require("./../models/ImageModel");

const router = express.Router();

router.get("/api/get",async(req,res)=>{
    const allPhotos = await imageModel.find().sort({createdAt : "descending"});
    res.send(allPhotos)
})


router.post("/api/save",uploadMiddleware.single("photo"),(req,res)=>{
    let photo = req.file.filename;

    imageModel.create({photo}).then(data=>res.data).catch(err=>console.log(err))


})


module.exports = router;