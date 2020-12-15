import dotenv from 'dotenv'
import express from 'express'
import CompositionRoot from './CompositionRoot'
// const mongoose = require('mongoose');

// const URI ="mongodb+srv://zebi:qH1Hl8bQ6Jmor2xw@salimcluster0.ihlyn.mongodb.net/my-school-db?retryWrites=true&w=majority";

// const connectDB = async () => {
//     console.log('zebi..!');
//   await mongoose.connect(URI, {
//     useUnifiedTopology: true,
//     useNewUrlParser: true
//   });
//   console.log('db connected..!');
// };

// connectDB();

dotenv.config()
CompositionRoot.configure()

const PORT = process.env.PORT || 3000

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use('/auth', CompositionRoot.authRouter())

app.listen(PORT, () => console.log(`listening on port ${PORT}`))
