var admin = require("firebase-admin");

var serviceAccount = require("./../../school-erp-ef01f-firebase-adminsdk-8nouk-98c56d46f6.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const student = require('../models/users/studentModel');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');
const factory = require('../controllers/handlerFactory');
// const catchAsync = require('./../utils/catchAsync');

notify = catchAsync(async (req, res, next) => {
    // return tokenValidator.validate(req, res, next)
    console.log("nik sowa");
    const{title, body, registrationToken} = req.body;

    var message = {
        notification: {
            title: title,
            body: body
        },
        data: {
            key: 'value',
        },
        token: registrationToken
    };


    var response = await admin.messaging().send(message);

    res.status(200).json({
        status: 'success',
        data: response
    });


});


//-----------------------------------------------------------------------------
//      CURD(create, update, read, delete)
//-----------------------------------------------------------------------------
const express = require('express');

const authController = require('../controllers/authController');

const router = express.Router({ mergeParams: true });

router.use(authController.protect);

router
    .route('/')
    .post(authController.restrictTo('admin'), notify);

module.exports = router;