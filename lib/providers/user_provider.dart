import 'package:flutter/cupertino.dart';
import 'package:amazon_clone/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    // Initialize a default user object with empty values
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
    cart: [],
  );
  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user); // Set the user data from the provided JSON
    notifyListeners(); // Notify the listeners (UI) that the user data has changed
  }
  void setUserFromModel(User user){
    _user= user;
    notifyListeners();
  }
}
