import 'package:flutter/material.dart';


class PaiementSababalar extends StatelessWidget {
  //
  PageController controller = PageController();

  PaiementSababalar({super.key});
  //
  @override
  Widget build(BuildContext context) {
    //

    //
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/sababalar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/sababalar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/sababalar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/sababalar.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: "00243 ",
                  prefixIcon: const Icon(Icons.phone_android),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
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
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: ExactAssetImage("assets/49YTv0_o_400x400.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: ExactAssetImage("assets/640px-M-pesa-logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: ExactAssetImage("assets/images.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: ExactAssetImage("assets/Orange-Money-logo.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
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
                  "Payer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
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
