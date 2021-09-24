import 'package:flutter/material.dart';
import 'package:video_conference/videoconference/createmeeting.dart';
import 'package:video_conference/videoconference/joinmeeting.dart';

class VideoConferenceScreen extends StatefulWidget {
  const VideoConferenceScreen({Key? key}) : super(key: key);

  @override
  _VideoConferenceScreenState createState() => _VideoConferenceScreenState();
}

class _VideoConferenceScreenState extends State<VideoConferenceScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  buildTabs(String tabName) {
    return Container(
      width: 150,
      height: 100,
      child: Card(
        child: Center(
          child: Text(
            tabName,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: const Text(
          "Aithon Classroom",
          style:
              TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            buildTabs("Join Meeting"),
            buildTabs("Create Meeting"),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
        JoinMeeting(),
        CreateMeeting()
      ]),
    );
  }
}
