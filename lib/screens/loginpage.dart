import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendomesdelivery/screens/signuppage.dart';

import '../services/routingpage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  AnimationController? _controller;
  Animation<double>? _animation;

  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller!.forward();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF000000),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Color(0xFF000000),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(22),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(1.0),
                            child: FadeTransition(
                              opacity: _animation!,
                              child: Image.asset(
                                "assets/images/applogo.png",
                                height: 300,
                                width: 250,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: emailController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.email,
                                    color: Color(0xFFdb9e1f),
                                  ),
                                  onPressed: () {}),
                              hintText: "Enter your email",
                              labelText: "Email",
                              hintStyle: TextStyle(color: Colors.white70),
                              labelStyle: new TextStyle(color: Colors.white70),
                              enabled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Color(0xFFdb9e1f)),
                              ),
                            ),
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              emailController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: passwordController,
                            obscureText: _isObscure3,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure3
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Color(0xFFdb9e1f),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure3 = !_isObscure3;
                                    });
                                  }),
                              hintText: "Enter your password",
                              labelText: "Password",
                              hintStyle: TextStyle(color: Colors.white70),
                              labelStyle: new TextStyle(color: Colors.white70),
                              enabled: true,
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white70),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Color(0xFFdb9e1f)),
                              ),
                            ),
                            validator: (value) {
                              RegExp regex = new RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("please enter valid password min. 6 character");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              passwordController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  side: BorderSide(color: Color(0xFFdb9e1f))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //     // TaskCardWidget(id: user.id, name: user.ingredients,)
                                //     UserHomePage(
                                //
                                //
                                //     )));

                                signIn(emailController.text,
                                    passwordController.text);
                                setState(() {
                                  visible = true;
                                });
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFFdb9e1f),
                                ),
                              ),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    //should redirect to sign up page!
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) =>
                                            // TaskCardWidget(id: user.id, name: user.ingredients,)
                                            SignUpPage()));
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(color: Color(0xFFdb9e1f)),
                                  ),
                                ),
                              ],
                            ),
                          )
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

  //signing method
  void signIn(String email, String password) async {
    //checking the username and password entered
    if (_formkey.currentState!.validate()) {
      //if valid this code block will run
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RoutePage(),
          ),
        );
        print("Logged in Successfully with ${email} and $password");
      }
      //if invalid catch the error
      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 20),
                Expanded(child: Text('No user found for that email.')),
              ],
            ),
          ));
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: const [
                Icon(
                  Icons.error_outline,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 20),
                Expanded(child: Text('Wrong password provided for that user.')),
              ],
            ),
          ));
        }
      }
    }
  }

  @override
  dispose() {
    _controller!.dispose(); // you need this
    super.dispose();
  }
}
