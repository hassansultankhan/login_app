import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_fonts/google_fonts.dart';
class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 40,
              child:ElevatedButton(      
                          onPressed:() => fireLogin(),
                          child:  const Row(
                            mainAxisAlignment: MainAxisAlignment.center, 
                            children:[
                              Text('Login'),
                              Icon(Icons.login)  
                            ]
                          ),           
                          ),
            ),

          ],
        )
      ),
    );
  }
  void fireLogin()async{
    // create code for loging into firebase authentication
    try {
      // GoogleSignIn allows you to authenticate Google users.
      final GoogleSignIn googleSignIn = GoogleSignIn();
      // Holds fields describing a signed in user's identity
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount != null){
        // Holds authentication tokens after sign in.
        final GoogleSignInAuthentication  googleAuth = await googleSignInAccount.authentication;
      
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null){
          print("User Signed in : ${user.displayName}");
        }
        else{
          print('Sign in failed');
        }
      }
      else{
        print('Google sign-in canceled.');
      }
    }
    catch(e){print('error signing in: $e');}
  }
}