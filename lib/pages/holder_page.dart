import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AuthFlowBuilderLoginScreen extends HookWidget {
  const AuthFlowBuilderLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = useTextEditingController();
    final passwordCtrl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple implementation'),
      ),
      body: AuthFlowBuilder<EmailAuthController>(
        auth: FirebaseAuth.instance,
        action: AuthAction.signIn,
        listener: (oldState, newState, ctrl) {
          if (newState is SignedIn) {
            Navigator.of(context).pushReplacementNamed('/profile');
          }
        },
        builder: (context, state, ctrl, child) {
          if (state is AwaitingEmailAndPassword) {
            return Column(children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailCtrl,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordCtrl,
                onSubmitted: (value) {
                  ctrl.setEmailAndPassword(emailCtrl.text, passwordCtrl.text);
                },
              ),
              OutlinedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    ctrl.setEmailAndPassword(emailCtrl.text, passwordCtrl.text);
                  }),
            ]);
          } else if (state is SigningIn || state is SignedIn) {
            return const CircularProgressIndicator();
          } else if (state is AuthFailed) {
            return ErrorText(exception: state.exception);
          } else {
            return Text('Unknown state $state');
          }
        },
      ),
    );
  }
}
