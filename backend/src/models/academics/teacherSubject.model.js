const mongoose = require('mongoose');

const teacherSubjectSchema = new mongoose.Schema({
    createdAt: {
        type: Date,
        default: Date.now()
    },
    teacherid: {
        type: mongoose.Schema.ObjectId,
        ref: 'teachers',
        autopopulate: true,
        required: [true, 'teacherid must belong to a teacher!']

    },
    subjectid: {
        type: mongoose.Schema.ObjectId,
        ref: 'subject',
        autopopulate: true,
        required: [true, 'subjectid must belong to a subject!']
    },

},
    {
        toJSON: { virtuals: true },
        toObject: { virtuals: true }
    });

teacherSubjectSchema.plugin(require('mongoose-autopopulate'));

const teacherSubject = mongoose.model('teacherSubject', teacherSubjectSchema);

module.exports = teacherSubject;