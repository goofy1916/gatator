import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/myhome_controller.dart';
import 'package:get/get.dart';

class MyHomePage extends GetView<MyHomeController> {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gatator'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => ListView(
              children: [
                const Text('Welcome to Gatator'),
                ...controller.subjectsList.map((subject) {
                  return ListTile(
                    title: Text(subject['title']),
                    trailing: Checkbox(
                      onChanged: (value) =>
                          (controller.updateSelectedSubjects(subject)),
                      value: subject['isSelected'] ?? false,
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
