const thisModel = require('../models/users/teacherModel');
const userAccount = require('../models/users/userModel');
const factory = require('../controllers/handlerFactory');
const catchAsync = require('./../utils/catchAsync');
const AppError = require('./../utils/appError');
filterObj = (obj, ...allowedFields) => {
  const newObj = {};
  Object.keys(obj).forEach(el => {
    if (allowedFields.includes(el)) newObj[el] = obj[el];
  });
  return newObj;
};

getAll = factory.getAll(thisModel);
getOne = factory.getOne(thisModel);
createOne = factory.createOne(thisModel);
// updateOne = factory.updateOne(thisModel);
updateOne = catchAsync(async (req, res, next) => {
  //check if documents exists
  const old_doc_teacher = await thisModel.findById(req.params.id);
  if (!old_doc_teacher) {
    return next(new AppError('No teacher document found with that USER ID', 404));
  }
  if (req.body.user) {
    // check if request is valid
    if (!req.body.user._id) {
      return next(new AppError('USER ID IS NULL', 404));
    }
    //check if documents exists
    const old_doc_user = await userAccount.findById(req.body.user._id);
    if (!old_doc_user) {
      return next(new AppError('No user document found with that USER ID', 404));
    }
    //don't allow request edit other user account, check student if he is related to user account
    if (old_doc_teacher.user.id != req.body.user._id) {
      return next(new AppError('you are trying to edit other user account', 404));
    }
  }

  //update doc
  const new_doc_teacher = await thisModel.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true
  });
  if (!new_doc_teacher) {
    return next(new AppError('No document found with that ID', 404));
  }
  
  if (req.body.user) {
    //filter and update
    const filteredBody = filterObj(req.body.user, 'name', 'email');
    const new_doc_user = await userAccount.findByIdAndUpdate(req.body.user._id, filteredBody, {
      new: true,
      runValidators: true
    });
    new_doc_teacher.user = new_doc_user;
  }

  res.status(200).json({
    status: 'success',
    data: {
      data: new_doc_teacher
    }
  });
});

// deleteOne = factory.deleteOne(parent);
deleteOne = catchAsync(async (req, res, next) => {

  // const doc = await thisModel.findByIdAndDelete(req.params.id);
  const doc = await thisModel.findOneAndDelete(req.params.id);
  
  // const docStudent = await teacher.findById(req.params.id);

  if (!doc) {
    return next(new AppError('No document found with that ID', 404));
  }

  // if (doc.user.id) {
  //   await userAccount.findByIdAndDelete(doc.user.id);
  //   // await userAccount.findByIdAndUpdate(doc.user.id, { active: false });
  // }

  res.status(204).json({
    status: 'success',
    data: null
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
  .get(authController.restrictTo('admin'), getAll)
  .post(authController.restrictTo('admin'), createOne);

router
  .route('/:id')
  .get(authController.restrictTo('admin'), getOne)
  .patch(authController.restrictTo('admin'), updateOne)
  .delete(authController.restrictTo('admin'), deleteOne);

module.exports = router;