const thisModel = require('../../models/academics/section.model');
const factory = require('../../controllers/handlerFactory');
const catchAsync = require('../../utils/catchAsync');
const AppError = require('../../utils/appError');


getAll = factory.getAll(thisModel);
getOne = factory.getOne(thisModel);
createOne = factory.createOne(thisModel);
deleteOne = factory.deleteOne(thisModel);
updateOne = factory.updateOne(thisModel);

//-----------------------------------------------------------------------------
//      CURD(create, update, read, delete)
//-----------------------------------------------------------------------------
const express = require('express');

const authController = require('../../controllers/auth.controller');

const router = express.Router({ mergeParams: true });

router.use(authController.protect);

router
  .route('/')
  .get(authController.restrictTo('admin', 'teacher', 'student', 'parent'), getAll)
  .post(authController.restrictTo('admin'), createOne);

router
  .route('/:id')
  .get(authController.restrictTo('admin', 'teacher', 'student', 'parent'), getOne)
  .patch(authController.restrictTo('admin'), updateOne)
  .delete(authController.restrictTo('admin'), deleteOne);

module.exports = router;