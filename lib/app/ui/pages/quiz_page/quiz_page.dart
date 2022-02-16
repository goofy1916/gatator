import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/quizpage_controller.dart';
import 'package:gatator/app/routes/pages.dart';
import 'package:gatator/app/ui/global_widgets/wide_button.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';
import 'package:im_stepper/stepper.dart';

import 'components/question_widget.dart';

class QuizPage extends GetView<QuizPageController> {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Quiz'),
            Obx(() => Text(
                  controller.submitted.value
                      ? "Scrore :${controller.correctAnswers}/${controller.questions.length}"
                      : "",
                  style: const TextStyle(fontSize: 16),
                ))
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() => SizedBox(
                  width: 80,
                  child: WideButton(
                    child: controller.submitted.value
                        ? Row(
                            children: const [
                              Text("Home"),
                              Icon(Icons.home),
                            ],
                          )
                        : const Text("Submit"),
                    onPressed: () => controller.submitted.value
                        ? Get.offAndToNamed(Routes.HOME)
                        : submit(),
                  ),
                )),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                NumberStepper(
                  activeStep: controller.currentQuestion.value,
                  onStepReached: (value) =>
                      controller.updateCurrentQuestion(value),
                  activeStepColor: Colors.blue,
                  numberStyle: const TextStyle(color: Colors.white),
                  stepRadius: 10,
                  stepColor: Colors.grey,
                  nextButtonIcon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: kAccentColor,
                  ),
                  previousButtonIcon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: kAccentColor,
                  ),
                  numbers: List.generate(
                      controller.questions.length, (index) => index + 1),
                ),
                Expanded(
                    child: QuestionWidget(i: controller.currentQuestion.value)),
              ],
            );
          }
        }),
      ),
    );
  }

  submit() {
    Get.defaultDialog(
      title: "Submit quiz ?",
      middleText: "",
      textCancel: "Cancel",
      cancelTextColor: Colors.red,
      textConfirm: "Confirm",
      confirmTextColor: Colors.white,
      onConfirm: () {
        controller.submit();
        Get.back();
      },
    );
  }
}
