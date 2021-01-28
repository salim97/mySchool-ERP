const mongoose = require('mongoose');
const dotenv = require('dotenv');


process.on('uncaughtException', err => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});

dotenv.config({ path: './config.env' });
const app = require('./app');


const NODEJS_PORT = process.env.NODEJS_PORT || 3000;
const MONGO_INITDB_ROOT_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME;
const MONGO_INITDB_ROOT_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD;
const MONGO_INITDB_URL = process.env.MONGO_INITDB_URL;
const MONGO_INITDB_DATABASE = process.env.MONGO_INITDB_DATABASE;
var MONGODB_BASE_ADDRESS = "";
if (process.env.NODE_ENV === 'development') {
  MONGODB_BASE_ADDRESS = `mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGO_INITDB_URL}:27017/${MONGO_INITDB_DATABASE}?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false`
} 

if (process.env.NODE_ENV === 'production') {
  MONGODB_BASE_ADDRESS = process.env.DATABASE;
} 

mongoose
  .connect(MONGODB_BASE_ADDRESS, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
    useFindAndModify: false
  })
  .then(() =>  {
    const userModel = require('./models/users/user.model');
    userModel.estimatedDocumentCount().then( (estimate) => {
      console.log(MONGODB_BASE_ADDRESS);
      console.log(`Estimated number of documents in the user collection: ${estimate}`);
       if(estimate == 0)
       {
         userModel.create({
          email: "admin@email.com",
          password: "azerty2020",
          passwordConfirm: "azerty2020",
          role: "admin" 
        });
       } 
    });
   
    return console.log('DB connection successful!');
  });


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



