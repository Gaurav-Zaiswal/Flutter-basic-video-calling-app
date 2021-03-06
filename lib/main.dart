// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_conference/screens/videoconferencescreen.dart';
import 'package:video_conference/videoconference/createmeeting.dart';
import 'package:video_conference/videoconference/joinmeeting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Welcome to Flutter',

      // home: 
      initialRoute: "/",

      getPages: [
        GetPage(name: '/', page: ()=>const  VideoConferenceScreen()),
        GetPage(name: '/create-meeting', page: ()=>const  CreateMeeting()),
        GetPage(name: '/join-meeting', page: ()=>const  JoinMeeting())
      ],
    );
  }
}
