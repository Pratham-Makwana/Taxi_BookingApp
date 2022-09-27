import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_booking_app/model/auth_controll.dart';
import 'package:taxi_booking_app/pages/forget_password_page.dart';
import 'package:taxi_booking_app/pages/login_page.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool  changebutton = false;
  bool seepwd = true;
  final _formkey = GlobalKey<FormState>();


  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  AuthController authController=Get.put(AuthController());

  moveToLogin(BuildContext context)async{
    if(_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await  authController.signUp(name.text,username.text, password.text);
      // Navigator.push(
      //context, MaterialPageRoute(builder: (context) => LoginPage()),);
      setState(() {
        changebutton = false;
      });
    }
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
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: name,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          border:  OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          ),
                                          labelText: 'Name',
                                          hintText: 'Enter Your Name'
                                      ),
                                      validator: (value){
                                        if (value!.isEmpty)
                                          return "Name cannot be Empty";
                                        else
                                          return null;
                                      },
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
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
                                    SizedBox(height: 15 ,),
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
                                height: 15,
                              ),
                              InkWell(
                                onTap: ()=>moveToLogin(context),
                                child: AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  width: changebutton ? 50:150,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: changebutton ? Icon(Icons.done):Text("SignUp",style: TextStyle(
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
                                height: 10,
                              ),
                              Text("- OR -"),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Already have an account ?",style: TextStyle(color: Colors.black),),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                                  }, child: Text("Login",style: TextStyle(color: Colors.yellow,fontSize: 20,fontWeight: FontWeight.bold),))
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
