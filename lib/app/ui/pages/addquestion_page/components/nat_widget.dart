import 'package:flutter/material.dart';
import 'package:gatator/app/controllers/addquestion_controller.dart';
import 'package:gatator/app/ui/global_widgets/custom_form_field.dart';
import 'package:get/get.dart';

class NATAnswerWidget extends StatelessWidget {
  NATAnswerWidget({Key? key}) : super(key: key);

  final AddQuestionController controller = Get.find<AddQuestionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Answer Range :',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text(
              'From :  ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            CustomFormField(controller: controller.natFromController),
            const SizedBox(
              width: 10,
            ),
            Text(
              'To :  ',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            CustomFormField(
              controller: controller.natToController,
            )
          ],
        ),
      ],
    );
  }
}
