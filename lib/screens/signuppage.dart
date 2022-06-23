import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController confirmpasswordController =
      new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController numberController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final auth = FirebaseAuth.instance;

  void signUp(String name, String email, String username, String contactNumber,
      String password) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) =>
              {postDetailsToFirestore(name, email, username, contactNumber)})
          .catchError((e) {});
    }
  }

  //add the user details to the database (method)
  postDetailsToFirestore(
      String name, String email, String username, String contactNumber) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    var uid = user!.uid;

    await firebaseFirestore.collection("users").doc(user.uid).set({
      'uid': user.uid,
      'role': 'customer',
      'name': name,
      'email': email,
      'username': username,
      'contactnumber': contactNumber,
    });
  }

  AnimationController? _controller;
  Animation<double>? _animation;

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
                                "assets/images/logo.jpeg",
                                height: 300,
                                width: 250,
                              ),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: nameController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.account_circle_sharp,
                                    color: Color(0xFFdb9e1f),
                                  ),
                                  onPressed: () {}),
                              hintText: "Enter your name",
                              labelText: "Name",
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
                                return "Name cannot be empty";
                              }
                            },
                            onSaved: (value) {
                              nameController.text = value!;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
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
                            controller: usernameController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Color(0xFFdb9e1f),
                                  ),
                                  onPressed: () {}),
                              hintText: "Enter your username",
                              labelText: "Username",
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
                                return "Username cannot be empty";
                              }
                            },
                            onSaved: (value) {
                              usernameController.text = value!;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: numberController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.local_phone_rounded,
                                    color: Color(0xFFdb9e1f),
                                  ),
                                  onPressed: () {}),
                              hintText: "Enter your contact number",
                              labelText: "Contact Number",
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
                            height: 20,
                          ),
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: confirmpasswordController,
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
                              hintText: "Enter your password again",
                              labelText: "Confirm Password",
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
                                setState(() {
                                  visible = true;
                                });
                                signUp(
                                    nameController.text,
                                    emailController.text,
                                    usernameController.text,
                                    numberController.text,
                                    confirmpasswordController.text);
                                /*auth
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password:
                                            confirmpasswordController.text)
                                    .then((value) => {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .add({
                                                'name': nameController.text,
                                                'email': emailController.text,
                                                'username':
                                                    usernameController.text,
                                                'contactnumber':
                                                    numberController.text,
                                              })
                                              .then((value) =>
                                                  print("User Added"))
                                              .catchError((error) => print(
                                                  "Failed to add user: $error"))
                                        });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserHomePage()));*/
                                //should redirect to otp page!
                                /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OTPVerification(
                                        nameController.text,
                                        emailController.text,
                                        usernameController.text,
                                        numberController.text,
                                        confirmpasswordController.text)));*/
                              },
                              child: Text(
                                "Sign up",
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
                                  "Have an account already? ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                InkWell(
                                  onTap: () {
                                    //should redirect to sign up page!
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
                                  },
                                  child: Text(
                                    "Login",
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
}
