abstract class AuthService {
  Future<Map> login({String email, String password});

  Future<bool> signout();
}

class FakeAuthService implements AuthService {
  @override
  Future<Map> login({String email, String password}) async {
    return {
      "token": "azertyu35461+-sdf54sdf981",
      "email": "email@email.com",
      "first name": "si zebi",
      "last name": "nik mok",
      "profile image": "sowa.com"
    };
  }

  @override
  Future<bool> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }
}

// class AuthServiceImpl implements AuthService {
//   @override
//   Future login({String email, String password}) async => throw UnimplementedError();

//   @override
//   Future<bool> signout() {
//     // TODO: implement signout
//     throw UnimplementedError();
//   }
// }
