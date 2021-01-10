const thisModel = require('../../models/users/student.model');
const userAccount = require('../../models/users/user.model');
const factory = require('../../controllers/handlerFactory');
const catchAsync = require('../../utils/catchAsync');
const AppError = require('../../utils/appError');
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
deleteOne = factory.deleteOne(thisModel);

// updateOne = factory.updateOne(thisModel);
updateOne = catchAsync(async (req, res, next) => {
  //check if documents exists
  const old_doc_student = await thisModel.findById(req.params.id);
  if (!old_doc_student) {
    return next(new AppError('No student document found with that USER ID', 404));
  }

  if (req.body.user) {
    if (!req.body.user._id) {
      return next(new AppError('USER ID IS NULL', 404));
    }
    //check if documents exists
    const old_doc_user = await userAccount.findById(req.body.user._id);
    if (!old_doc_user) {
      return next(new AppError('No user document found with that USER ID', 404));
    }
    //don't allow request edit other user account, check student if he is related to user account
    if (old_doc_student.user.id != req.body.user._id) {
      return next(new AppError('you are trying to edit other user account', 404));
    }
  }



  //update doc
  const new_doc_Student = await thisModel.findByIdAndUpdate(req.params.id, req.body, {
    new: true,
    runValidators: true
  });
  if (!new_doc_Student) {
    return next(new AppError('No document found with that ID', 404));
  }
  if (req.body.user) {
    //filter and update
    const filteredBody = filterObj(req.body.user, 'name', 'email');
    const new_doc_user = await userAccount.findByIdAndUpdate(req.body.user._id, filteredBody, {
      new: true,
      runValidators: true
    });
    new_doc_Student.user = new_doc_user;
  }

  res.status(200).json({
    status: 'success',
    data: {
      data: new_doc_Student
    }
  });
});



//-----------------------------------------------------------------------------
//      CURD(create, update, read, delete)
//-----------------------------------------------------------------------------
const express = require('express');

const authController = require('../../controllers/auth.controller');

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