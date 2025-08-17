import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimePage extends StatefulWidget {

  @override
  State<RealtimePage> createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage>{
  final streamRef = FirebaseDatabase.instance.ref('test_realtime');

  int textNum = 0;
  String textData = "";
  List<Map<String, String?>> dataList = [];

  //表示されたときにまずここ
  @override
  void initState() {
    super.initState();

    getData();
  }

  //saveData
  Future<void> saveData(textData) async {
    DatabaseReference newRef = streamRef.push();
    await newRef.set({'textData': textData});

    setState(() {
      dataList.add({
        'key': newRef.key!,
        'text': textData,
      });
    });
  }

  //getData
  Future<void> getData() async {
    try {
      // Firebase から一度だけデータを取得
      DatabaseEvent event = await streamRef.once();
      DataSnapshot snapshot = event.snapshot;

      List<Map<String, String?>> tempList = [];

      // children をループして key と textData を取り出す
      for (var child in snapshot.children) {
        tempList.add({
          'key': child.key,
          'text': child.child('textData').value.toString(),
        });
      }

      // ローカルの dataList を更新して UI を再描画
      setState(() {
        dataList = tempList;
      });

      print("✅ データ取得成功: $dataList");
    } catch (e) {
      print("❌ データ取得失敗: $e");
    }
  }

  //deleteData
  Future<void> deleteData(int index) async {
  if (index < 0 || index >= dataList.length) {
    print("⚠️ index が範囲外です");
    return;
  }

  try {
    String? key = dataList[index]['key'];
    if (key != null) {
      await streamRef.child(key).remove(); // Firebase から削除
      setState(() {
        dataList.removeAt(index); // ローカルリストも削除
      });
      print("✅ 削除成功: $key");
    } else {
      print("⚠️ key が null です");
    }
  } catch (e) {
    print("❌ 削除失敗: $e");
  }
}


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
              
              //show Data
              Container(
                height: 400, width: 400,

                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Center(
                        child: Text(dataList[index]['text'] ?? ''),
                      ),
                      onTap: (){
                        deleteData(index);
                      }
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
                          textData = value;
                        },
                      ),
                    ),

                    IconButton(
                      onPressed: () async {
                        try {
                          await saveData(textData);
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