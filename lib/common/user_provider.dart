import 'package:flutter/material.dart';
import 'package:mainalihr/model/UserCredentials.dart';




class UserProvider extends ChangeNotifier {
 UserCredentials? _userCredentials;

  UserCredentials? get userCredentials => _userCredentials;

  UserCredentials updateUserCredentials(UserCredentials credentials) {
    _userCredentials = credentials;
    notifyListeners();
    return _userCredentials!;
}
}