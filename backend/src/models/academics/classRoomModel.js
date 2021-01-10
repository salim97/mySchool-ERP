const mongoose = require('mongoose');

const classRoomSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  room_number: {
    type: String,
    required: [true, 'A Class Room must have a room number'],
  },
  capacity: {
    type: Number,
    required: [true, 'A Class Room must have a capacity'],
  },

},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });


const classRoom = mongoose.model('classRoom', classRoomSchema);

module.exports = classRoom;
