import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (SupaEmailAuth(
      redirectTo: null,
      onSignInComplete: (response) {},
      onSignUpComplete: (response) {},
    ));
  }
}
