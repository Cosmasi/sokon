
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/tools/app_tools.dart';

import 'models/users.dart';

class Authentication{
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child(users);

  Future<String> createUser({String email, String password, String userName, String phone}) async {
    try{
        User firebaseUser;
        await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      ).then((userAuth){
        firebaseUser = userAuth.user;
      }).catchError((e){
        PlatformException exception = e;
        print(exception.details);
        // return errorMSG(exception.message);
      });

      if(firebaseUser != null){
        usersRef.child(firebaseUser.uid).set({
          userID: firebaseUser.uid,
          fullName: userName,
          phoneNumber: phone,
          userEmail: email,
        });

        writeDataLocally(key: userID, value: firebaseUser.uid);
        writeDataLocally(key: fullName, value: userName);
        writeDataLocally(key: phoneNumber, value: phone);
        writeDataLocally(key: userEmail, value: email);
        writeBoolDataLocally(key: loggedIn, value: true);
      }
    }catch(e){
      print(e);
      // errorMSG(e);
    }
    
    return "successful";
  }

  Future<String> loginUser({String email, String password}) async {
    try{
      await auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
      ).then((userAuth){
        firebaseUser = userAuth.user;
      }).catchError((e){
        PlatformException exception = e;
        print(exception.details);
        // return errorMSG(exception.message);
      });

      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snapshot){
        UsersModel usersInfo = UsersModel(
          userId: snapshot.value[userID],
          email: snapshot.value[userEmail],
          userName: snapshot.value[fullName],
          userPhone: snapshot.value[phoneNumber]
        );
        
        if(firebaseUser.uid != null && usersInfo !=null){
          writeDataLocally(key: userID, value: usersInfo.userId);
          writeDataLocally(key: fullName, value: usersInfo.userName);
          writeDataLocally(key: phoneNumber, value: usersInfo.userPhone);
          writeDataLocally(key: userEmail, value: usersInfo.email);
          writeBoolDataLocally(key: loggedIn, value: true);

        }
      });
    }catch(e){
      print(e);
      // errorMSG(e);
    }

    return "successful";
  }

  Future<bool> logOutUser() async {
    await auth.signOut();
    await clearDataLocally();
    return true;
  }

}