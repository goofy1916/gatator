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
        borderRadius: BorderRadius.circular(16),
        color: Colors.blueGrey[300],
      ),
      height: controller.submitted.value
          ? MediaQuery.of(context).size.height + 300
          : MediaQuery.of(context).size.height - 100,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Row(
                children: [
                  Text("Question ${i + 1}/${controller.questions.length}",
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                  if (controller.submitted.value)
                    Row(
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
            const Text("Answer: ",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Your Answer: ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white)),
                          SizedBox(
                              width: 80,
                              child: TextField(
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  decoration: const InputDecoration(
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
                        ],
                      ),
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
