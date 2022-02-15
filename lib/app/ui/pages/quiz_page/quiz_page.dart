import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/quizpage_controller.dart';
import 'package:gatator/app/routes/pages.dart';
import 'package:gatator/app/ui/global_widgets/wide_button.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_sharp,
                        color: kAccentColor,
                      ),
                      onPressed: () => controller.updateStep(-1),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Stepper(
                      controlsBuilder: (BuildContext context,
                          {VoidCallback? onStepContinue,
                          VoidCallback? onStepCancel}) {
                        return const SizedBox.shrink();
                      },
                      onStepTapped: (value) =>
                          value < controller.questions.length
                              ? controller.updateCurrentQuestion(value)
                              : null,
                      steps: getQuestions(),
                      currentStep: controller.currentQuestion.value,
                      type: StepperType.horizontal,
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: kAccentColor,
                      ),
                      onPressed: () => controller.updateStep(1),
                    ),
                  ),
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
      ),
    );
  }

  List<Step> getQuestions() {
    List<Step> widgets = [];
    for (int i = 0; i < controller.questions.length; i++) {
      widgets.add(
        Step(title: const Text(""), content: QuestionWidget(i: i)),
      );
    }

    return widgets;
  }
}
