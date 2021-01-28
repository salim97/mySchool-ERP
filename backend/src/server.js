const mongoose = require('mongoose');
const dotenv = require('dotenv');


process.on('uncaughtException', err => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});

dotenv.config({ path: './config.env' });
const app = require('./app');




const MONGO_INITDB_ROOT_USERNAME = process.env.MONGO_INITDB_ROOT_USERNAME || "root";
const MONGO_INITDB_ROOT_PASSWORD = process.env.MONGO_INITDB_ROOT_PASSWORD || "rootpassword";
const MONGO_INITDB_URL = process.env.MONGO_INITDB_URL || "localhost";
const MONGO_INITDB_DATABASE = process.env.MONGO_INITDB_DATABASE || "school-database";
var MONGODB_BASE_ADDRESS = "";
var PORT = 3000;
if (process.env.NODE_ENV === 'production') {
  console.log("production")
  MONGODB_BASE_ADDRESS = process.env.DATABASE;
  PORT = 80;
} else {
  console.log("development")
  MONGODB_BASE_ADDRESS = `mongodb://${MONGO_INITDB_ROOT_USERNAME}:${MONGO_INITDB_ROOT_PASSWORD}@${MONGO_INITDB_URL}:27017/${MONGO_INITDB_DATABASE}?authSource=admin&readPreference=primary&appname=MongoDB%20Compass&ssl=false`
  PORT = 3000;
}

mongoose
  .connect(MONGODB_BASE_ADDRESS, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useUnifiedTopology: true,
    useFindAndModify: false
  })
  .then(() => {
    const userModel = require('./models/users/user.model');
    userModel.estimatedDocumentCount().then((estimate) => {
      if (!process.env.NODE_ENV === 'production') {
        // console.log(MONGODB_BASE_ADDRESS);
        // console.log(`Estimated number of documents in the user collection: ${estimate}`);
      }

      if (estimate == 0) {
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


const server = app.listen(PORT, () => {
  console.log(`App running on port ${PORT}...`);
});

process.on('unhandledRejection', err => {
  console.log('UNHANDLED REJECTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  server.close(() => {
    process.exit(1);
  });
});



