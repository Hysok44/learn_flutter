import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/service/realtime_service.dart';

class RealtimePage extends StatelessWidget {
  RealtimePage({super.key});

  final RealtimeService _realtimeService = RealtimeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Learning RealtimeDatabase"),
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
                padding: const EdgeInsets.only(left: 200,right: 200,top: 50),
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
                      onPressed: () async {
                        try {
                          await _realtimeService.saveData();
                          print("✅ 保存成功");
                        } catch (e) {
                          print("❌ 保存失敗: $e");
                        }
                      },
                      icon: const Icon(Icons.save_alt),
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