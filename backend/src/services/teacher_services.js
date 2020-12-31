const teacher = require('../models/users/teacherModel');
const factory = require('../controllers/handlerFactory');
// const catchAsync = require('./../utils/catchAsync');

getAll = factory.getAll(teacher);
getOne = factory.getOne(teacher);
createOne = factory.createOne(teacher);
updateOne = factory.updateOne(teacher);
deleteOne = factory.deleteOne(teacher);

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