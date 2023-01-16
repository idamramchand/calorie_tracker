

import 'package:calorie_tracker/utils/session_manager.dart';
import 'package:datetime_picker_field_platform/datetime_picker_field_platform.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/statemodel.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';
import 'package:get/get.dart';

import 'main_view.dart';

class ActivityView extends StatefulWidget {
  const ActivityView({Key? key}) : super(key: key);
  static const String routeName = '/ActivityView';

  @override
  State<ActivityView> createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  ScrollController _scrCntrl = ScrollController();
  List<StateModel> activites = [];
  int actIndx = 0;
  DateFormat format = DateFormat("MM-dd-yyyy");
  TextEditingController ondateCntrl = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TextEditingController timeInput1 = TextEditingController();
  TextEditingController calCntrl = TextEditingController();
  int value = 0;

  @override
  void initState() {
    super.initState();
    activites.add(StateModel(Id: '0', Value: 'Select Activity'));
    activites.add(StateModel(Id: '1', Value: 'Walking'));
    activites.add(StateModel(Id: '2', Value: 'Running'));
    activites.add(StateModel(Id: '3', Value: 'Cycling'));
    activites.add(StateModel(Id: '4', Value: 'Swimming'));


    //activites.add(StateModel(Id: '3',Value:'Cycling'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calorie Tracker'),),
      body: SingleChildScrollView(
        controller: _scrCntrl,
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<StateModel>(
                    iconEnabledColor: Colors.green,
                    isExpanded: true,
                    hint: Text(activites[actIndx].Value,
                      style: TextStyle(fontSize: 16, color: Colors.black),),
                    items: activites.map((StateModel val) {
                      return DropdownMenuItem<StateModel>(
                          value: val,
                          child: Text(val.Value, style: TextStyle(
                              fontSize: 16, color: Colors.black),));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        actIndx = activites.indexOf(value!);
                      });
                    },

                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 0, right: 2, top: 0),
                child: DateTimeField(
                  controller: ondateCntrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)
                    ),
                    suffixIcon: Icon(
                      Icons.date_range,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    labelText: "On Date",
                    labelStyle: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontFamily: "Nunito"),
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                      firstDate: DateTime(1990),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now(),
                      context: context,
                    );
                  },
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.number,
                controller: timeInput1,
                inputFormatters: [
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black26)
                    ),
                    hintText: 'Enter Time in Minutes',
                    labelText: 'Time'
                ),
              ),

              // DateTimeFieldPlatform(
              //   controller: timeInput,
              //   mode: DateMode.time,
              //   decoration: const InputDecoration(
              //       border: OutlineInputBorder(
              //           borderSide: BorderSide(color: Colors.black)
              //       ),
              //       hintText: 'Select Time'
              //   ),
              //   minimumDate: DateTime.now().subtract(const Duration(hours: 10)),
              //   maximumDate: DateTime.now(),
              //
              // ),
              SizedBox(height: 10,),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return RadioListTile<int>(
                    value: index,
                    title: index == 0 ? Text('Calories Burned') : Text(
                        'Calories Gained'),
                    groupValue: value,
                    onChanged: (ind) => setState(() => value = ind!),
                  );
                },
              ),
              TextFormField(
                controller: calCntrl,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black26)
                    ),
                    hintText: 'Number Of Calories',
                    labelText: 'Calories'
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () {
                    _validate();
                  },
                  child: Text('Submit'),
                ),
              )

            ],
          ),
        ),
      ),

    );
  }

  _validate() {
    if (activites[actIndx].Value == 'Select Activity') {
      Logger.showSnackBar(msg: "Please Select Activity");
    }
    else if (ondateCntrl.text == '') {
      Logger.showSnackBar(msg: "Please Select Date");
    }
    else if (timeInput1.text == '') {
      Logger.showSnackBar(msg: 'Please Enter Time');
    } else if(int.parse(timeInput1.text) < 1){
      Logger.showSnackBar(msg: 'Please Enter valid Time');
    }
    else if (calCntrl.text == '') {
      Logger.showSnackBar(
          msg: "Please Enter Calories you Gained or Burned");
    } else if(int.parse(calCntrl.text) < 1){
      Logger.showSnackBar(msg: "Please Enter Valid Calories");
    }
    else {
      SessionManager.setString(Constants.activity,activites[actIndx].Value);
      SessionManager.setString(Constants.date,ondateCntrl.text);
      SessionManager.setString(Constants.time,timeInput1.text);
      value == 0
          ? SessionManager.setString(Constants.calories_burn,calCntrl.text)
          : SessionManager.setString(Constants.calories_gain,calCntrl.text);
      Get.offAllNamed(MainView.routeName);
      Logger.log('Inside Else Part');
    }
  }
}
