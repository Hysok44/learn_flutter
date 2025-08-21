import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({super.key});
  
  void deleteUser() async {
    await FirebaseAuth.instance.currentUser?.delete();
    
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // 現在ログイン中のユーザーを取得
    final User? user = FirebaseAuth.instance.currentUser;
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //email
            Text("User email: ${user!.email}"),

            //uid
            Text("User ID: ${user!.uid}"),
            
            ElevatedButton(
              child: Text("Delete User"),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                deleteUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}