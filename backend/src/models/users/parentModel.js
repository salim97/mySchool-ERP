const mongoose = require('mongoose');

const parentSchema = new mongoose.Schema({
    createdAt: {
        type: Date,
        default: Date.now()
    },
    user: {
        type: mongoose.Schema.ObjectId,
        ref: 'User',
        required: [true, 'parent must belong to a User account!']
      },
    children: [
        {
            type: mongoose.Schema.ObjectId,
            ref: 'Students'
        }
    ],
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
        required: [true, 'A personal must have a date of birth'],
    },
    phone: {
        type: String,
        // required: [true, 'A personal must have a date of birth'],
    },

},
    {
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    });

parentSchema.pre(/^find/, function (next) {
    this.populate({
        path: 'user',
        select: 'name email photo role'
    }).populate({
        path: 'children',
        select: 'date_of_birth user'
    });
    next();
});



const Parent = mongoose.model('Parents', parentSchema);

module.exports = Parent;