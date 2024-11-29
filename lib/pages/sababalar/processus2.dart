import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'paiement_sababalar.dart';

class Processus2 extends StatelessWidget {
  List chiffres;

  Processus2(this.chiffres, {super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Vos 6 chiffres',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              '${chiffres[0]} - ${chiffres[1]} - ${chiffres[2]} - ${chiffres[3]} - ${chiffres[4]} - ${chiffres[5]}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                //
                Get.to(PaiementSababalar());
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
                "Payer",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                //
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
                "Jouez au numéro million",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                //
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
                "Agent revendeur",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                //
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
                "Annuler",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
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
