import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth;
  final FlutterSecureStorage _secureStorage;

  AuthenticationRepository({
    FirebaseAuth? firebaseAuth,
    FlutterSecureStorage? secureStorage,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _secureStorage = secureStorage ?? const FlutterSecureStorage();

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> storeCredentials({
    required String email,
    required String password,
  }) async {
    await _secureStorage.write(key: 'email', value: email);
    await _secureStorage.write(key: 'password', value: password);
  }

  Future<Map<String, String?>> getCredentials() async {
    final email = await _secureStorage.read(key: 'email');
    final password = await _secureStorage.read(key: 'password');
    return {
      'email': email,
      'password': password,
    };
  }
}
