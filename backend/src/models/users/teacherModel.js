const mongoose = require('mongoose');

const teacherSchema = new mongoose.Schema({
    createdAt: {
        type: Date,
        default: Date.now()
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
        required: [true, 'teacher must belong to a User account!']
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
        // required: [true, 'A personal must have a date of birth'],
    },
    qualification: {
        type: String,
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
    employee_code: {
        type: String,
    },
},
    {
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    });

teacherSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'name email photo'
    });
    next();
});

const Teacher = mongoose.model('Teachers', teacherSchema);

module.exports = Teacher;
