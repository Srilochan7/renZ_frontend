import 'package:culture/logic/services/auth_service.dart';
import 'package:culture/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sizer/sizer.dart';
import 'package:culture/presentation/Screens/home.dart';
import 'package:culture/presentation/auth/signuup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 25.h,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/login_img.jpeg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "LOGIN",
                        style: GoogleFonts.delaGothicOne(
                          color: const Color.fromARGB(255, 199, 199, 199),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w200
                        ),
                      ),
                      Text(
                        "CULTURE IS CALLING",
                        style: GoogleFonts.delaGothicOne(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w200
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Access your streetwear community and stay up to date with the latest trends.",
                        style: GoogleFonts.zenDots(
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 3.h),
                      _buildTextField(_emailController, "Email", false),
                      SizedBox(height: 2.h),
                      _buildTextField(_passwordController, "Password", true),
                      SizedBox(height: 4.h),
                      _isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.white))
                          : SizedBox(
                              width: 100.w,
                              height: 6.h,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3D3D3B),
                                ),
                                onPressed: () async {
                                  bool loginResult = await AuthService().userLogin(email: _emailController.text, password: _passwordController.text);
                                  
                                  if(loginResult){
                                     Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => Mainscreen()),
                                (route) => false,  // This removes all previous routes
                              );
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style: GoogleFonts.delaGothicOne(
                                    color: Colors.white,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w200
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.poppins(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontSize: 15.sp,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, PageTransition(type: PageTransitionType.leftToRight, child: SignUpPage()));
                            },
                            child: Text(
                              "Register",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isPassword) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white, fontSize: 15.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70, fontSize: 12.sp),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color.fromARGB(77, 172, 172, 172)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (label == "Email" && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }
}
