import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ChatRoom extends StatelessWidget {
   final  Map<String , dynamic>userMap ;
   final  String chatRoomid ;
   ChatRoom({required this.chatRoomid , required this.userMap});
  final TextEditingController _message = TextEditingController();
     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;
    void onSendMessage() async{
     if( _message.text.isNotEmpty){
       Map<String ,dynamic> messages = {
         "sendby" : _auth.currentUser!.displayName,
         "message" : _message.text,
         "time" : FieldValue.serverTimestamp(),

       };
       await _firestore.collection('chatroom').doc(chatRoomid).collection('chats').add(messages);
       _message.clear();
     } else print("Enter some text");
    }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(userMap['name']),

      ),
      body: SingleChildScrollView(
        child : Column(
          children: [
            Container(
              height: size.height/1.25,
              width: size.width,
              child: StreamBuilder<QuerySnapshot >(
                stream: _firestore.collection('chatroom').doc(chatRoomid).collection('chats').orderBy('time' , descending: false).snapshots(),
            builder: ( BuildContext context , AsyncSnapshot<QuerySnapshot > snapshot){
                  if(snapshot.data != null ){
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context , index) {
                          Map <String , dynamic> map = snapshot.data!.docs[index].data()  as Map<String , dynamic>;
                          return messages(size, map);
                        });
                  }
                  else return Container();
                },
              ),
            ),
            Container(
              height: size.height/12,
              width: size.width,
              child : Container(
                height: size.height/15,
                width: size.width/1.13,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height/17,
                      width: size.width/1.3,
                      child :TextField(
                        controller: _message,
                        decoration: InputDecoration(
                          hintText: 'Type here...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    IconButton(onPressed: onSendMessage, icon: Icon(Icons.send , color: Colors.blue,)),

                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
    Widget messages(Size size , Map<String , dynamic> map){
      return Container(
        width: size.width,
        alignment: map['sendby']== _auth.currentUser!.displayName ? Alignment.centerRight: Alignment.centerLeft ,
        child: Container(
          padding: EdgeInsets.symmetric( vertical: 5 ,horizontal:12 ),
          margin:  EdgeInsets.symmetric( vertical: 5 ,horizontal: 14 ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            color: Colors.blue,
          ),
          child: Text(
            map['message'] , style: TextStyle(
            color: Colors.white,
            fontSize: 18,
              fontWeight: FontWeight.w400,


          ),
          ),
        ),
      );
    }
}
