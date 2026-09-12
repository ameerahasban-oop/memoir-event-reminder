import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  final Function(String) onLogin;

  const LoginPage({
    super.key,
    required this.onLogin,
  });

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {

  TextEditingController nameController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  Future<void> loginUser() async {

    final prefs =
    await SharedPreferences.getInstance();

    List<String> users =
        prefs.getStringList('users') ?? [];

    String enteredUsername =
        nameController.text;

    String enteredPassword =
        passwordController.text;

    bool loginSuccess = false;

    for (String user in users) {

      List<String> parts =
      user.split('|');

      String savedUsername =
      parts[0];

      String savedPassword =
      parts[1];

      if (enteredUsername ==
          savedUsername &&
          enteredPassword ==
              savedPassword) {

        loginSuccess = true;

        await prefs.setString(
          'currentUser',
          enteredUsername,
        );

        widget.onLogin(
          enteredUsername,
        );

        break;
      }
    }

    if (loginSuccess) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Login Successful",
          ),
        ),
      );

      Navigator.pop(context);

    } else {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Invalid Username or Password",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.pink[50],

      appBar: AppBar(
        title: const Text(
          "Login",
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Icon(
              Icons.lock_person,
              size: 90,
              color: Colors.brown,
            ),

            const SizedBox(height: 10),

            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Login to continue using Memoir",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            Card(

              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(

                padding: const EdgeInsets.all(20),

                child: Column(

                  children: [

                    TextField(

                      controller: nameController,

                      decoration: InputDecoration(

                        labelText: "Username",

                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.brown,
                        ),

                        filled: true,
                        fillColor: Colors.pink[50],

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(

                      controller: passwordController,

                      obscureText: true,

                      decoration: InputDecoration(

                        labelText: "Password",

                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.brown,
                        ),

                        filled: true,
                        fillColor: Colors.pink[50],

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton(

                        style: ElevatedButton.styleFrom(

                          backgroundColor: Colors.brown,
                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(15),
                          ),
                        ),

                        onPressed: loginUser,

                        child: const Text(

                          "Login",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}