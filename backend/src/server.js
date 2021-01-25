const mongoose = require('mongoose');
const dotenv = require('dotenv');


process.on('uncaughtException', err => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});

dotenv.config({ path: './config.env' });
const app = require('./app');

// const DB = process.env.DATABASE.replace(
//   '<PASSWORD>',
//   process.env.DATABASE_PASSWORD
// );
const NODEJS_PORT = process.env.NODEJS_PORT || 3000;
const MONGO_INITDB_ROOT_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME ;
const MONGO_INITDB_ROOT_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD ;
const MONGO_INITDB_URL = process.env.MONGO_INITDB_URL ;
const MONGO_INITDB_DATABASE = process.env.MONGO_INITDB_DATABASE ;
const MONGODB_BASE_ADDRESS = `DATABASE=mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGO_INITDB_URL}:27017/${MONGO_INITDB_DATABASE}?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false`
// const MONGODB_BASE_ADDRESS = process.env.DATABASE;

// console.log(MONGODB_BASE_ADDRESS)
// console.log("how zebi")


mongoose
  .connect(MONGODB_BASE_ADDRESS, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false
  })
  .then(() => console.log('DB connection successful!'));


const server = app.listen(NODEJS_PORT, () => {
  console.log(`App running on port ${NODEJS_PORT}...`);
});

process.on('unhandledRejection', err => {
  console.log('UNHANDLED REJECTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  server.close(() => {
    process.exit(1);
  });
});





