import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/myhome_controller.dart';
import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/ui/global_widgets/wide_button.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';

import 'widgets/subject_expandable_list_title.dart';

class MyHomePage extends GetView<MyHomeController> {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
            toolbarHeight: 80,
            elevation: 4,
            title: const Text('Gatator'),
            centerTitle: true,
            actions: const [
              CircleAvatar(
                backgroundColor: kTextColor,
                child: Icon(Icons.person_rounded, color: kPrimaryColor),
              ),
              SizedBox(
                width: 16,
              ),
            ]),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 9,
                child: Obx(
                  () {
                    if (controller.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView(
                        children: [
                          Text('Choose your subjects',
                              style: Theme.of(context).textTheme.headline4!),
                          const SizedBox(
                            height: 16,
                          ),
                          SubjectList(),
                        ],
                      );
                    }
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: WideButton(
                    onPressed: () => controller.toTestCustomizationScreen(),
                    child: Center(
                      child: Text(
                        "Next",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: kButtonTextColor),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
