import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

// PRESENTATION LAYER

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyText2: TextStyle(fontSize: 40.0),
        ),
      ),
      home: const Scaffold(
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GraphInfo> list = [];
  bool isloading = false;

  @override
  void initState() {
    // func addToSP menambahkan list graph , kemudian return get SP
    // addToSP(defaultList).then((_) => getSP());
    addToSP(defaultList);
    // getSP();
    getSPdata();
    // print(list);
    super.initState();
  }

  Future<void> addToSP(List<GraphInfo> tList) async {
    // initial
    final prefs = await SharedPreferences.getInstance();
    // set string menyimpan ke prefs
    prefs.setString('graphLists', jsonEncode(tList));
  }

  Future<List<GraphInfo>> getSP() async {
    final prefs = await SharedPreferences.getInstance();
    final List jsonData = jsonDecode(prefs.getString('graphLists') ?? '[]');
    final data = jsonData.map((e) => GraphInfo.fromJson(e)).toList();
    setState(() {
      // print(l);
      // print(list);
    });
    return data;
  }

  Future getSPdata() async{
    isloading = true;
    final spList = await getSP();
    list = spList;
    print(list);
    isloading = false;
  }

  // void getSP() async {
  //   // initial
  //   final prefs = await SharedPreferences.getInstance();
  //   // initial jsonData[] = diambil dari decode get shared prefs
  //   final List jsonData =
  //       jsonDecode(prefs.getString('graphLists') ?? '[]');

  //   list = return GrapInfo.fromJson
  //   // list = jsonData.map<List<GraphInfo>>((jsonList) {
  //   //   return jsonList.map<GraphInfo>((jsonItem) {
  //   //     return GraphInfo.fromJson(jsonItem);
  //   //   }).toList();
  //   // }).toList();

  //   setState(() {
  //     print(list);
  //     print('ini printttttttttttt');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? Center(
            child: SingleChildScrollView(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: 
                list.map((subList) {
                  return Expanded(
                    child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children:[
                              Text('data ${subList.xAxis}')
                            ] 
                          ),
                  );
                      
                }).toList(),
              ),
            ),
          )
        : const Text('NOTHING');
        // [
              //   ListView.builder(
              //     itemCount: list.length,
              //     itemBuilder: ((context, index) {
              //       return Container(
              //         child: Center(
              //           child: Text('data ${list[index]}',
              //           ),
                      
              //         ),
                      
                      
              //       );
                    
              //     })
                  
              //   )
                
              // ]
  }
}

// MODEL

class GraphInfo {
  int? id;
  String title;
  String xAxis;
  String yAxis;

  GraphInfo({
    this.id,
    required this.title,
    required this.xAxis,
    required this.yAxis,
  });

  factory GraphInfo.fromJson(Map<String, dynamic> json) {
    return GraphInfo(
        id: json["id"],
        title: json["title"],
        xAxis: json["xAxis"],
        yAxis: json["yAxis"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "xAxis": xAxis,
      "yAxis": yAxis,
    };
  }

  @override
  String toString() => '{name: $title, x: $xAxis, y: $yAxis}';
}

// DATA

final List<GraphInfo> defaultList = [
  
    GraphInfo(title: 'Graph 1', xAxis: "10", yAxis: "15"),
    GraphInfo(title: 'Graph 1.2', xAxis: "15", yAxis: "20"),
  
  
];