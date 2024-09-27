import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:trainingcourt/screens/home_screen.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (SupaEmailAuth(
      redirectTo: null,
      onSignInComplete: (response) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      onSignUpComplete: (response) {},
    ));
  }
}
