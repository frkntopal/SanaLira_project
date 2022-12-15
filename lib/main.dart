import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanalira_project/provider/provider.dart';
import 'package:sanalira_project/screens/homepage.dart';
import 'package:sanalira_project/screens/mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const SanaLira());
}

class SanaLira extends StatelessWidget {
  const SanaLira({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SanaLira',
      home: ChangeNotifierProvider(
        create: (context) => FireBaseProvider(),
        child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            final provider = Provider.of<FireBaseProvider>(context);
            if (provider.signIn) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return HomePage();
            } else {
              return MainPage();
            }
          },
        ),
      ),
    );
  }
}
