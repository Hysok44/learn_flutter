import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatefulWidget {
  FirestorePage({super.key});

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  String fireData = "";

  Future<void> saveData(fireData) async {
  try {
    var docRef = await FirebaseFirestore.instance
        .collection('users')
        .add({
          'name': 'Taro',
          'age': 25,
          'createdAt': FieldValue.serverTimestamp(),
        });
      // 保存直後に読み出してみる
      var snapshot = await docRef.get();
      print("保存されたデータ: ${snapshot.data()}");
    } catch (e) {
      print("保存失敗: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Learning Firestore"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          children: [            
            Padding(
              padding: const EdgeInsets.only(left: 200,right: 200,top: 50),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type here",
                      ),
                      onChanged: (value){
                        fireData = value;
                      },
                    ),
                  ),

                  IconButton(
                    onPressed: () async {
                      try {
                        await saveData(fireData);
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
    );
  }
}