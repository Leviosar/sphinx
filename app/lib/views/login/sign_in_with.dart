import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../controllers/user_bloc.dart';
import '../../models/user.dart';
import '../../widgets/animated_button.dart';
import '../../widgets/spaced_column.dart';
import '../home/home_page.dart';

class SignInWith extends StatefulWidget {
  @override
  _SignInWithState createState() => _SignInWithState();
}

class _SignInWithState extends State<SignInWith> with TickerProviderStateMixin {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      'https://www.googleapis.com/auth/userinfo.profile'
    ],
  );

  Future<void> _handleGoogleSignIn() async {
    try {
      GoogleSignInAccount account = await _googleSignIn.signIn();
      User user = User(id: account.id, email: account.email, photo: account.photoUrl, name: account.displayName);
      BlocProvider.getBloc<UserBloc>().user = user;
      await BlocProvider.getBloc<UserBloc>().auth();
    
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    } catch (error) {
      print(error);
    }
  }

  AnimationController googleAnimationController;
  AnimationController githubAnimationController;

  @override
  void initState() {
    this.googleAnimationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 350),
    );

    this.googleAnimationController.value = 1.0;

    this.githubAnimationController = AnimationController(
      vsync: this, 
      duration: Duration(milliseconds: 350),
    );

    this.githubAnimationController.value = 1.0;

    super.initState();
  }

  @override
  void dispose() {
    this.googleAnimationController.dispose();
    this.githubAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedButton(
          child: Icon(FontAwesomeIcons.google, color: Colors.white),
          onPressed: () {
            if (this.googleAnimationController.value == 1.0) {
              this.googleAnimationController.reverse();
              Future.delayed(Duration(milliseconds: 350), this._handleGoogleSignIn);
            }
          },
          width: this.googleAnimationController,
        ),
      ],
    );
  }
}