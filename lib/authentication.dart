
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:sokon/models/vendors.dart';
import 'package:sokon/tools/app_data.dart';
import 'package:sokon/tools/app_tools.dart';

import 'models/users.dart';

class Authentication{
  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference usersRef = FirebaseDatabase.instance.reference().child(users);
  DatabaseReference vendorsRef = FirebaseDatabase.instance.reference().child(vendors);

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

  Future<String> createVendor({String vEmail, String vPassword, String vName, String vPhone}) async {
    try{
      User firebaseUser;
      await auth.createUserWithEmailAndPassword(
        email: vEmail,
        password: vPassword,
      ).then((userAuth){
        firebaseUser = userAuth.user;
      }).catchError((e){
        PlatformException exception = e;
        print(exception.details);
        // return errorMSG(exception.message);
      });

      if(firebaseUser != null){
        vendorsRef.child(firebaseUser.uid).set({
          vendorID: firebaseUser.uid,
          vendorName: vName,
          vendorPhoneNumber: vPhone,
          vendorEmail: vEmail,
        });
      }
    }catch(e){
      print(e);
      // errorMSG(e);
    }

    return "successful";
  }

  Future<String> loginVendor({String vEmail, String vPassword}) async {
    try{
      await auth.signInWithEmailAndPassword(
        email: vEmail,
        password: vPassword,
      ).then((userAuth){
        firebaseUser = userAuth.user;
      }).catchError((e){
        PlatformException exception = e;
        print(exception.details);
        // return errorMSG(exception.message);
      });

      // usersRef.child(firebaseUser.uid).once().then((DataSnapshot snapshot){
      //   UsersModel usersInfo = UsersModel(
      //       userId: snapshot.value[userID],
      //       email: snapshot.value[userEmail],
      //       userName: snapshot.value[fullName],
      //       userPhone: snapshot.value[phoneNumber]
      //   );
      //
      //   if(firebaseUser.uid != null && usersInfo !=null){
      //     writeDataLocally(key: userID, value: usersInfo.userId);
      //     writeDataLocally(key: fullName, value: usersInfo.userName);
      //     writeDataLocally(key: phoneNumber, value: usersInfo.userPhone);
      //     writeDataLocally(key: userEmail, value: usersInfo.email);
      //     writeBoolDataLocally(key: loggedIn, value: true);
      //
      //   }
      // });
    }catch(e){
      print(e);
      // errorMSG(e);
    }

    return "successful";
  }

  // Future<void> getUsers() async{
  //   User firebaseUser = auth.currentUser;
  //   usersRef.child(firebaseUser.uid).once().then((DataSnapshot snapshot){
  //    UsersModel users = UsersModel(
  //      userId: snapshot.value[userID],
  //      userName: snapshot.value[fullName],
  //      email: snapshot.value[userEmail],
  //      userPhone: snapshot.value[phoneNumber],
  //    );
  //     print(users.userName);
  //     usersInfo = users;
  //   });
  // }

  // Future<void> getVendors() async{
  //   User firebaseUser = auth.currentUser;
  //   vendorsRef.child(firebaseUser.uid).once().then((DataSnapshot snapshot){
  //     Vendors vendors = Vendors(
  //       vendorId: snapshot.value[vendorID],
  //         vendorName: snapshot.value[vendorName],
  //         vendorEmail: snapshot.value[vendorEmail],
  //         vendorPhone: snapshot.value[vendorPhoneNumber],
  //     );
  //     print(vendors.vendorName);
  //     vendorsInfo = vendors;
  //   });
  // }

  Future<bool> logOutVendor() async {
    await auth.signOut();
    return true;
  }

  Future<void> getVendors() async{
    DatabaseReference vendorsRef = FirebaseDatabase.instance.reference().child(vendors);
    User firebaseUser = auth.currentUser;
    vendorsRef.child(firebaseUser.uid).once().then((DataSnapshot snapshot){
      if(snapshot.value !=null){
        Vendors vendors = Vendors(
          vendorId: snapshot.value[vendorID],
          vendorName: snapshot.value[vendorName],
          vendorEmail: snapshot.value[vendorEmail],
          vendorPhone: snapshot.value[vendorPhoneNumber],
        );
        // print(vendors.vendorName);
        print(vendors.vendorId);
        vendorsInfo = vendors;
      }
    });
  }


}