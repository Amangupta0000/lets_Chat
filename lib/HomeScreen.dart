import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letschat/Chatroom.dart';
import 'package:letschat/Methods.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   Map<String , dynamic>? userMap;
 final FirebaseAuth _auth = FirebaseAuth.instance ;
  bool isloading = false;

  final TextEditingController _search = TextEditingController();
  // String chatRoomId(String user1 , String user2 ){
  //   if(user1[0].toLowerCase().codeUnits[0]> user2[0].toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   }
  //   else return "$user2$user1";
  // }
   String chatRoomId(String user1, String user2) {
     var result = user1.compareTo(user2);
     if (result > 0) {
       return "$user1$user2";
     } else {
       return "$user2$user1";
     }
   }
  void onSearch () async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isloading = true;
    });
    await _firestore.collection('users').where("email", isEqualTo: _search.text ).get().then((value) {
      setState(() {
        userMap = value.docs[0].data();
        setState(() {
          isloading = false;
        });
        print(userMap);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        actions: [
          IconButton(onPressed:() => LogOut(context), icon: Icon(Icons.logout))
        ],
      ),
      body: isloading ? Center(
        child: Container(height: size.height/20,
          width: size.width/20,child: CircularProgressIndicator(), ),
      ) : Column(
        children: [
          SizedBox(height: size.height/20,),
          Container(
            height: size.height/14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height/14,
              width: size.width/1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

          ),
          SizedBox(height: size.height/40,),
          ElevatedButton(onPressed: onSearch, child: Text("Search")),
      SizedBox(height: size.height/20,),
      userMap != null ? ListTile(
        onTap:() {
          String roomId = chatRoomId( _auth.currentUser!.displayName!, userMap!['name']);
          Navigator.of(context).push( MaterialPageRoute(builder: (_) => ChatRoom(
            chatRoomid: roomId,
            userMap: userMap!,
          )));},
        leading: Icon(Icons.account_box, color: Colors.blue,),
        title: Text( userMap!['name'],style: TextStyle(
          fontWeight: FontWeight.w500,fontSize: 16
        ),),
        subtitle: Text( userMap!['email']),
        trailing: Icon(Icons.chat,color: Colors.blue,),
          ): Container(),
        ],
      ),
    );



  }
}
