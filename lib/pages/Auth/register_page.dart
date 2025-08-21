import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/Auth/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

void register(emailText,passText) async {
  try {
    final User? user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailText, password: passText))
        .user;
    if (user != null)
      print("ユーザ登録しました ${user.email} , ${user.uid}");
  } catch (e) {
    print(e);
  }
}

class _RegisterPageState extends State<RegisterPage> {
  //password隠すための
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  //textField data
  TextEditingController emailText = TextEditingController();
  TextEditingController passText = TextEditingController();
  TextEditingController comfirmText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Learning register"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_open,
              size: 60,
            ),

            SizedBox(height: 50),

            //email
            Padding(
              padding: EdgeInsets.only(right: 300, left: 300),
              child: TextField(
                controller: emailText,
                decoration: InputDecoration(
                  hintText: "email",
                ),
              ),
            ),
            
            SizedBox(height: 10),

            //password
            Padding(
              padding: EdgeInsets.only(right: 300, left: 300),
              child: TextField(
                controller: passText,
                obscureText: _obscurePass,
                decoration: InputDecoration(
                  hintText: "password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePass = !_obscurePass; // toggle visibility
                      });
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            //password
            Padding(
              padding: EdgeInsets.only(right: 300, left: 300),
              child: TextField(
                controller: comfirmText,
                obscureText: _obscureConfirm,
                decoration: InputDecoration(
                  hintText: "confirm password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirm = !_obscureConfirm; // toggle visibility
                      });
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            //Jump to login page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Alrd have an account? "),
                TextButton(
                  child: Text("Click here to Login"),
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                )
              ],
            ),
            
            SizedBox(height: 30),

            //register buttom
            ElevatedButton(
              child: const Text('Register'),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                if (passText.text == comfirmText.text){ 
                  register(emailText.text, passText.text);
                }else{
                  Text("diff pass");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}