


import 'package:calorie_tracker/utils/constants.dart';
import 'package:calorie_tracker/utils/logger.dart';
import 'package:calorie_tracker/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../utils/session_manager.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);
  static const String routeName = '/RegistrationView';

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController idCntrl = TextEditingController();
  TextEditingController pswdCntrl = TextEditingController();
  TextEditingController cnfmCntrl = TextEditingController();
  TextEditingController mobileCntrl = TextEditingController();
  ScrollController _scrCntrl = ScrollController();
  bool isVisible = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration',style: TextStyle(color: Colors.white),),),
      body: SingleChildScrollView(
        controller: _scrCntrl,
        padding: EdgeInsets.all((12.0)),
        child: Form(
          key: _formKey,
          child: Stack(
            fit: StackFit.loose,
            children: [
              Image.asset('${Constants.ImagePath}SplashScreen.png',fit: BoxFit.cover,),
              SizedBox(height: 50,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 160,),
                    TextFormField(
                      controller: idCntrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Enter User Name',
                          labelText: 'User Name'
                      ),
                      validator: (val){
                        if(val!.length == 0){
                          Logger.showSnackBar(msg: "Please Enter User Name");
                        }
                      },
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      controller: pswdCntrl,
                      keyboardType: TextInputType.text,
                      obscureText: isVisible,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      decoration: InputDecoration(
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
                          Logger.showSnackBar(msg: "Please Enter Password");
                        } else if(val.length > 20 || val.length < 8 ){
                          Logger.showSnackBar(msg: 'Password should be atleast 8 characters long');
                        } else if(!reg.hasMatch(val)){
                          Logger.showSnackBar(msg: "Password Should contain Special characters and Numbers");
                        }
                      },
                    ),

                    SizedBox(height: 20,),
                    TextFormField(
                      controller:cnfmCntrl,
                      keyboardType: TextInputType.text,
                      obscureText: isVisible,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Enter Confirm Password',
                          labelText: 'Confirm Password'
                      ),

                      validator: (val){
                        RegExp reg = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if(val!.isEmpty){
                          Logger.showSnackBar(msg: "Please Enter Password");
                        } else if(val.length > 20 || val.length < 8 ){
                          Logger.showSnackBar(msg: 'Password should be atleast 8 characters long');
                        } else if(!reg.hasMatch(val)){
                          Logger.showSnackBar(msg: "Password Should contain Special characters and Numbers");
                        }
                      },
                    ),

                    SizedBox(height: 20,),
                    TextFormField(
                      controller:mobileCntrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: 'Enter Mobile Number',
                          labelText: 'Mobile'
                      ),
                      validator: (val){
                        RegExp regex = RegExp(r'(^[9876]\d{9}$)');
                       if(val!.length != 10 ){
                         Logger.showSnackBar(msg: "Please Enter Valid Mobile Number");
                       } else
                         if(regex.hasMatch(val)){
                          return null;
                       } else {
                           return 'Enter Valid Mobile Number';
                         }
                      },
                    ),

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
            ],

          ),
        ),
      ),
    );
  }

   _validate() {
    //if(_formKey.currentState!.validate()){
     if(idCntrl.text == ''){
        Logger.showSnackBar(msg: "Please Enter User Name");
      } else if(pswdCntrl.text == ''){
        Logger.showSnackBar(msg: "Please Enter Password");
      } else if(cnfmCntrl.text == ''){
        Logger.showSnackBar(msg: "Please Enter Confirm Password");
      } else if(pswdCntrl.text != cnfmCntrl.text){
        Logger.showSnackBar(msg: "Password and Confirm Password should be same");
      } else if(mobileCntrl.text == ''){
        Logger.showSnackBar(msg: "Please Enter Mobile Number");
      }
      else{
        SessionManager.setString(Constants.Pref_Id,idCntrl.text);
        SessionManager.setString(Constants.Pref_pswd,pswdCntrl.text);
        SessionManager.setString(Constants.Pref_mobile,mobileCntrl.text);
        Get.toNamed(LoginView.routeName);
        //Logger.log("")
      }
    }

   //}
}
