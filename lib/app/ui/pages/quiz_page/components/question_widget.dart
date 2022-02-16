import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/quizpage_controller.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:gatator/app/ui/utils/enum.dart';
import 'package:get/get.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;
  final QuizPageController controller = Get.find<QuizPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), color: kPrimaryColor),
      height: controller.submitted.value
          ? MediaQuery.of(context).size.height + 300
          : MediaQuery.of(context).size.height - 100,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Question ${i + 1}/${controller.questions.length}",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    if (controller.submitted.value)
                      SizedBox(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (controller.questions[i].isRight) ...const [
                              Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              Text("Correct")
                            ] else ...const [
                              Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                              Text("Wrong")
                            ],
                          ],
                        ),
                      )
                  ],
                );
              }),
              SizedBox(
                height: 400,
                child: Image.network(
                  controller.questions[i].question,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Text(controller.submitted.value ? "Your Answer: " : "Answer: ",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
              if (controller.submitted.value) ...[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Text(controller.questions[i].selectedAnswer.toString(),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: controller.questions[i].isRight
                              ? Colors.green
                              : Colors.red)),
                ),
                const Text("Right Answer: ",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      controller.questions[i].type == QuestionType.MCQ
                          ? controller.questions[i].correctAnswer.toString()
                          : "[${controller.questions[i].from} - ${controller.questions[i].to}]",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.green)),
                ),
              ] else
                controller.questions[i].type == QuestionType.MCQ
                    ? SizedBox(
                        height: 50,
                        child: OptionsWidget(
                          group: i,
                        ))
                    : Container(
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              child: TextField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: "Enter answer",
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  onChanged: (String? value) =>
                                      controller.natAnswer(value!, i))),
                        ),
                      ),
              const SizedBox(
                height: 20,
              ),
              if (controller.submitted.value) ...[
                const Text("Solution: ",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
                SizedBox(
                  height: 400,
                  child: Image.network(
                    controller.questions[i].answer,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  OptionsWidget({
    Key? key,
    required this.group,
  }) : super(key: key);

  final int group;

  final QuizPageController controller = Get.find<QuizPageController>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 8,
      children: [
        ...controller.questions[group].options!
            .map((option) => SizedBox(
                  height: 30,
                  width: 80,
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Obx(() => Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              value: controller.questions[group].selectedAnswer
                                  .contains(option),
                              onChanged: (value) {
                                controller.selectAnswer(option, group);
                              },
                            ),
                            Text(option,
                                style: const TextStyle(color: Colors.white)),
                          ],
                        )),
                  ),
                ))
            .toList()
      ],
    );
  }
}
