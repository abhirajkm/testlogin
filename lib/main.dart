import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const MyHomePage(),
    );
  }

  ThemeData appTheme() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8f1b1c)),
      useMaterial3: true,
    );
  }
}
const primaryColor=Color(0xFF8f1b1c);
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {

    return    const Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            LoginBg(),
            Positioned(
                top: 50,right: 20,left: 20,
                child: LoginForm())
          ],
        ),
      )

    );
  }
}


class LoginBg extends StatelessWidget {
  const LoginBg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                color: primaryColor,
              )),
          Expanded(
            flex: 5,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                color: primaryColor,
                  height: 500,
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
            color: Colors.white,
            height: 300,
          ))
        ],
      ),
    );
  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 6, size.height/2.5, size.width, size.height/3);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,

  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.menu_outlined,size: 35,),
          ),
        ),
        const SizedBox(height: 60,),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(30),
          width: MediaQuery.of(context).size.width,
          decoration:  BoxDecoration(
            color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            borderRadius: BorderRadius.circular(30)
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Login to \nTeacher Portal",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                const SizedBox(height: 20,),
                CustomTextField(controller: emailController, hintText: "Enter email address", suffixIcon: Icons.perm_identity_rounded),
                const SizedBox(height: 20,),
                CustomTextField(controller: passwordController, hintText:"Password", suffixIcon: Icons.lock_outline,obscureText: true,),
                const SizedBox(height: 20,),
                 LoginButton(title: "Login",
                  onPressed: (){
                  if(_formKey.currentState!.validate()){
                    // todo if success route to next screen
                  }
                  },
                ),
                const SizedBox(height: 25,),
                const ForgotPasswordWidget(),
                const SizedBox(height: 50,)

              ],
            ),
          ),

        ),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData suffixIcon;
  const CustomTextField({
    super.key, required this.controller, required this.hintText, required this.suffixIcon, this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 12,left: 0),
          isDense: true,
        prefixIcon: Container(
            transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
            child:  Icon(suffixIcon,size: 25,)),
        hintText:hintText,
        hintStyle: const TextStyle(color: Colors.grey,)
      ),
    );
  }
}




class LoginButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  final double height;
  final double? width;
  const LoginButton({super.key, required this.title, this.onPressed, this.height=50.0, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 50,right: 30),
        decoration: BoxDecoration(
          color: Colors.black,
              borderRadius: BorderRadius.circular(30)
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 18),),
            Icon(Icons.arrow_forward,size: 20,color: Colors.white,)
          ],
        ),
      ),
    );


  }
}


class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});
  @override
  _ForgotPasswordWidgetState createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 20),
      child: TextButton(
          onPressed: () => setState(() => _value = !_value),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor: Colors.white
                      ),
                      child: Transform.scale(
                        scale: .75,
                        child: Checkbox(
                            side: const BorderSide(color: Colors.grey),
                            activeColor: Colors.black,

                            value: _value,
                            onChanged: (value){
                              setState(() => _value = value!);
                            }
                        ),
                      ),
                    )
                ),
                const SizedBox(width:10.0),
                const Text("Forgot Password",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.black),),
              ]
          )
      ),
    )


    /*Theme(
      data: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          unselectedWidgetColor: Colors.white
      ),
      child: CheckboxListTile(
        contentPadding: EdgeInsets.only(left: 10),
        activeColor: TextColor,
        title: Text(translate(context, text_u_acpt_our_terms_use),style: logText,),
        value: _value,
        onChanged: (value) {
          setState(() {
            _value = value!;
          });
        },
        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
      ),
    )*/



    /*Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: TextColor),
            left: BorderSide(width: 1.0, color: TextColor),
            right: BorderSide(width: 1.0, color: TextColor),
            bottom: BorderSide(width: 1.0, color:TextColor),
          ),
        ),
        child: Checkbox(
          activeColor: TextColor,
          value: _value,
          onChanged: (value) {
            setState(() {
              _value = value!;
            });
          },
        ),
        width: 15,
        height: 15)*/;


  }
}