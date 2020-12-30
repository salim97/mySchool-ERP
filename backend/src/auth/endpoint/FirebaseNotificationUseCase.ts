import * as express from 'express'
import IAuthRepository from '../domain/IAuthRepository'

var admin = require("firebase-admin");

var serviceAccount = require("./../../../school-erp-ef01f-firebase-adminsdk-8nouk-98c56d46f6.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

export default class FirebaseNotificationEndpoint {
    constructor(private authRespository: IAuthRepository,) { }

    public async request(req: express.Request, res: express.Response) {
        try {
            const token = req.headers.authorization!
            return this.execute(req, res)
                .then((result) => res.status(200).json({ message: result }))
                .catch((err: Error) => res.status(404).json({ error: err }))
        } catch (err) {
            return res.status(400).json({ error: err })
        }
    }

    public async execute(req: express.Request, res: express.Response): Promise<string> {

        // return tokenValidator.validate(req, res, next)
        console.log("nik sowa");
        var registrationToken = req.body.registrationToken;

        var message = {
            notification: {
                title: req.body.title,
                body: req.body.message
            },
            data: {
                key: 'value',
            },
            token: registrationToken
        };


        return await admin.messaging().send(message)
            .then((response: any) => {
      
                // Response is a message ID string.
                console.log('Successfully sent message:', response);
                //   return res.status(200).json({ message: response });
                return { "Successfully sent message": response }
            })
            .catch((error: any) => {
                console.log('Error sending message:', error);
                //   return res.status(400).json({ error: error })
                return Promise.reject({ "Error sending message": error })
            });
        //  var r = await admin.messaging().send(message);
        // return 

        // return Promise.resolve('Successfully signed out')
    }
}
