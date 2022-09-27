import 'package:flutter/material.dart';
import 'package:taxi_booking_app/model/auth_controll.dart';
import 'package:taxi_booking_app/pages/login_page.dart';
import 'package:get/get.dart';


class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  bool changebutton = false;
  bool seecurrentpwd = true;
  bool seenewpwd = true;
  bool seeconfimepwd = true;

  final _formkey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  AuthController authController=Get.put(AuthController());

  //Function to move to login page
  moveTologinpage(BuildContext context)async{
    if(_formkey.currentState!.validate()){
      setState(() {
        changebutton = true;
      });
      await Future.delayed(Duration(seconds: 2));
      await authController.forgotPassword(email.text);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
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
                height:MediaQuery.of(context).size.height *0.7,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )
                ),
              ),
             Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 SizedBox(height: 15,),
                 Center(
                   child: Text("Taxi Booking App",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
                 ),
                 SizedBox(
                   height: 20.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(12),
                   child: Container(
                     width: MediaQuery.of(context).size.height * 0.4,
                     height: MediaQuery.of(context).size.height * 0.5,
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
                             "Forget Paasword",
                             style: TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 24),
                           ),
                           SizedBox(
                             height: 85,
                           ),
                           Form(
                             key: _formkey,
                             child: Column(
                               children: [
                                 TextFormField(
                                     keyboardType: TextInputType.emailAddress,
                                     controller: email,
                                     decoration: InputDecoration(
                                         fillColor: Colors.grey.shade100,
                                         filled: true,
                                         labelText: "Email",
                                         hintText: "Enter Your Email",
                                         border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(10),
                                         ),
                                     ),
                                   validator: (value) {
                                     if (value!.isEmpty) {
                                       return 'Enter Email';
                                     } else {
                                       return null;
                                     }
                                   },
                                 ),
                                 SizedBox(height: 30 ,),

                               ],
                             ),
                           ),
                           SizedBox(
                             height: 25,
                           ),
                           InkWell(
                             onTap: ()=>moveTologinpage(context),
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
                         ],
                       ),
                     ),
                   ),
                 ),
               ],
             ),
          ],
          ),
        ),
      ),
    );
  }
}
