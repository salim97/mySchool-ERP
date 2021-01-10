const mongoose = require('mongoose');

const sectionSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  name: {
    type: String,
    required: [true, 'A section must have a name'],
  },

},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });


const section = mongoose.model('section', sectionSchema);

module.exports = section;