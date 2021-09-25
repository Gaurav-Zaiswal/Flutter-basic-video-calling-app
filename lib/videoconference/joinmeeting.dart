import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:jitsi_meet/feature_flag/feature_flag.dart';
// import 'package:flutter_gradient_colors/olors.dart';
// import 'package:get/get_state_maget_state_manager.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({Key? key}) : super(key: key);

  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController displayNameController = TextEditingController();
  TextEditingController roomEditingController = TextEditingController();
  bool hasAudio = true;
  bool isVideoOn = false;
  String username = '';

  @override
  void initState() {
    super.initState();

    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              const Text(
                "Enter Passcode:",
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                controller: roomEditingController,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                autoDisposeControllers: false,
                animationType: AnimationType.slide,
                keyboardType: TextInputType.number,
                animationDuration: const Duration(milliseconds: 200),
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                onChanged: (value) {},
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name (or leave to use default username)",
                  // labelStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Check both to join with video and audio turned on"),
              const SizedBox(height: 10),
              CheckboxListTile(
                  title: const Text("Video"),
                  value: isVideoOn,
                  onChanged: (value) {
                    setState(() {
                      isVideoOn = value!;
                    });
                  }),
              CheckboxListTile(
                  title: const Text("Audio"),
                  value: hasAudio,
                  onChanged: (value) {
                    setState(() {
                      hasAudio = value!;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "*these settings can be updated later",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                        fontSize: 10),
                  )
                ],
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () => enterinMeetingRoom(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      "Join Meeting",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  enterinMeetingRoom() async {
    // TODO:
    // set call integration enabled to flase for android
    // and pip enabled false for ios
    // instantiate jitsi options
    try {
      Map<FeatureFlagEnum, bool> featureflags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: true,
      };
      if (Platform.isAndroid) {
        featureflags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureflags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      // FeatureFlag featureFlag = FeatureFlag();
      // featureFlag.welcomePageEnabled = false;
      // featureFlag.resolution = FeatureFlagVideoResolution
      //     .LD_RESOLUTION; // Limit video resolution to 180p
      // if (Platform.isAndroid) {
      //   featureFlag.callIntegrationEnabled = false;
      // } else if (Platform.isIOS) {
      //   featureFlag.pipEnabled = false;
      // }
      String roomName = roomEditingController.text;
      var preferences = JitsiMeetingOptions(room: roomEditingController.text)
        ..userDisplayName = displayNameController.text == ""
            ? username
            : displayNameController.text
        ..audioMuted = hasAudio
        ..videoMuted = isVideoOn
      ..featureFlags.addAll(featureflags);

      //   ..featureFlag = featureFlag;

      // join the meeting with above preferences
      await JitsiMeet.joinMeeting(preferences);
    } catch (e) {
      // print("Could not join the meeting: $e");
      throw Exception("Exception occured white trying to join the meeting: $e");
    }
  }

  void getUserInfo() {
    setState(() {
      // Make this username dynamic
      username = "Ram Bahadur";
    });
  }
}
