import 'package:flutter/material.dart';

class RealtimePage extends StatelessWidget {
  const RealtimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Learning RealtimeDatabase"),
        ),

        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Show realtime database list here",
                 style: TextStyle(
                  fontSize: 20,
                 )
              ),

              Padding(
                padding: EdgeInsetsGeometry.only(left: 200,right: 200,top: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type here",
                        ),
                      ),
                    ),

                     IconButton(
                      onPressed: () {
                        
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}