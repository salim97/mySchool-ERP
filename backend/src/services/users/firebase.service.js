

var admin = require("firebase-admin");

var serviceAccount = require("../../../school-erp-ef01f-firebase-adminsdk-8nouk-98c56d46f6.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});



// const catchAsync = require('./../utils/catchAsync');
getLocalIP = async () => {
    const { networkInterfaces } = require('os');
    const nets = networkInterfaces();
    const results = Object.create(null); // Or just '{}', an empty object
    var localIP = ""

    for (const name of Object.keys(nets)) {
        for (const net of nets[name]) {
            // Skip over non-IPv4 and internal (i.e. 127.0.0.1) addresses
            if (net.family === 'IPv4' && !net.internal) {
                if (!results[name]) {
                    results[name] = [];
                }
                results[name].push(net.address);
                if (net.address.startsWith("192.168.1")) localIP = net.address;
            }
        }
    }
    // console.log(results);
    return localIP;
}

getExternalIP = async () => {
    var externalIP = ""
    var publicIp = require("public-ip");
    externalIP = await publicIp.v4();
    return externalIP;
}


async function runFirebaseRemoteConfig() {
    console.log('runFirebaseRemoteConfig');

    var localIP = await getLocalIP();
    localIP = localIP + ":3000"
    console.log("localIP = " + localIP);
    var externalIP = await getExternalIP();
    externalIP = externalIP + ":3000"
    console.log("externalIP = " + externalIP);

    var config = admin.remoteConfig();
    var template = await config.getTemplate().catch(function (err) {
        console.error('Unable to get template');
        console.error(err);
    });
    // console.log('ETag from server: ' + template.etag);
    // console.log(template)
    // console.log(template.parameters.backendURL.defaultValue.value)
    // template.parameters.backendURL.defaultValue.value = "kamok";



    console.log(template.parameters.localIP.defaultValue.value)
    console.log(template.parameters.externalIP.defaultValue.value)
    var shouldUpdateRemoteconfig = false;
    if (template.parameters.localIP.defaultValue.value != localIP) {
        template.parameters['localIP'] = {
            defaultValue: {
                value: localIP
            },
            description: 'local IP of the server',
        };
        shouldUpdateRemoteconfig = true;
    }
    if (template.parameters.externalIP.defaultValue.value != externalIP) {
        template.parameters['externalIP'] = {
            defaultValue: {
                value: externalIP
            },
            description: 'external IP of the server',
        };
        shouldUpdateRemoteconfig = true;
    }


    var isTemplatevalidate = false;
    await config.validateTemplate(template)
        .then(function (validatedTemplate) {
            // The template is valid and safe to use.
            isTemplatevalidate = true;
            // console.log('Template was valid and safe to use');
        })
        .catch(function (err) {
            isTemplatevalidate = false;
            // console.error('Template is invalid and cannot be published');
            // console.error(err);
        });
    console.log("isTemplatevalidate = " + isTemplatevalidate);
    console.log("shouldUpdateRemoteconfig = " + shouldUpdateRemoteconfig);
    if (shouldUpdateRemoteconfig && isTemplatevalidate) {
        await config.publishTemplate(template)
            .then(function (updatedTemplate) {
                console.log('Template has been published');
                console.log('ETag from server: ' + updatedTemplate.etag);
            })
            .catch(function (err) {
                console.error('Unable to publish template.');
                console.error(err);
            });
    }


}
// runFirebaseRemoteConfig();




const thisModel = require('../../models/users/notification.model');
const factory = require('../../controllers/handlerFactory');
const catchAsync = require('../../utils/catchAsync');
const AppError = require('../../utils/appError');


notify = catchAsync(async (req, res, next) => {
    // return tokenValidator.validate(req, res, next)
    const { topic, title, message, registrationTokens } = req.body;
    console.log("topic");
    console.log(topic);
    topic.forEach(element => {
        var package = {
            topic: element,
            notification: {
                title: title,
                body: message
            },
            // data: {
            //     key: 'value',
            // },
            // token: registrationToken
        };

        admin.messaging().send(package).then((response) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        }).catch((error) => {
            console.log('Error sending message:', error);
        });
    });


    // res.status(200).json({
    //     status: 'success',
    //     data: firebaseResponse
    // });

    req.body.createdAt = new Date().toISOString();
    req.body.senderInfo = req.user;
    const doc = await thisModel.create(req.body);

    res.status(200).json({
        status: 'success',
        data: {
            data: doc
        },
    });
});



getAll = catchAsync(async (req, res, next) => {
    let filter = {};
    if (req.user.role == "teacher") filter = { topic: "all_teachers" };
    if (req.user.role == "student") filter = { topic: "all_students" };
    if (req.user.role == "parent") filter = { topic: "all_parents" };
    // const doc = await features.query.explain();
    const doc = await thisModel.find(filter);

    // SEND RESPONSE
    res.status(200).json({
        status: 'success',
        results: doc.length,
        data: {
            data: doc
        }
    });
});

deleteOne = factory.deleteOne(thisModel);

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
    .post(authController.restrictTo('admin'), notify);

router
    .route('/:id')
    .delete(authController.restrictTo('admin'), deleteOne);

module.exports = router;