const mongoose = require('mongoose');

const notificationSchema = new mongoose.Schema({
  createdAt: {
    type: Date,
    default: Date.now()
  },
  title: {
    type: String,
    required: [true, 'A Notice must have a title'],
  },
  message: {
    type: String,
    required: [true, 'A Notice must have a message'],
  },
  topic:  [
    {
      type: String,

    }
  ],

  type: {
    type: String,
    required: [true, 'A notice must have a type'],
    enum: {
      values: ['fcm', 'email'],
      message: 'type is either: fcm or email'
    }
  },
  senderInfo: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: [true, 'sender must belong to a User account!']
  },
  children: [
    {
      type: mongoose.Schema.ObjectId,
      ref: 'User'
    }
  ],
});

notificationSchema.pre(/^find/, function (next) {
  this.populate({
      path: 'senderInfo',
      select: 'role email'
  }).populate({
      path: 'children',
      select: 'email phone'
  });
  next();
});

const Notification = mongoose.model('Notification', notificationSchema);

module.exports = Notification;
