import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {

  final Function(String) onRegister;

  const RegisterPage({
    super.key,
    required this.onRegister,
  });

  @override
  State<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends State<RegisterPage> {

  TextEditingController nameController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  Future<void> registerUser() async {

    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please fill all fields",
          ),
        ),
      );
      return;
    }

    final prefs =
    await SharedPreferences.getInstance();

    List<String> users =
        prefs.getStringList('users') ?? [];

    bool userExists = users.any(
          (user) =>
      user.split('|')[0] ==
          nameController.text,
    );

    if (userExists) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Username already exists",
          ),
        ),
      );

      return;
    }

    users.add(
      "${nameController.text}|${passwordController.text}",
    );

    await prefs.setStringList(
      'users',
      users,
    );

    await prefs.setString(
      'currentUser',
      nameController.text,
    );

    widget.onRegister(
      nameController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Registration Successful",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text(
          "Register",
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),

        child: Column(

          children: [
            const Icon(
              Icons.person_add,
              size: 90,
              color: Colors.brown,
            ),
            const SizedBox(
              height: 10,
            ),

            const Text(
              "Create Username",
              style: TextStyle(
                fontSize: 24,
                fontWeight:
                FontWeight.bold,
                color: Colors.brown,
              ),
            ),

            const SizedBox(
              height: 5,
            ),

            const Text(
              "Register your username to personalize your app",
              textAlign:
              TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Card(
              elevation: 5,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    20),
              ),

              child: Padding(

                padding:
                const EdgeInsets.all(
                    20),

                child: Column(

                  children: [
                    TextField(
                      controller:
                      nameController,
                      decoration:
                      InputDecoration(
                        labelText:
                        "Enter Username",
                        prefixIcon:
                        const Icon(
                          Icons.person,
                        ),
                        filled: true,
                        fillColor:
                        Colors
                            .pink[50],
                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                        filled: true,
                        fillColor: Colors.pink[50],
                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width:
                      double.infinity,
                      child:
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.brown,
                          foregroundColor:
                          Colors.white,
                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                15),
                          ),
                        ),

                        onPressed: registerUser,

                        child:
                        const Text(
                          "Register",
                          style:
                          TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
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