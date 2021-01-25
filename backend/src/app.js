const path = require('path');
const express = require('express');
const morgan = require('morgan');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const mongoSanitize = require('express-mongo-sanitize');
const xss = require('xss-clean');
const hpp = require('hpp');
const cookieParser = require('cookie-parser');
const cors = require('cors')
const AppError = require('./utils/appError');
const globalErrorHandler = require('./controllers/error.controller');

const authService = require('./services/users/auth.services');
const studentService = require('./services/users/student.services');
const teacherService = require('./services/users/teacher.services');
const parentService = require('./services/users/parent.services');
const firebaseService = require('./services/users/firebase.service');

const workinghours_service = require('./services/academics/workinghours.service');
const classRoom_service = require('./services/academics/classRoom.service');
const group_service = require('./services/academics/group.service');
const section_service = require('./services/academics/section.service');
const subject_service = require('./services/academics/subject.service');
const teacherSubject_service = require('./services/academics/teacherSubject.service');
const timeTable_service = require('./services/academics/timeTable.service');

const app = express();

// Implement CORS
app.use(cors());

// Set security HTTP headers
app.use(helmet());

// Development logging
if (process.env.NODE_ENV === 'development') {
  app.use(morgan('dev'));
}

// Limit requests from same API
const limiter = rateLimit({
  max: 100,
  windowMs: 60 * 60 * 1000,
  message: 'Too many requests from this IP, please try again in an hour!'
});
// app.use('/api', limiter); // TODO: uncomment this on production 

// Body parser, reading data from body into req.body
app.use(express.json({ limit: '10kb' }));
app.use(express.urlencoded({ extended: true, limit: '10kb' }));
app.use(cookieParser());

// Data sanitization against NoSQL query injection
app.use(mongoSanitize());

// Data sanitization against XSS
app.use(xss());

// Prevent parameter pollution
app.use(
  hpp(
  //   {
  //   whitelist: [
  //     'duration',
  //     'ratingsQuantity',
  //     'ratingsAverage',
  //     'maxGroupSize',
  //     'difficulty',
  //     'price'
  //   ]
  // }
  )
);

// Test middleware
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  // console.log(req.cookies);
  next();
});

// 3) ROUTES
app.use('/api/v1/auth', authService);
app.use('/api/v1/students', studentService);
app.use('/api/v1/parents', parentService);
app.use('/api/v1/teachers', teacherService);
app.use('/api/v1/notify', firebaseService);
app.use('/api/v1/academics/classRoom_service', classRoom_service);
app.use('/api/v1/academics/group_service', group_service);
app.use('/api/v1/academics/section_service', section_service);
app.use('/api/v1/academics/subject_service', subject_service);
app.use('/api/v1/academics/teacherSubject_service', teacherSubject_service);
app.use('/api/v1/academics/timeTable_service', timeTable_service);
app.use('/api/v1/academics/workinghours_service', workinghours_service);

// Serving static files
app.use(express.static(path.join(__dirname, '../public')));
app.get('/', function(req, res) {
  res.sendFile(path.join(__dirname, '../public', 'index.html'));
});

app.all('*', (req, res, next) => {
  next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

app.use(globalErrorHandler);

module.exports = app;





