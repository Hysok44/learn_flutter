import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RealtimePage extends StatefulWidget {

  @override
  State<RealtimePage> createState() => _RealtimePageState();
}

class _RealtimePageState extends State<RealtimePage>{
  final streamRef = FirebaseDatabase.instance.ref('test_realtime');

  String textData = "";
  List<String> dataList = [];


  //表示されたときにまずここ
  @override
  void initState() {
    super.initState();

    getData();
  }

  //saveData
  Future<void> saveData(textData) async {
    await streamRef.child('text_data').set({
      'textData': textData,
    });
  }

  //getData
  Future<void> getData() async {
    streamRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;

      setState(() {
        dataList = []; // 前のデータをクリアして全体を更新する場合
        if (data != null) {
          final mapData = Map<String, dynamic>.from(data as Map);
          dataList = mapData.entries.map((e) {
            final item = e.value;
            if (item is Map && item["textData"] != null) {
              return item["textData"].toString();
            } else {
              return item.toString();
            }
          }).toList();
        }
      });

      print(dataList);
    });
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
                color: Colors.grey,

                child: ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Center(child: Text(dataList[index])),
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