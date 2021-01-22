const mongoose = require('mongoose');
const dotenv = require('dotenv');

process.on('uncaughtException', err => {
  console.log('UNCAUGHT EXCEPTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  process.exit(1);
});

dotenv.config({ path: './config.env' });
const app = require('./src/app');

const DB = process.env.DATABASE.replace(
  '<PASSWORD>',
  process.env.DATABASE_PASSWORD
);

mongoose
  .connect(DB, {
    useNewUrlParser: true,
    useCreateIndex: true,
    useFindAndModify: false
  })
  .then(() => console.log('DB connection successful!'));


const fs = require("fs");
const https = require("https");

const keysDir = "cert/";
const options = {
  key  : fs.readFileSync(keysDir + "key.pem"),
  ca   : fs.readFileSync(keysDir + "csr.pem"),
  cert : fs.readFileSync(keysDir + "cert.pem")
};

https.createServer(options, app).listen(3000);

const port = process.env.PORT || 3000;
// const server = app.listen(port, () => {
//   console.log(`App running on port ${port}...`);
// });

process.on('unhandledRejection', err => {
  console.log('zebi');
  console.log('UNHANDLED REJECTION! 💥 Shutting down...');
  console.log(err.name, err.message);
  server.close(() => {
    process.exit(1);
  });
});
