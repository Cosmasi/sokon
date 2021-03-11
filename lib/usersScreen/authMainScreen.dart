import 'package:flutter/material.dart';
import 'package:sokon/usersScreen/userLogIn.dart';
import 'package:sokon/usersScreen/userRegistration.dart';

class UserAuthScreen extends StatefulWidget {
  static const String id = 'authenticateScreen';
  @override
  _UserAuthScreenState createState() => _UserAuthScreenState();
}

class _UserAuthScreenState extends State<UserAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("SokonApp", style: TextStyle(fontSize: 25.0),),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 5.0,
            tabs: [
              Tab(icon: Icon(Icons.lock, color: Colors.white), text: "Login"),
              Tab(icon: Icon(Icons.perm_contact_calendar, color: Colors.white), text: "Register")
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UserLogIn(),
            UserRegistration(),
          ],
        ),
      ),
    );
  }
}