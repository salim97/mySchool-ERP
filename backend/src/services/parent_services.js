const parent = require('../models/users/parentModel');
const factory = require('../controllers/handlerFactory');
// const catchAsync = require('./../utils/catchAsync');

getAll = factory.getAll(parent);
getOne = factory.getOne(parent);
createOne = factory.createOne(parent);
updateOne = factory.updateOne(parent);
deleteOne = factory.deleteOne(parent);

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