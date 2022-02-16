import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/myhome_controller.dart';
import 'package:gatator/app/data/models/subject_model.dart';
import 'package:gatator/app/ui/global_widgets/wide_button.dart';
import 'package:gatator/app/ui/utils/enum.dart';
import 'package:get/get.dart';
import '../../../controllers/addquestion_controller.dart';
import 'components/mcq_widget.dart';
import 'components/nat_widget.dart';

class AddQuestionPage extends GetView<AddQuestionController> {
  AddQuestionPage({Key? key}) : super(key: key);

  final MyHomeController _myHomeController = Get.find<MyHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Question'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
                width: 80,
                child: WideButton(
                  child: const Text("Submit"),
                  onPressed: () => controller.submit(),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question Form',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    DropdownSearch<Subject>(
                      dropdownBuilder: (context, item) =>
                          Text(item?.title ?? "Select Subject"),
                      dropdownSearchBaseStyle:
                          const TextStyle(color: Colors.white),
                      showSearchBox: true,
                      itemAsString: (Subject? sub) {
                        return sub!.title.toString();
                      },
                      mode: Mode.MENU,
                      items: _myHomeController.allSubjects,
                      dropdownSearchDecoration: InputDecoration(
                        floatingLabelStyle:
                            const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(16)),
                        labelText: "Subject",
                        hintText: "Subject",
                      ),
                      onChanged: controller.updateSubject,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (controller.subject.value != null &&
                        controller.subject.value!.subTopics!.isNotEmpty) ...[
                      DropdownSearch<SubTopic>(
                        dropdownBuilder: (context, item) =>
                            Text(item?.title ?? "Select Sub-topic"),
                        dropdownSearchBaseStyle:
                            const TextStyle(color: Colors.white),
                        showSearchBox: true,
                        itemAsString: (SubTopic? sub) {
                          return sub!.title.toString();
                        },
                        mode: Mode.MENU,
                        items: controller.subject.value!.subTopics ?? [],
                        dropdownSearchDecoration: InputDecoration(
                          floatingLabelStyle:
                              const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(16)),
                          labelText: "Sub Topic",
                          hintText: "Sub Topic",
                        ),
                        onChanged: controller.updateSubTopic,
                      ),
                    ],
                    const SizedBox(
                      height: 16,
                    ),
                    if (controller.subject.value != null &&
                        controller.subTopic.value != null) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Question Image',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          if (controller.questionSelected)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () => controller.removeQuestion(),
                                child: Container(
                                    padding: const EdgeInsets.all(4),
                                    height: 32,
                                    width: 80,
                                    color: Colors.red,
                                    child: const Center(child: Text("Remove"))),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            kIsWeb
                                ? controller.imgFromGallery("question")
                                : _showPicker(context, "question");
                          },
                          child: controller.questionSelected
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(color: Colors.white)),
                                  child: (kIsWeb)
                                      ? Image.memory(
                                          controller.getQuestionImage)
                                      : Image.file(controller.getQuestionImage))
                              : Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: 150,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add_a_photo),
                                      Text('Question Image'),
                                    ],
                                  )),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Text(
                            'Answer Type:',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Text("MCQ"),
                          Switch(
                              activeColor: Colors.transparent,
                              value: controller.typeOfQuestion.value ==
                                  QuestionType.NAT,
                              onChanged: (value) =>
                                  controller.updateTypeOfQuestion(value)),
                          const Text("NAT"),
                        ],
                      ),
                      controller.typeOfQuestion.value == QuestionType.NAT
                          ? NATAnswerWidget()
                          : MCQOptionsWidget(),
                      const SizedBox(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Solution Image',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          if (controller.solutionSelected)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                onTap: () => controller.removeSolution(),
                                child: Container(
                                    padding: const EdgeInsets.all(4),
                                    height: 32,
                                    width: 80,
                                    color: Colors.red,
                                    child: const Center(child: Text("Remove"))),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            kIsWeb
                                ? controller.imgFromGallery("solution")
                                : _showPicker(context, "solution");
                          },
                          child: controller.solutionSelected
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      border: Border.all(color: Colors.white)),
                                  child: (kIsWeb)
                                      ? Image.memory(
                                          controller.getSolutionImage)
                                      : Image.file(controller.getSolutionImage))
                              : Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
                                  height: 150,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.add_a_photo),
                                      Text(
                                        'Solution Image',
                                      ),
                                    ],
                                  )),
                                ),
                        ),
                      ),
                    ]
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext context, String type) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Select from Gallery'),
                    onTap: () {
                      controller.imgFromGallery(type);
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          );
        });
  }
}
