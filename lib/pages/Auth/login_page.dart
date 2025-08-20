import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/Auth/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

void login(){


}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Learning login"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 60,
            ),

            SizedBox(height: 50),

            //email
            Padding(
              padding: EdgeInsets.only(right: 300, left: 300),
              child: TextField(
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

            //Jump to registration page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                TextButton(
                  child: Text("Click here to register"),
                  onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                )
              ],
            ),
            
            SizedBox(height: 30),

            //Login buttom
            ElevatedButton(
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                login();
              },
            ),
          ],
        ),
      ),
    );
  }
}