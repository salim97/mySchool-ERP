const mongoose = require('mongoose');

const studentSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  user: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    autopopulate: true,
    required: [true, 'student must belong to a User account!']
  },
  name: {
    type: String,
    required: [true, 'A personal must have a name'],
},
  parent: {
    type: mongoose.Schema.ObjectId,
    ref: 'Parents',
    // required: [true, 'student must belong to a User account!']
  },
  gender: {
    type: String,
    required: [true, 'A personal must have a gender'],
    enum: {
      values: ['male', 'female'],
      message: 'Gender is either: male or female'
    }
  },
  date_of_birth: {
    type: Date,
    //required: [true, 'A personal must have a date of birth'],
  },
  phone: {
    type: String,
  },
  street_address: {
    type: String,
  },
  city_name: {
    type: String,
  },
  country: {
    type: String,
  },
  pin_code: {
    type: String,
  },
  joining_date: {
    type: String,
  },
  leaving_date: {
    type: String,
  },
  current_position: {
    type: String,
  },
},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  });

studentSchema.plugin(require('mongoose-autopopulate'));

// studentSchema.pre(/^find/, function (next) {
//   this.populate({
//     path: 'user',
//     select: 'name email photo role'
//   });
//   next();
// });

const userModel = require('./user.model');
studentSchema.post('findOneAndDelete', async function (doc) {
  if (doc.user._id) {
    const user = this
    // await userModel.findOneAndDelete({_id:doc.user._id})
    await userModel.deleteOne({ _id: doc.user._id })

  }
})

const Student = mongoose.model('Students', studentSchema);

module.exports = Student;
