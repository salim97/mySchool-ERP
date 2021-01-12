const mongoose = require('mongoose');

const groupSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  name: {
    type: String,
    required: [true, 'A group must have a name'],
  },
  section: {
    autopopulate: true,
    type: mongoose.Schema.ObjectId,
    ref: 'section',
    required: [true, 'group must belong to a section!']
  },



},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });

  groupSchema.plugin(require('mongoose-autopopulate'));

const group = mongoose.model('group', groupSchema);

module.exports = group;