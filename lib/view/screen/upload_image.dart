import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/upload_image_controller.dart';
import 'package:lordsbox/view/screen/offline.dart';
import 'package:lordsbox/view/widget/uploadImage/image_layout.dart';
import 'package:lordsbox/view/widget/uploadImage/no_image_layout.dart';
import 'package:lordsbox/view/widget/uploadImage/row_text_color.dart';
import 'package:lordsbox/view/widget/uploadImage/upload_image_buttons.dart';
import 'package:lordsbox/view/widget/uploadImage/upload_image_proccess.dart';

class Uploadimage extends StatelessWidget {
  const Uploadimage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(
      UploadImageController(),
      permanent: true,
    );
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          Get.arguments != null ? "${Get.arguments["appbarText"]}" : "",
          style: TextStyle(
            fontSize: 22,
            color: Get.theme.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: WillPopScope(
          child: GetBuilder<UploadImageController>(
            builder: (controller) => controller.isconnect == false
                ? Offline()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: RowTextColor(
                          text: "Please Upload A Photo Of Your".tr,
                          colorizedText: "Car`s Counter".tr,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      if (controller.img == null)
                        Expanded(
                          flex: 3,
                          child: NoImageLayout(),
                        ),
                      if (controller.img != null)
                        Expanded(
                          flex: 3,
                          child: ImageLayout(),
                        ),
                      if (controller.img != null)
                        if (controller.progress != 0)
                          Expanded(
                            child: UploadImageProccess(),
                          )
                        else
                          Expanded(
                            child: UploadImageButtons(),
                          )
                      else
                        Expanded(
                          child: Container(),
                        ),
                    ],
                  ),
          ),
          onWillPop: (() async {
            if (Navigator.of(context).canPop()) {
              return true;
            } else
              return false;
          })),
    ));
  }
}
