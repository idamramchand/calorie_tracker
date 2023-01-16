import 'package:calorie_tracker/utils/constants.dart';
import 'package:calorie_tracker/utils/router.dart';
import 'package:calorie_tracker/utils/session_manager.dart';
import 'package:calorie_tracker/view/login_view.dart';
import 'package:calorie_tracker/view/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Calorie Tracker',
      initialRoute: '/',
      getPages: routes,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green
        ),
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Calorie Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final title;
  MyHomePage({Key? key, required String this.title}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState(){
    super.initState();
    SessionManager.init();
    Future.delayed(Duration(seconds: 4)).then((value){
     // Get.toNamed(MainView.routeName);
      Get.toNamed(LoginView.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // title: Text('Calorie Tracker',textAlign: TextAlign.center,),
      // ),
      body: Stack(
        children: [
          Image.asset('${Constants.ImagePath}SplashScreen.png',
          height: Get.height,
          width: Get.height,
          ),
         Container(
           alignment: Alignment.center,
           decoration: BoxDecoration(
             border: Border.all(color: Colors.white),
             gradient: LinearGradient(colors: [Colors.redAccent,Colors.orangeAccent],
             //stops: [0.0,0.8],
               begin: Alignment.topLeft,
               end: Alignment.bottomRight,
               transform: GradientRotation(0.8)

             )
           ),
           child: Text('Calorie Tracker',style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 28),),
         )
        ],
      ),
    );
  }
}



