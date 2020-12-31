const student = require('../models/users/studentModel');
const factory = require('../controllers/handlerFactory');
// const catchAsync = require('./../utils/catchAsync');

getAll = factory.getAll(student);
getOne = factory.getOne(student);
createOne = factory.createOne(student);
updateOne = factory.updateOne(student);
deleteOne = factory.deleteOne(student);

//-----------------------------------------------------------------------------
//      CURD(create, update, read, delete)
//-----------------------------------------------------------------------------
const express = require('express');

const authController = require('../controllers/authController');

const router = express.Router({ mergeParams: true });

router.use(authController.protect);

router
  .route('/')
  .get(authController.restrictTo('admin'), getAll)
  .post(authController.restrictTo('admin'), createOne);

router
  .route('/:id')
  .get(authController.restrictTo('admin'), getOne)
  .patch(authController.restrictTo('admin'), updateOne)
  .delete(authController.restrictTo('admin'), deleteOne);

module.exports = router;