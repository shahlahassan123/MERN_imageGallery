const multer = require("multer");
const {v4: uuid} = require("uuid");
const path = require("path");

const storage = multer.diskStorage({
    destination : function (req,file,cb){
        cb(null, "./public/uploads" )
    },
    filename : function(req, file, cb){
        console.log("image", `${uuid()}_${path.extname(file.originalname)}` )
        cb(null, `${uuid()}_${path.extname(file.originalname)}`)
        // cb(null, `${uuidv4()}`+ path.extname(file.originalname));
    }
})

const fileFilter = (req, file, cb) =>{
    allowedFileType = ['image/jpeg', 'image/jpg' , 'image/png']
    if(allowedFileType.includes(file.mimetype)){
        cb(null,true)
    }else{
        cb(null,false)
    }
}

const multerMiddleware = multer({storage, fileFilter})

module.exports = multerMiddleware