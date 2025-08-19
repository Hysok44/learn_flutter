import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestorePage extends StatefulWidget {
  FirestorePage({super.key});

  @override
  State<FirestorePage> createState() => _FirestorePageState();
}

class _FirestorePageState extends State<FirestorePage> {
  String fireData = "";
  List<Map<String, String?>> dataList = [];

  //まずここが呼ばれる
  @override
  void initState() {
    super.initState();

    getData();
  }

  //saveData
  Future<void> saveData(fireData) async {
    try {
      var ref = await FirebaseFirestore.instance
        .collection('test_firestore')
        .doc("uid") //これ追加しないと勝手に生成　"oLjA8d6Kf8XW..."
        .collection("fireData")
        // .set({ //もし↑するならセット
        .add({
          'realData': fireData,
      });
      
      //保存後取得し反映
      await getData();
    } catch (e) {
      print("保存失敗: $e");
    }
  }

  //getData
  Future<void> getData() async {
    var snapshot = await FirebaseFirestore.instance
      .collection('test_firestore')
      .doc("uid")
      .collection("fireData")
      .get();

    //一回リストをリセットしてからデータ追加する
    //データの順番はバラバラ　docがランダムに生成されるため "oLjA8d6Kf8XW..."
    setState(() {
      dataList.clear();
      for (var doc in snapshot.docs) {
        dataList.add({
          'key': doc.id,
          'realData': doc['realData'],
        });
      }
    });
  }

  //delete
  Future<void> deleteData(index) async {

    String? key = dataList[index]['key'];
    await FirebaseFirestore.instance
      .collection('test_firestore')
      .doc("uid")
      .collection("fireData")
      .doc(key)
      .delete();

    await getData();
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
            Container(
              height: 400, width: 400,

              //表示
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Center(
                      child: Text(dataList[index]['realData'] ?? ''),
                    ),
                    onTap: (){
                      deleteData(index);
                    },
                  );
                },
              ),
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