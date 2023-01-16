

import 'package:calorie_tracker/utils/constants.dart';
import 'package:calorie_tracker/utils/logger.dart';
import 'package:calorie_tracker/utils/session_manager.dart';
import 'package:calorie_tracker/view/registration_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'main_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = '/LoginView';

  @override
  State<LoginView> createState() => _LoginViewState();
}
class _LoginViewState extends State<LoginView> {

  ScrollController _scrCntrl = ScrollController();
  TextEditingController pswdCntrl = TextEditingController();
  TextEditingController idCntrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',style: TextStyle(color: Colors.white),),

      ),

      body: SingleChildScrollView(
        controller: _scrCntrl,
        //padding: EdgeInsets.all((12.0)),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Image.asset('${Constants.ImagePath}SplashScreen.png',
                width: Get.width,
                fit: BoxFit.cover,),
              SizedBox(height: 50,),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(height: 160,),
                      TextFormField(
                        controller: idCntrl,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Enter User Name',
                            labelText: 'User Name'
                        ),
                        // validator: (val){
                        //   if(val!.length == 0){
                        //     Logger.showScaffoldMessage(msg: "Please Enter Name");
                        //   }
                        // },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: pswdCntrl,
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        ],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: 'Enter Password',
                            labelText: 'Password'
                        ),
                        validator: (val){
                          RegExp reg = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if(val!.isEmpty){
                            Logger.showScaffoldMessage(msg: "Please Enter Password");
                          } else if(val.length > 20 || val.length < 8 ){
                            Logger.showScaffoldMessage(msg: 'Password should be atleast 8 characters long');
                          }
                          // else if(!reg.hasMatch(val)){
                          //   Logger.showScaffoldMessage(msg: "Password Should contain Special characters and Numbers");
                          // }
                        },
                      ),
                      SizedBox(height: 20,),
                     InkWell(
                       onTap: (){
                         Get.toNamed(RegistrationView.routeName);
                       },
                         child: Align(alignment: Alignment.centerRight,child: Text('New user ? Please Register',style: TextStyle(color: Colors.redAccent),),)),
                      SizedBox(height: 50,),

                      Container(
                        height: 40,
                        width: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                          child: Text("Submit",style: TextStyle(color: Colors.white),),
                          onPressed: (){
                              _validate();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }

   _validate() {
    //if(_formKey.currentState!.validate()){
      if(idCntrl.text == '') {
        Logger.showSnackBar(msg: "Please Enter User Name");
      } else if(pswdCntrl.text == ''){
        Logger.showSnackBar(msg: "Please Enter password");
      } else{
          if(idCntrl.text == SessionManager.getString(Constants.Pref_Id) &&
          pswdCntrl.text == SessionManager.getString(Constants.Pref_pswd)){
            Get.toNamed(MainView.routeName);
          }
          else{
            Logger.showSnackBar(msg:"Invalid Credentials");
          }
      }
    }
   //}
}
