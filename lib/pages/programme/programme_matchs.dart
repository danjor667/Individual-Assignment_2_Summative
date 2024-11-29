import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'programme_controller.dart';
import 'programme_journee.dart';

class ProgrammeMatchs extends StatefulWidget {
  final String idCalendrier;
  final String categorie;

  ProgrammeMatchs(this.idCalendrier, this.categorie, {Key? key}) : super(key: key);

  @override
  _ProgrammeMatchsState createState() => _ProgrammeMatchsState();
}

class _ProgrammeMatchsState extends State<ProgrammeMatchs> with SingleTickerProviderStateMixin {
  late ProgrammeController programmeController;
  RxInt Jn = 0.obs;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    programmeController = Get.find<ProgrammeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      load();
    });
  }

  Future<void> load() async {
    try {
      List l = await programmeController.getAllJourneeDeLaSaison(
          widget.idCalendrier, widget.categorie);

      if (l.isNotEmpty) {
        setState(() {
          Jn.value = l.length;
          _initializeTabController();
        });
      } else {
        setState(() {
          Jn.value = 1; // Au cas où aucune journée n'est disponible
          _initializeTabController();
        });
      }
    } catch (e) {
      print("Erreur lors du chargement des journées : $e");
      setState(() {
        Jn.value = 0; // Aucun match disponible
      });
    }
  }

  void _initializeTabController() {
    if (Jn.value > 0) {
      _tabController = TabController(length: Jn.value, vsync: this);
      setState(() {});
    } else {
      print("Error: Jn value is 0, cannot initialize TabController");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Jn.value == 0 || _tabController == null
        ? const Center(child: CircularProgressIndicator())
        : DefaultTabController(
      length: Jn.value,
      initialIndex: programmeController.journee.value > 0
          ? programmeController.journee.value - 1
          : 0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Obx(() => Align(
              alignment: Alignment.center,
              child: Container(
                color: Color(0xFFF0F0F0), // Très proche du blanc
                child: TabBar(
                  tabAlignment: TabAlignment.start,
                  labelColor: Colors.black,
                  unselectedLabelColor: Color.fromARGB(255, 255, 80, 80),
                  isScrollable: true,
                  labelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold,),
                  controller: _tabController,
                  //isScrollable: true,
                  tabs: List.generate(
                    Jn.value,
                        (index) => Tab(
                      text: "Jn ${index + 1}",
                    ),
                  ),
                ),
              ),
            )),
            Expanded(
              flex: 1,
              child: Obx(() => TabBarView(
                controller: _tabController,
                children: List.generate(
                  Jn.value,
                      (e) {
                    print("response Jn $e");
                    return ProgrammeJournee(
                      widget.idCalendrier,
                      widget.categorie,
                      e + 1,
                      key: UniqueKey(),
                    );
                  },
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
