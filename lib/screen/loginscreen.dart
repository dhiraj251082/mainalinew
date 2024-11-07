import 'package:flutter/material.dart';
import 'package:mainalihr/core/route/app_route_name.dart';
import 'package:mainalihr/model/UserCredentials.dart';
import 'package:mainalihr/utility/LoginUtil.dart';

class loginscreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  loginscreen({super.key});

  Future<void> _login(BuildContext context) async {
    // Extract username and password from the text controllers
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Validate if username is an email and password is provided
    if (!LoginUtil.isEmail(username)) {
      LoginUtil.showMessage(context, 'Username must be an email address.');
      return;
    }
    if (password.isEmpty) {
      LoginUtil.showMessage(context, 'Please provide a password.');
      return;
    }

    // Create UserCredentials object
    UserCredentials credentials = UserCredentials(
      username: username,
      password: password,
    );

    // Call login function from LoginUtil
    await LoginUtil.login(context, credentials);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.shade50,
                AppColor.shade100,
                AppColor.shade200,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/logo.jpg'),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _usernameController,
                                    style: const TextStyle(color: Color.fromARGB(255, 26, 1, 1), fontSize: 20),
                                    decoration: const InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: TextStyle(color: Color.fromARGB(255, 18, 1, 1)),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                      prefixIcon: Icon(Icons.person), // Icon for username
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.black, fontSize: 20),
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                      prefixIcon: Icon(Icons.lock), // Icon for password
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ElevatedButton.icon(
                                    onPressed: () => _login(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue.shade800,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    ),
                                    icon: const Icon(
                                      Icons.login,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    label: const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Sign Up For New User',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(context, AppRouteName.clientNavigation);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.work),
                                label: Text(
                                  'Employer',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 18),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(                               
                                 onPressed: () {
                                  Navigator.pushReplacementNamed(context, AppRouteName.registerPage);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                ),
                                icon: const Icon(Icons.search),
                                label: Text(
                                  'Job seeker',
                                  style: TextStyle(color: Colors.blue.shade800, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppColor {
  static Color shade50 = const Color(0xFFacdde2);
  static Color shade100 = const Color(0xFF9bd6dc);
  static Color shade200 = const Color(0xFF8acfd6);
}

                               
