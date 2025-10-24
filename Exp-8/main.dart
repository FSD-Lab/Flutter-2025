import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:demo_exp8/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<FirebaseApp> _initializeFirebase() async {
    print('Checking Firebase apps: ${Firebase.apps}');
    if (Firebase.apps.isEmpty) {
      print('No Firebase apps found, initializing...');
      if (Platform.isAndroid) {
        return await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyBU4HTWVYScqZvuLyB2uEb6itlY719vgCc",
            appId: "1:252179750265:android:6991e01bae72210020e3a8",
            messagingSenderId: "252179750265",
            projectId: "fir-exp8-8cf81",
          ),
        );
      } else {
        return await Firebase.initializeApp();
      }
    }
    print('Firebase already initialized: ${Firebase.apps}');
    return Firebase.app('[DEFAULT]');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return MaterialApp(
              home: Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')),
              ),
            );
          }
          return MaterialApp(
            title: 'Flutter Firebase Email Password Auth',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
            ),
            debugShowCheckedModeBanner: false,
            home: Login(),
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }
}