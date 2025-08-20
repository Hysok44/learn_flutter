import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/Auth/login_page.dart';
import 'package:learn_flutter/pages/firestore_page.dart';
import 'package:learn_flutter/pages/realtime_page.dart';

class FirstGate extends StatelessWidget {
  const FirstGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Learning Flutter"),
        ),
        
        backgroundColor: Colors.grey,
      ),

      body: Center(
        //ジャンル分け
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //realtime database
            Padding(
              padding: EdgeInsetsGeometry.only(left: 300,right: 300),
              child: ListTile(
                title: Center(
                  child: Text("Learning RealtimeDatabase"),
                  
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.blue[50],
                
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RealtimePage()),
                  );
                }
              ),
            ),

            const SizedBox(height: 15),

            //firestore
            Padding(
              padding: EdgeInsetsGeometry.only(left: 300,right: 300),
              child: ListTile(
                title: Center(
                  child: Text("Learning Firestore"),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

                tileColor: Colors.blue[50],

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirestorePage()),
                  );
                }
              ),
            ),

            const SizedBox(height: 15),

            //authentication
            Padding(
              padding: EdgeInsetsGeometry.only(left: 300,right: 300),
              child: ListTile(
                title: Center(
                  child: Text("Learning Auth"),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                tileColor: Colors.blue[50],

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            //storage
            Padding(
              padding: EdgeInsetsGeometry.only(left: 300,right: 300),
              child: ListTile(
                title: Center(
                  child: Text("Learning Storage"),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20)
                ),
                tileColor: Colors.blue[50],

                onTap: () {},
              ),
            ),

            const SizedBox(height: 15),

            //google admob
            Padding(
              padding: EdgeInsetsGeometry.only(left: 300,right: 300),
              child: ListTile(
                title: Center(
                  child: Text("Google Admob"),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20)
                ),
                tileColor: Colors.blue[50],

                onTap: (){},
              ),
            )
          ],
        ),
      ),
    );
  }
}