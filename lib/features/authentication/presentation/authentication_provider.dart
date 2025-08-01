import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zan_patient_portal/authentication_repository.dart';

class AuthenticationProvider with ChangeNotifier {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationProvider({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  User? _user;

  User? get user => _user;

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final userCredential =
        await _authenticationRepository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    _user = userCredential.user;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    final userCredential = await _authenticationRepository.signInWithGoogle();
    _user = userCredential.user;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authenticationRepository.signOut();
    _user = null;
    notifyListeners();
  }

  Future<void> storeCredentials({
    required String email,
    required String password,
  }) async {
    await _authenticationRepository.storeCredentials(
      email: email,
      password: password,
    );
  }

  Future<Map<String, String?>> getCredentials() async {
    return await _authenticationRepository.getCredentials();
  }
}
