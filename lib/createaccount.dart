import 'package:flutter/material.dart';
import 'package:letschat/Methods.dart';
import 'package:letschat/loginscreen.dart';

import 'HomeScreen.dart';
class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool  isloading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:isloading? Center(child: Container(height: size.height/20,width: size.width/20,child: CircularProgressIndicator(),),):SingleChildScrollView(
       child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:[

        SizedBox( height: size.height/20,),
    Container(
    alignment: Alignment.topLeft,
    child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios))),

    Container(
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.topLeft,
    child: Text( 'Welcome',
    style: TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    Container(
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.topLeft,
    child: Text( 'Create Acoount to continue!',
    style: TextStyle(
    fontSize: 20,
    color: Colors.grey,
    fontWeight: FontWeight.w500,
    ),
    ),
    ),
    SizedBox( height: 50,),
    field(size, 'Name',Icons.person, _name),
    SizedBox( height: 20,),
    field(size, 'email',Icons.account_box , _email),
    SizedBox( height: 20,),
    field(size, 'Password',Icons.lock , _password),
    SizedBox( height: 50,),
    // ElevatedButton(onPressed: (){}, child: Text('Log In ')),
    customButton(size),
          SizedBox( height: 20,),
          GestureDetector(
            onTap: () => Navigator.pop(context) ,
            child: Text('Log In' ,style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),),
          )


    ],
    ),
      ),
    );
  }

  Widget field ( Size size, String HintText, IconData icon, TextEditingController cont){
    return Container(
      height: size.height/15,
      width: size.width/1.2,
      child:TextField (
        controller: cont ,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: HintText,
            hintStyle: TextStyle( color: Colors.grey,fontSize: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
      ),
    );

  }
  Widget customButton(Size size,){
    return GestureDetector(
      onTap: (){
        if( _name.text.isNotEmpty && _password.text.isNotEmpty && _email.text.isNotEmpty){
          setState(() {
            isloading = true;
          });
          createAccount( _name.text, _email.text, _password.text).then((user) {
            if(user != null){
              print("Account Created Successfully");
              setState(() {
                isloading = false;
              });

              Navigator.push(context, MaterialPageRoute(builder:(_) => HomeScreen() ));



            }else {
              print("some error occoured");
              setState(() {
                isloading = false;
              });
            }
          });
        };
      },
      child: Container(
        // color: Colors.blue,

        height: size.height/15,
        width: size.width/1.3,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child:Text ( 'Create Account' , style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,

        ),
        ),
        alignment: Alignment.center,
      ),
    );
  }
}



