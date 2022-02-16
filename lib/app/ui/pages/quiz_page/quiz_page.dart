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
        title: const Text('Quiz'),
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
                        : controller.submit(),
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
                // SizedBox(
                //   height: 40,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       IconButton(
                //         icon: const Icon(
                //           Icons.arrow_back_ios_new_sharp,
                //           color: kAccentColor,
                //         ),
                //         onPressed: () => controller.updateStep(-1),
                //       ),
                //       IconButton(
                //         icon: const Icon(
                //           Icons.arrow_forward_ios_sharp,
                //           color: kAccentColor,
                //         ),
                //         onPressed: () => controller.updateStep(1),
                //       ),
                //     ],
                //   ),
                // ),
                NumberStepper(
                  // controlsBuilder: (BuildContext context,
                  //     {VoidCallback? onStepContinue,
                  //     VoidCallback? onStepCancel}) {
                  //   return const SizedBox.shrink();
                  // },
                  // onStepTapped: (value) =>
                  //     controller.updateCurrentQuestion(value),
                  // steps: getQuestions(),
                  // currentStep: controller.currentQuestion.value,
                  // type: StepperType.horizontal,
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
                Expanded(child: getQuestion()),
              ],
            );
            // return PageView(
            //   allowImplicitScrolling: false,
            //   pageSnapping: true,
            //   physics: const ClampingScrollPhysics(),
            //   controller: controller.questionController,
            //   children: getQuestions(),
            // );
          }
        }),
      ),
    );
  }

  Widget getQuestion() {
    // List<Step> widgets = [];
    // for (int i = 0; i < controller.questions.length; i++) {
    //   widgets.add(
    //     Step(title: const Text(""), content: QuestionWidget(i: i)),
    //   );
    // }

    return QuestionWidget(i: controller.currentQuestion.value);
  }
}
