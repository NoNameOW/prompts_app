import 'package:firebase_auth/firebase_auth.dart';
import 'package:prompt_app/models/user.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFireBaseUser(FirebaseUser user){
    return user != null? User(uid: user.uid, isAdmin: false) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFireBaseUser);
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFireBaseUser(user);
    } catch(error){
      print(error.toString());
      return null;
    }
  }
  
  Future  signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch(error){
      print(error.toString());
      return null;
    }
  }
  
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(error){
      print(error.toString());
      return null;

    }
  }


}
void addAdmin(User user, String uid){
  if (user.uid == uid){
    user.isAdmin = true;
  }
}
  
