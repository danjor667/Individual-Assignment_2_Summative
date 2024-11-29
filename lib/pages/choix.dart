import 'package:flutter/material.dart';


class Choix extends StatelessWidget {
  int i;
  Choix(this.i, {super.key});
  //
  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linafoot"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(
                    //color: Colors.black,
                    ),
                text:
                    "Aute consequat dolor qui quis ullamco aliquip enim voluptate irure sint proident aliquip nisi eu.\n",
                children: [
                  TextSpan(
                      text:
                          """Consectetur sunt consequat nisi aliquip amet laboris laborum anim labore exercitation excepteur laborum reprehenderit duis. Esse sit officia dolor qui fugiat tempor quis nostrud consectetur laborum. Consequat amet ex eiusmod enim ea quis tempor fugiat amet nostrud consectetur. Ad laboris anim culpa cupidatat duis. Commodo commodo mollit duis cupidatat.

Tempor id fugiat ut excepteur voluptate ut reprehenderit elit ut adipisicing irure et. Incididunt laborum ipsum incididunt eu labore eiusmod voluptate. Exercitation adipisicing veniam et eu sit qui incididunt sint tempor culpa est do. Fugiat ipsum Lorem ut aute mollit adipisicing aliqua excepteur nulla et amet. In ex laboris commodo eiusmod commodo fugiat pariatur. Irure occaecat ipsum ullamco exercitation ad occaecat.

Consequat amet velit nostrud adipisicing mollit in dolore ipsum et qui excepteur labore sint. Commodo nulla magna elit qui ex qui veniam sunt reprehenderit aliquip anim. Commodo laboris adipisicing sit duis commodo ex sint anim non aliquip deserunt. Enim amet commodo deserunt eu officia aute nostrud voluptate laborum irure."""),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // if (i == 1) {
                //   Get.to(CommissaireFormulaire());
                // }
                // if (i == 2) {
                //   Get.to(HarbitreRapport());
                // }
                // if (i == 3) {
                //   Get.to(OfficierRapport());
                // }
                //

                //
                //
              },
              child: Container(
                height: 70,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text(
                  "Commencer",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
