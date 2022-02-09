import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/quizpage_controller.dart';

class QuizPage extends GetView<QuizPageController> {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
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
                  height: 20,
                ),
                // HtmlElementView(viewType: "img",)
                Image.network(controller.questions[0].question),
              ],
            );
          }
        }),
      ),
    );
  }
}
