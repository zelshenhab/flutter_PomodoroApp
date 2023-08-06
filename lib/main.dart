// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sort_child_properties_last, unused_import

import 'package:flutter/material.dart';
import "dart:async";
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CounteDown(),
    );
  }
}

class CounteDown extends StatefulWidget {
  const CounteDown({super.key});

  @override
  State<CounteDown> createState() => _CounteDownState();
}

class _CounteDownState extends State<CounteDown> {
  Timer? repeatedFunction;
  Duration duration = Duration(minutes: 25);

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newSeconds = duration.inSeconds - 1;
        duration = Duration(seconds: newSeconds);
        if (duration.inSeconds == 0) {
          repeatedFunction!.cancel();
          setState(() {
            duration = Duration(minutes: 25);
            isRunning = false;
          });
        }
      });
    });
  }

  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 52, 58, 61),
          title: Text(
            "Pomodoro App",
            style: TextStyle(
                fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 33, 40, 43),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 130,
                  progressColor: Color.fromARGB(255, 255, 85, 113),
                  backgroundColor: Color.fromARGB(255, 254, 254, 254),
                  lineWidth: 8.0,
                  percent: duration.inMinutes / 25,
                  animation: true,
                  animateFromLastPercent: true,
                  animationDuration: 1000,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                        style: TextStyle(fontSize: 80, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            isRunning
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (repeatedFunction!.isActive) {
                            setState(() {
                              repeatedFunction!.cancel();
                            });
                          } else {
                            startTimer();
                          }
                        },
                        child: Text(
                          (repeatedFunction!.isActive) ? "Stop" : "Resume",
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.pink),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(15)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            repeatedFunction!.cancel();
                            setState(() {
                              duration = Duration(minutes: 25);
                              isRunning = false;
                            });
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.pink),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(15)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12)))),
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 20),
                          )),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      startTimer();
                      setState(() {
                        isRunning = true;
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 25, 120, 197)),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)))),
                    child: Text(
                      "Start Studing",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
          ],
        ));
  }
}
