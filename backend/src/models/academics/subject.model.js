const mongoose = require('mongoose');

const subjectSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  name: {
    type: String,
    required: [true, 'A subject must have a name'],
  },
  type: {
    type: String,
    required: [true, 'A subject must have a type'],
    enum: {
      values: ['Theory', 'Practical'],
      message: 'time type is either: Theory or Practical'
    }
  },
  
  code: {
    type: String,
    required: [true, 'A subject must have a code'],
  },



},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });


const subject = mongoose.model('subject', subjectSchema);

module.exports = subject;