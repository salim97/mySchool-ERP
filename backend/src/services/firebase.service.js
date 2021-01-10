

var admin = require("firebase-admin");

var serviceAccount = require("../../school-erp-ef01f-firebase-adminsdk-8nouk-98c56d46f6.json");
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const student = require('../models/users/student.model');
const catchAsync = require('../utils/catchAsync');
const AppError = require('../utils/appError');
const factory = require('../controllers/handlerFactory');
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
    localIP = localIP+":3000"
    console.log("localIP = " + localIP);
    var externalIP = await getExternalIP();
    externalIP = externalIP+":3000"
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



notify = catchAsync(async (req, res, next) => {
    // return tokenValidator.validate(req, res, next)
    console.log("nik sowa");
    const { title, body, registrationToken } = req.body;

    var message = {
        notification: {
            title: title,
            body: body
        },
        data: {
            key: 'value',
        },
        token: registrationToken
    };


    var response = await admin.messaging().send(message);

    res.status(200).json({
        status: 'success',
        data: response
    });


});


//-----------------------------------------------------------------------------
//      CURD(create, update, read, delete)
//-----------------------------------------------------------------------------
const express = require('express');

const authController = require('../controllers/auth.controller');

const router = express.Router({ mergeParams: true });

router.use(authController.protect);

router
    .route('/')
    .post(authController.restrictTo('admin'), notify);

module.exports = router;