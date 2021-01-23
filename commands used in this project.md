
#frontend web
flutter clean
flutter build web
http-server .\build\web\ -p 80 

#frontend android
flutter clean
flutter build apk

#backend
## to start mongoDB container
docker-compose up 
## to start nodejs
npm start
## to install dependency
npm install
## to install nodemon CLI globally
npm install -g nodemon


#azure
## login to azure container registry
docker login  myschoolerp.azurecr.io 
# password you find it in, go to azure home page then to container registry => access keys
# build image localy
docker build -t myschoolerp.azurecr.io/node-docker-demo:latest .
# run the image and forward the port 3000 
docker run -d -p 3000:3000 myschoolerp.azurecr.io/node-docker-demo
# push local image to azure container registry
docker push myschoolerp.azurecr.io/node-docker-demo:latest
# go to app service => container settings => enable continuous deployment, this will refresh app service each time you push a docker container to azure container registry

#firebase 
## assign remote firebase to local folder
firebase init
## pushing local web artifacts to firebase hosting
firebase deploy --only hosting 


