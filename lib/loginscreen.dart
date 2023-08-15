import 'package:flutter/material.dart';
import 'package:letschat/HomeScreen.dart';
import 'package:letschat/Methods.dart';
import 'package:letschat/createaccount.dart';

class OldLoginScreen extends StatefulWidget {
  const OldLoginScreen({Key? key}) : super(key: key);

  @override
  State<OldLoginScreen> createState() => _OldLoginScreenState();
}

class _OldLoginScreenState extends State<OldLoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isloading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: size.height / 20),
                  Container(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.arrow_back_ios))),

                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Sign In to continue!',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 20),
                  field(size, 'email', Icons.account_box, _email),
                  SizedBox(height: size.height / 50),
                  field(size, 'Password', Icons.lock, _password),
                  SizedBox(height: size.height / 20),
                  // ElevatedButton(onPressed: (){}, child: Text('Log In ')),
                  customButton(size),
                  SizedBox(height: size.height / 20),
                  Text(
                    'Dont have an account!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: size.height / 60),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CreateAccount())),
                    child: Text(
                      'Create Account',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget field(
      Size size, String HintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 15,
      width: size.width / 1.2,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: HintText,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }

  Widget customButton(
    Size size,
  ) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isloading = true;
          });
          LogIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Successful");
              setState(() {
                isloading = false;
              });
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => HomeScreen()));
            } else {
              setState(() {
                isloading = false;
              });

              print("Login Failed");
            }
          });
        }
      },
      child: Container(
        // color: Colors.blue,

        height: size.height / 15,
        width: size.width / 1.4,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Log In',
          style: TextStyle(
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
