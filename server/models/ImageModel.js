const mongoose = require("mongoose");

const imageSchema = mongoose.Schema({
    photo : {type: String, required : true},  
},
   {timestamps: true}
)

module.exports = mongoose.model('images', imageSchema);