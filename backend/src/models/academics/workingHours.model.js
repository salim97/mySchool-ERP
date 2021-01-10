const mongoose = require('mongoose');

const workingHoursSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },

  type: {
    type: String,
    required: [true, 'A time table must have a type'],
    enum: {
      values: ['Teaching', 'Pause'],
      message: 'time type is either: Teaching or Pause'
    }
  },
  class_hour_name: {
    type: String,
    // required: [true, 'A time table must have a ClassPeriod'],
  },
  startTime: {
    type: String,
    required: [true, 'A time table must have a startTime'],
  },
  endTime: {
    type: String,
    required: [true, 'A time table must have a endTime'],
  },

},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });


const workingHours = mongoose.model('workingHours', workingHoursSchema);

module.exports = workingHours;
