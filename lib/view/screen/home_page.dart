import 'package:lordsbox/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/core/constant/url.dart';
import 'package:lordsbox/view/widget/homePage/home_page_title.dart';
import 'package:lordsbox/view/widget/homePage/my_drawer.dart';
import 'package:lordsbox/view/widget/rounded_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home".tr),
        ),
        drawer: Drawer(
          child: MyDrawer(),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: HomePagetitle(),
              ),
              Expanded(
                child: Image.asset(
                  logoImage,
                ),
              ),
              Expanded(
                flex: 3,
                child: RipplesAnimation(
                  child: Text(
                    "GO".tr,
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    controller.navigateToUploadImage();
                  },
                  color: Get.theme.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
