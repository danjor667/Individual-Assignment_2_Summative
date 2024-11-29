import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mylinafoot/pages/programme/programme_matchs.dart';
import 'package:mylinafoot/utils/loader.dart';
import 'programme_controller.dart';

class Programme extends GetView<ProgrammeController> {
  final ProgrammeController programmeController = Get.find();

  Programme({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Scaffold(
        //backgroundColor: Loader.backgroundColor,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Calendrier officiel du playoff",),
          centerTitle: true,
          //backgroundColor: Loader.backgroundColor,
          backgroundColor: Color.fromARGB(255, 255, 80, 80),
          bottom: PreferredSize(
            preferredSize: const Size(10, 40),
            child: Container(
              padding: const EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Acheter votre billet en cliquant sur le match",
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Obx(() {
                final idCalendrier = programmeController.currentCalendrierId.value;
                if (idCalendrier == 0) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ProgrammeMatchs('$idCalendrier', "playoff");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
