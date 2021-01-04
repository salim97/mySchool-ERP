import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfig {
  RemoteConfig remoteConfig;
  get backendURL => remoteConfig.getString('backendURL');
  synchroniseWithFirebase() async {
    remoteConfig = await RemoteConfig.instance;
    await remoteConfig.fetch(expiration: const Duration(hours: 5)); // this reupdate local cache
    await remoteConfig.activateFetched(); // update current cache
    print('welcome message: ' + remoteConfig.getString('backendURL'));
  }
}
