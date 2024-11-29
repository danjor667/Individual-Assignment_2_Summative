import 'package:flutter/material.dart';

import 'processus3.dart';
import 'verification_sababalar.dart';

class Sababalar extends StatelessWidget {
  //
  PageController controller = PageController();

  Sababalar({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //

    //
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage("assets/sababalar.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Je + de 18 ans et j'accepte les conditions générales pour jouer. Jouez aussi suur wwww.sababalar.com",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return Processus3();
                    },
                  ),
                );
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
                "Jouez à Saba ba lar",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                //
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (builder) {
                      return const VerificationSababalar();
                    },
                  ),
                );
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
                "Vérification ticket",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      // body: PageView(
      //   controller: controller,
      //   pageSnapping: true,
      //   padEnds: true,
      //   children: [Processus1(), Processus2()],
      // ),
    );
  }
  //
}
