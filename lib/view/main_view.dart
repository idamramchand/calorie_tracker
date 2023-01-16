
import 'package:calorie_tracker/view/sub_child_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants.dart';
import '../utils/session_manager.dart';
import 'activity_view.dart';
import 'login_view.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);
  static const String routeName = '/MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  ScrollController _scrCntrl = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Calorie Tracker',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),
        actions: [
          IconButton(
              onPressed: (){
                Get.defaultDialog(
                  title: 'Are you Sure ?',
                  middleText: 'Do You want To Logout.',
                  textConfirm: 'YES',
                  textCancel: 'Cancel',
                  confirmTextColor: Colors.white,
                  onConfirm: () async {
                    SessionManager.clearAllPREF();
                    Get.offAllNamed(LoginView.routeName);
                  },
                );
              },
              icon: Icon(Icons.power_settings_new_rounded,
            color: Colors.white,
            size: 30,))
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrCntrl,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: SessionManager.getString(Constants.activity) == '' ?
          Card(
            elevation: 8,
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SubChildItem("Activity", SessionManager.getString(Constants.activity), false),
                SubChildItem("Date", SessionManager.getString(Constants.date), false),
                SubChildItem("Time", SessionManager.getString(Constants.time) + ' Mins', false),
                SubChildItem("Calories Gained", SessionManager.getString(Constants.calories_gain), false),
                SubChildItem("Calories Burnt", SessionManager.getString(Constants.calories_burn), false),
              ],
            ),
          ) : Center(child: Text('No Activities Found ',style: TextStyle(color: Colors.blue,fontSize: 24,fontWeight: FontWeight.bold),),)
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.toNamed(ActivityView.routeName);
        },),
    );
  }
}
