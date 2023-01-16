
import 'package:calorie_tracker/view/login_view.dart';
import 'package:calorie_tracker/view/main_view.dart';
import 'package:calorie_tracker/view/registration_view.dart';
import 'package:get/get.dart';

import '../view/activity_view.dart';


List<GetPage> routes = [
  GetPage(name: MainView.routeName, page: () => MainView()),
  GetPage(name: LoginView.routeName, page: () => LoginView()),
  GetPage(name: RegistrationView.routeName, page: () => RegistrationView()),
  GetPage(name: ActivityView.routeName, page: () => ActivityView())
];