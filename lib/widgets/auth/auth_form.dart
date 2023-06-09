import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(
      this.submitFn,
      this.isLoading
      );

  final bool isLoading;
  final void Function(
      String email,
      String password,
      String userName,
      bool isLogin,

      ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail= '';
  String _userName='';
  String _userPassword='';
  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if(isValid!= null) {
       _formKey.currentState?.save();
        widget.submitFn(
         _userEmail.trim(),
         _userName.trim(),
         _userPassword.trim(),
         _isLogin,

       );

       //send my auth req..
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Card(margin: EdgeInsets.all(20),
              child: SingleChildScrollView
                (child: Padding(padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if(value!.isEmpty && value.contains('@') ){
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      onSaved: (value){
                        _userEmail = value!;
                      },
                    ),
                    if(!_isLogin)
                    TextFormField(
                      key: ValueKey('userName') ,
                      validator: (value) {
                         if(value!.isEmpty && value.length> 4){
                           return 'Please enter at least 4 characters';
                         }
                         return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value){
                        _userName = value!;
                      },
                    ),

                    TextFormField(
                      key: ValueKey('password') ,
                      validator: (value) {
                        if(value!.isEmpty || value.length < 7){
                          return 'Password must be at least 7 character long.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Password'),
                      onSaved: (value){
                        _userPassword = value!;
                      },
                    ),
                    SizedBox(height: 12),
                    if(widget.isLoading)
                      CircularProgressIndicator(),
                    if(!widget.isLoading)
                    ElevatedButton(onPressed: _trySubmit, child: Text(_isLogin ? 'Login' : 'SignUp ')),
                    if(!widget.isLoading)
                    TextButton(onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    }, child: Text(_isLogin ? 'Create new account' : 'I already have an account'),),
                  ],),),)),),
    );
  }
}

