import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_booking_app/pages/forget_password_page.dart';
import 'package:taxi_booking_app/pages/signup_page.dart';
import '../model/auth_controll.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController = Get.put(AuthController());

  bool seepwd = true;
  bool changebutton =false;
  final _formkey = GlobalKey<FormState>();


  loginUser() async {
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.getString('token');
    if(preferences.getString('token')==null){
      const LoginPage();
    }else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
      //HomeScreen();
    }
  }
// navigation and animation button code
  moveToHome(BuildContext context) async{
    if(_formkey.currentState!.validate()) {

      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await authController.LoginIn(context, username.text, password.text);
      // Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => HomePage()),);
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    loginUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        "Taxi Booking App",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        width: MediaQuery.of(context).size.height * 0.4,
                        height: 550,
                        //MediaQuery.of(context).size.height * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: 45,
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                       validator: (value) {
                                         if (value!.isEmpty) {
                                           return 'Enter Email';
                                         } else {
                                           return null;
                                         }
                                       },
                                        keyboardType: TextInputType.emailAddress,
                                        controller: username,
                                        decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          labelText: "Email",
                                          hintText: "Enter Your Email",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          )
                                        )),
                                    SizedBox(height: 20 ,),
                                    TextFormField(
                                      controller: password,
                                      obscureText: seepwd,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          suffixIcon: IconButton(
                                            icon: Icon( seepwd ? Icons.visibility_off : Icons.visibility),
                                            //icon:seepwd== false ?Icon(Icons.remove_red_eye_outlined ): Icon(Icons.remove_red_eye) ,
                                            onPressed: (){
                                              setState(() {
                                                seepwd=!seepwd;
                                              });
                                            },
                                          ),
                                          border:  OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          labelText: 'Password',
                                          hintText: 'Enter Your Password'
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty){
                                          return "Password cannot be Empty";
                                        }
                                        else if(value.length < 6){
                                          return "Password length should be atleast 6";
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ForgetPassword()));
                                      },
                                      child: Text(
                                        "Forgot password?",
                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              InkWell(
                                onTap: ()=>moveToHome(context),
                                child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                  width: changebutton ? 50:150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: changebutton ? Icon(Icons.done):Text("Login",style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(changebutton ? 50 : 8)
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Text("- OR -"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account ?",style: TextStyle(color: Colors.black),),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
                                  }, child: Text("Sign Up",style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.bold),))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    ),
      );
  }
}
