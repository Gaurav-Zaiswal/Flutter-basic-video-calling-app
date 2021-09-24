import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gradient_colors/flutter_gradient_colors.dart';

class CreateMeeting extends StatefulWidget {
  const CreateMeeting({Key? key}) : super(key: key);

  @override
  _CreateMeetingState createState() => _CreateMeetingState();
}

class _CreateMeetingState extends State<CreateMeeting> {
  String meetingPasscode = "";

  generatePasscode() {
    // gererate 6 gigit random code
    String randomNum = "";
    var numberRng = Random();
    while (randomNum.length < 6) {
      randomNum = numberRng.nextInt(10000000).toString();
      if (randomNum.length > 6) {
        randomNum = randomNum.substring(0, 6);
      }
    }
    // return randomNum;
    setState(() {
      meetingPasscode = randomNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20),
            child: const Text(
              "Create Passcode for Meeting:",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 25,
                color: Colors.blue,
              ),
              // textAlign: TextAlign.center
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Passcode: ",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  color: Colors.blue,
                ),
              ),

              // TODO: write the generated code here
              Text(
                meetingPasscode,
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          // creating button to generate passcode
          InkWell(
            onTap: () => generatePasscode(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: GradientColors.darkOcean),
              ),
              child: const Center(
                child: Text(
                  "Generate Code",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
