import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'processus2.dart';

class Processus3 extends StatelessWidget {
  //
  int limite = 0;
  RxList chiffres = [].obs;

  Processus3({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(5),
              //height: 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "N° Selectionnés",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    height: 65,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(chiffres.length, (index) {
                          return Container(
                            height: 20,
                            width: 20,
                            alignment: Alignment.center,
                            child: Text(
                              "${chiffres[index]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.yellow.shade700,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: GridView.count(
                crossAxisCount: 7,
                children: List.generate(50, (index) {
                  //
                  RxBool s = false.obs;
                  //
                  return Obx(
                    () => Card(
                      elevation: 1,
                      color: s.value ? Colors.yellow.shade700 : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          //
                          s.value = !s.value;
                          if (s.value) {
                            //
                            if (limite < 6) {
                              limite++;
                              chiffres.add(index + 1);
                            } else {
                              s.value = !s.value;
                              Get.snackbar(
                                  "Oups", "Le nombre de chifre atteint!");
                            }
                          } else {
                            //
                            limite--;
                            //
                            chiffres.remove(index + 1);
                            //
                          }
                          print("chiffres: $chiffres");
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "${index + 1}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: 45,
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  //Processus2
                  if (chiffres.length == 6) {
                    Get.dialog(const Center());
                    //
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (builder) {
                          return Processus2(chiffres);
                        },
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.yellow.shade700),
                  tapTargetSize: MaterialTapTargetSize.padded,
                  fixedSize: MaterialStateProperty.all(
                    const Size(300, 48),
                  ),
                  maximumSize: MaterialStateProperty.all(
                    const Size(300, 48),
                  ),
                ),
                child: const Text(
                  "Suivant",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  //
}
