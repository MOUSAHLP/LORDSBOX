import 'package:get/get.dart';
import 'package:lordsbox/core/middleware/my_middleware.dart';
import 'package:lordsbox/view/screen/edit_profile.dart';
import 'package:lordsbox/view/screen/home_page.dart';
import 'package:lordsbox/view/screen/language_screen.dart';
import 'package:lordsbox/view/screen/login.dart';
import 'package:lordsbox/view/screen/map_page.dart';
import 'package:lordsbox/view/screen/signup.dart';
import 'package:lordsbox/view/screen/upload_image.dart';

class AppRoute {
  static const String firstPage = "/";
  static const String languagePage = "/languagePage";
  static const String homePage = "/homePage";
  static const String uploadImage = "/uploadImage";
  static const String mapPage = "/mapPage";
  static const String signup = "/signup";
  static const String login = "/login";
  static const String editProfile = "/editProfile";
}

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoute.firstPage,
    page: () => const LanguageScreen(),
    middlewares: [
      MyMiddleWare(),
    ],
  ),
  GetPage(
    name: AppRoute.languagePage,
    page: () => const LanguageScreen(),
    middlewares: [],
  ),
  GetPage(
    name: AppRoute.homePage,
    page: () => const HomePage(),
  ),
  GetPage(
    name: AppRoute.uploadImage,
    arguments: Map,
    page: () => const Uploadimage(),
  ),
  GetPage(
    name: AppRoute.mapPage,
    page: () => const MapPage(),
  ),
  GetPage(
    name: AppRoute.signup,
    page: () => const SignUp(),
  ),
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
  ),
  GetPage(
    name: AppRoute.editProfile,
    page: () => const EditProfile(),
  ),
];
