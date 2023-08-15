import 'package:flutter/material.dart';
import 'package:letschat/createaccount.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isloading = false;
    Widget button() {
      return Container(
        height: 65,
        width: 360,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "LOG IN",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: Colors.white, fontSize: 22),
          ),
        ),
      );
    }

    Widget textfield(String hintText, TextEditingController controller) {
      return Padding(
        padding: const EdgeInsets.all(22.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:
                const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            fillColor: Colors.grey[100],
            filled: true,
          ),
        ),
      );
    }

    Widget Tile(String imageAsset) {
      return InkWell(
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Demo button"),
        )),
        child: Container(
            padding: const EdgeInsets.all(10),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.cover,
            )),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: isloading
          ? Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Login In ",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                textfield("EMAIL", _email),
                textfield("USERNAME", _password),
                const SizedBox(
                  height: 30,
                ),
                button(),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: double.tryParse('2'),
                      ),
                    ),
                    const Text(
                      "Or continue with",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: double.tryParse('2'),
                    )),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    Tile('assets/search.png'),
                    const SizedBox(
                      width: 70,
                    ),
                    Tile("assets/apple.png")
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                    ),
                    const Text("Did not have any account? "),
                    TextButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => const CreateAccount())),
                        child: const Text("REGISTER")),
                  ],
                ),
              ],
            ),
    );
  }
}
