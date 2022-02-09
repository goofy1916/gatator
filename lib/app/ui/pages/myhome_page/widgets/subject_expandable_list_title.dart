import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/myhome_controller.dart';
import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';

class SubjectList extends StatelessWidget {
  SubjectList({
    Key? key,
  }) : super(key: key);

  final MyHomeController controller = Get.find<MyHomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return ExpansionPanelList(
          expansionCallback: (i, isOpen) => controller.updateIsExpanded(i),
          children: [
            for (int index = 0; index < controller.allSubjects.length; index++)
              ExpansionPanel(
                backgroundColor: kPrimaryColor,
                isExpanded: controller.isExpanded[index],
                headerBuilder: (context, isOpen) {
                  return SubjectListTile(
                      controller: controller,
                      subject: controller.allSubjects[index]);
                },
                body: Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: SubTopicsList(
                    subject: controller.allSubjects[index],
                  ),
                ),
              ),
          ],
        );
      }),
    );
  }
}

class SubTopicsList extends StatelessWidget {
  SubTopicsList({Key? key, required this.subject}) : super(key: key);

  final Subject subject;
  final MyHomeController controller = Get.find<MyHomeController>();

  @override
  Widget build(BuildContext context) {
    if (subject.subTopics == null) {
      return const Center(child: Text("Topics added soon..."));
    }
    return Column(
      children: [
        ...subject.subTopics!
            .map(
              (topic) => ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: const Icon(Icons.class_, color: kAccentColor),
                onTap: () => controller.selectSubjectTopic(subject, topic),
                title: Text(
                  topic.title,
                  style: const TextStyle(color: kTextColor),
                ),
                trailing: topic.selected
                    ? const Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                        color: Colors.grey,
                      ),
              ),
            )
            .toList()
      ],
    );
  }
}

class SubjectListTile extends StatelessWidget {
  const SubjectListTile({
    Key? key,
    required this.controller,
    required this.subject,
  }) : super(key: key);

  final MyHomeController controller;
  final Subject subject;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: const Icon(Icons.class_, color: kAccentColor),
        onTap: () => controller.selectSubject(subject),
        title: Text(
          subject.title,
          style: const TextStyle(color: kTextColor),
        ),
        trailing: subject.selected
            ? const Icon(
                Icons.check_circle_outline,
                color: Colors.green,
              )
            : const Icon(
                Icons.circle_outlined,
                color: Colors.grey,
              ));
  }
}

// class SubjectExpansionPanel extends StatelessWidget {
//   const SubjectExpansionPanel({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    // return ExpansionPanel(headerBuilder:(context, isOpen) {return Container() }, body: Container());
    // return ExpansionPanel(
    // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    // tileColor: kPrimaryColor,
    // leading: const Icon(Icons.class_, color: kAccentColor),
    // onTap: () => controller.selectSubject(subject),
    // title: Text(
    //   subject.title,
    //   style: const TextStyle(color: kTextColor),
    // ),
    // trailing: subject.selected
    //     ? const Icon(
    //         Icons.check_circle_outline,
    //         color: Colors.green,
    //       )
    //     : const Icon(
    //         Icons.circle_outlined,
    //         color: Colors.grey,
    //       ),
    // body: null, headerBuilder: (BuildContext context, bool isExpanded) {  },
//   }
// }
