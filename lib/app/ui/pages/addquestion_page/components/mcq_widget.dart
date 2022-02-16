import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/addquestion_controller.dart';
import 'package:gatator/app/ui/theme/color_constants.dart';
import 'package:get/get.dart';

class MCQOptionsWidget extends StatelessWidget {
  MCQOptionsWidget({
    Key? key,
  }) : super(key: key);

  final AddQuestionController controller = Get.find<AddQuestionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Available Options :',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kPrimaryColor),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () => controller.updateOptions(-1),
                        child: const Text("-")),
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Text(
                          controller.options.value.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () => controller.updateOptions(1),
                        child: const Text("+")),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Correct Options :',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
          ),
          const SizedBox(
            height: 16,
          ),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.start,
            spacing: 8,
            children: [
              ...controller.availableOptions
                  .sublist(0, controller.options.value)
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
                                    value: controller.correctAnswers
                                        .contains(option),
                                    onChanged: (value) {
                                      controller.selectAnswer(option);
                                    },
                                  ),
                                  Text(option,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ],
                              )),
                        ),
                      ))
                  .toList(),
            ],
          ),
        ],
      );
    });
  }
}
