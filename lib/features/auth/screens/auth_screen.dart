import 'package:amazon_clone/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/constants/variables.dart';
import 'package:amazon_clone/common/widget/custom_textfield.dart';
import 'package:amazon_clone/common/widget/custom_button.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFromKey = GlobalKey<FormState>();
  final _signInFromKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Variables.greyBackgroundCOlor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'welcome',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? Variables.backgroundColor
                    : Variables.greyBackgroundCOlor,
                title: const Text(
                  'create account',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signup,
                  activeColor: Variables.secondaryColor,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Variables.backgroundColor,
                  child: Form(
                    key: _signUpFromKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: 'name',
                        ),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'password',
                        ),
                        CustomButtton(
                          text: 'sign-up',
                          onTap: () {
                            if(_signUpFromKey.currentState!.validate())
                            {
                              signUpUser();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ListTile(
                //TODO encapsulate this repeated listtitle and container
                tileColor: _auth == Auth.signin
                    ? Variables.backgroundColor
                    : Variables.greyBackgroundCOlor,
                title: const Text(
                  'sign-in',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio(
                  value: Auth.signin,
                  activeColor: Variables.secondaryColor,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Variables.backgroundColor,
                  child: Form(
                    key: _signInFromKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Email',
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'password',
                        ),
                        CustomButtton(
                          text: 'sign-in',
                          onTap: () {
                            if(_signInFromKey.currentState!.validate())
                            {
                              signInUser();
                            }
                          },
                        ),
                      ],
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
