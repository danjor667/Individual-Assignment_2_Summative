import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../programme/programme_controller.dart';
import 'live.dart';

class Direct extends StatefulWidget {
  const Direct({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Direct();
  }
}

class _Direct extends State<Direct> {
  //
  ProgrammeController programmeController = Get.find();

  @override
  void initState() {
    super.initState();
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      body: FutureBuilder(
        future: programmeController.getCalendrier(),
        builder: (c, t) {
          //
          if (t.hasData) {
            var id = t.data as int;
            print("id: $id");
            return Container(
              child: Live('$id'),
            );
          } else if (t.hasError) {
            return Container();
          }
          return Center(
            child: Container(
              height: 40,
              width: 40,
              child: const CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
