const mongoose = require('mongoose');

const timeTableSchema = new mongoose.Schema({
    createdAt: {
        type: Date,
        default: Date.now()
    },
    groupid: {
        type: mongoose.Schema.ObjectId,
        ref: 'group',
        autopopulate: true,
        required: [true, 'groupid must belong to a group!']
    },

    children: [
        {
            day: {
                type: String,
                required: [true, 'A personal must have a gender'],
                enum: {
                    values: ['saturday', 'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday'],
                    message: 'day must one of this elements: saturday, sunday, monday, tuesday, wednesday, thursday, friday'
                }
            },
            workingHoursid: {
                type: mongoose.Schema.ObjectId,
                ref: 'workingHours',
                autopopulate: true,
                required: [true, 'workingHoursid must belong to a workingHours!']
            },

            classRoomid: {
                type: mongoose.Schema.ObjectId,
                ref: 'classRoom',
                autopopulate: true,
                required: [true, 'classRoomid must belong to a class Room!']
            },
            teacherSubjectid: {
                type: mongoose.Schema.ObjectId,
                ref: 'teacherSubject',
                autopopulate: true,
                required: [true, 'teacherSubject must belong to a class Room!']
            },
        }
    ],

},
    {
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    });

timeTableSchema.plugin(require('mongoose-autopopulate'));




const timeTable = mongoose.model('timeTable', timeTableSchema);

module.exports = timeTable;