import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Addtodo.dart';
import 'package:todo_app/Viewdata.dart';
import 'package:todo_app/Services/auth_service.dart';
import 'package:todo_app/Todocard.dart';
import 'package:get/get.dart';
import 'package:todo_app/profilepage.dart';

class Home extends StatefulWidget {
  Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth authclass = Auth();
  bool check = false;
  final Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Today's Schedule",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 34,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/vasu.JPG'),
          ),
          SizedBox(
            width: 25,
            // height: 25,
          )
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Monday 21',
                    style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.w600,
                      fontSize: 33,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var instance =
                          FirebaseFirestore.instance.collection('Todo');
                      for (int i = 0; i <= selected.length; i++) {
                        instance.doc().delete();
                      }
                    },
                    icon: Icon(Icons.delete, color: Colors.red, size: 28),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              height: 52,
              width: 52,
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 32,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              height: 52,
              width: 52,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ],
                  )),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => Addtodo(),
                    ),
                  );
                },
                child: Container(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
            label: 'add',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Get.to(() => Profilepage());
              },
              child: Container(
                child: Icon(
                  Icons.settings,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
            label: 'Setting',
          ),
        ],
      ),
      body: StreamBuilder(
        stream: stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              IconData iconData;
              Color iconcolor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;

              switch (document['category']) {
                case "Work":
                  iconData = Icons.run_circle_outlined;
                  iconcolor = Colors.red;
                  break;

                case "WorkOut":
                  iconData = Icons.alarm;
                  iconcolor = Colors.teal;
                  break;

                case "Food":
                  iconData = Icons.local_grocery_store;
                  iconcolor = Colors.blue;
                  break;

                case "Design":
                  iconData = Icons.audiotrack;
                  iconcolor = Colors.green;
                  break;

                default:
                  iconData = Icons.run_circle_outlined;
                  iconcolor = Colors.red;
              }

              selected.add(
                  Select(id: snapshot.data!.docs[index].id, checkvalue: false));
              return InkWell(
                onTap: () {
                  Get.to(() => Viewdata(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ));
                },
                child: Todocard(
                  title: document['title'] == null
                      ? "Hey there"
                      : document['title'],
                  ischeck: selected[index].checkvalue,
                  iconbgcolor: Colors.white,
                  iconcolor: iconcolor,
                  iconData: iconData,
                  index: index,
                  time: "10 AM",
                  onchange: onchange,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onchange(int index) {
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue;
    });
  }
}

class Select {
  String? id;
  bool checkvalue = false;
  Select({this.id, required this.checkvalue});
}
