import 'package:flutter/material.dart';
import 'package:gatator/app/ui/global_widgets/wide_button.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';
import '../../../controllers/quizpreferences_controller.dart';

class QuizPreferencesPage extends GetView<QuizPreferencesController> {
  const QuizPreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Preferences'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 9,
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No of Questions for quiz :',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: kPrimaryColor),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                    onPressed: () =>
                                        controller.updateNoOfQuestions(-1),
                                    child: const Text("-")),
                                SizedBox(
                                  width: 30,
                                  child: Center(
                                    child: Text(
                                      controller.noOfQuestions.value.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                TextButton(
                                    onPressed: () =>
                                        controller.updateNoOfQuestions(1),
                                    child: const Text("+")),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Time Wanted (in minutes):',
                      //       style: Theme.of(context).textTheme.headline4,
                      //     ),
                      //     Container(
                      //       decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(8),
                      //           color: kPrimaryColor),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           TextButton(
                      //               onPressed: () =>
                      //                   controller.updateTimeWanted(-0.5),
                      //               child: const Text("-")),
                      //           SizedBox(
                      //             width: 30,
                      //             child: Center(
                      //               child: Text(
                      //                 controller.timeInMinutes.value.toString(),
                      //                 style:
                      //                     const TextStyle(color: Colors.white),
                      //               ),
                      //             ),
                      //           ),
                      //           TextButton(
                      //               onPressed: () =>
                      //                   controller.updateTimeWanted(0.5),
                      //               child: const Text("+")),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Flexible(
                  child: WideButton(
                      onPressed: () => controller.takeQuiz(),
                      child: Center(
                        child: Text(
                          "Take Quiz",
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: kButtonTextColor),
                        ),
                      )),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
