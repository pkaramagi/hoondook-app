import 'package:flutter/material.dart';
import 'package:hoondok/homepage.dart';
import 'package:hoondok/helpers/slide.helper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hoondok/install.dart';
import 'package:hoondok/models/category.dart';

import 'bloc/category_bloc.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: LoginWidget(),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.nanumGothicCodingTextTheme(Theme
            .of(context)
            .textTheme,),
        buttonColor: Color(0xffE56A6A), // this is needed
        accentColor: Color(0xffE56A6A),
      ),
    );
  }
}

class LoginWidget extends StatefulWidget{

  @override
  LoginWidgetState createState() => LoginWidgetState();
  
}


class LoginWidgetState extends State<LoginWidget>{
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;

  bool isUserSignedIn = false;
  @override
  void initState(){
    super.initState();
    initApp();
  }

  void initApp() async{

    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();

  }


  void checkIfUserIsSignedIn() async{
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            padding: EdgeInsets.all(50),
            child: Align(
                alignment: Alignment.center,
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      onGoogleSignIn(context);
                    },
                    color: isUserSignedIn ? Colors.green : Colors.blueAccent,
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.account_circle, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                                isUserSignedIn ? 'You\'re logged in with Google' : 'Login with Google',
                                style: TextStyle(color: Colors.white))
                          ],
                        )
                    )
                )
            )
        )
    );
  }


  Future<User> _handleSignIn() async{
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if(userSignedIn){
      user = _auth.currentUser;
    }
    else{
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });

    }
    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();
    var userSignedIn = await Navigator.push(
      context,
      SlideLeftRoute(page:HomePage()),
    );
    setState(() {
      isUserSignedIn = userSignedIn == null ? true:false;
    });
  }

}
