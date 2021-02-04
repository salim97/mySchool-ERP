const mongoose = require('mongoose');

const groupSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  name: {
    type: String,
    required: [true, 'A group must have a name'],
    // unique: true,
  },
  section: {
    autopopulate: true,
    type: mongoose.Schema.ObjectId,
    ref: 'section',
    required: [true, 'group must belong to a section!']
  },

  children: [
    {
      type: mongoose.Schema.ObjectId,
      ref: 'Students',
      autopopulate: true
    }
  ],

},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });
groupSchema.plugin(require('mongoose-autopopulate'));


const timeTableModel = require('./timeTable.model');
groupSchema.post('findOneAndDelete', async function (doc) {
  if (doc._id) {
    await timeTableModel.deleteOne({ groupid: doc._id }, function (err, docs) {
      if (err) {
        console.log(err)
      }
      else {
        console.log("=> Deleting TimeTable related to group with id : ", doc._id);
      }
    });

  }
})
groupSchema.post('save', async function (doc) {
  if (doc._id) {
    await timeTableModel.create({ groupid: doc._id }, function (err, timeTableDoc) {
      if (err) {
        console.log(err)
      }
      else {
        console.log("=> Creating TimeTable for this group, TimeTable.id = ", timeTableDoc.id);
      }
    });
  }
})


const group = mongoose.model('group', groupSchema);
module.exports = group;