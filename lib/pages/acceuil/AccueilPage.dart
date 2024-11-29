import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../affiche/AfficheItem.dart';
import '../programme/programme_controller.dart';
import 'widgets/CarouselWidget.dart';
import 'widgets/EquipesWidget.dart';

class AccueilPage extends StatefulWidget {
  @override
  _AccueilPageState createState() => _AccueilPageState();
}

class _AccueilPageState extends State<AccueilPage> {
  final ProgrammeController programmeController = Get.find();
  final ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_onScroll);
    if (programmeController.affiches.isEmpty) {
      programmeController.getAfficher(programmeController.currentCalendrierId.value);
    }}

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 100,
          width: 150,
          child: Image.asset(
            'assets/mylinafoot2logo.png',
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.notifications_sharp),
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 80, 80),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 255, 249, 249),
      body: Column(
        children: [
          CarouselWidget(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Equipes',
                  style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  'VOIR TOUT',
                  style: TextStyle(color: Color(0xFF3A3838), fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          EquipesWidget(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Rencontres',
                  style: TextStyle(color: Color(0xFF3A3838), fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
          Expanded(
            flex: 1,
            child: Obx(
                  () => ListView.builder(
                controller: _scrollController,
                itemCount: programmeController.affiches.length + (programmeController.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < programmeController.affiches.length) {
                    return AfficheItem(programmeController.affiches[index]);
                  } else if (programmeController.hasMore) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onScroll() {
    if (_isBottom && !programmeController.isLoading && programmeController.hasMore) {
      programmeController.getAfficher(programmeController.currentCalendrierId.value);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}