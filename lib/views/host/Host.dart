import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'dart:async';
import 'package:wifi_scan/wifi_scan.dart';

class Host extends StatefulWidget {
  const Host({super.key});

  @override
  State<Host> createState() => _Host();
}

class _Host extends State<Host> {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];

//**** icons
  @override
  void initState() {
    /// Call out to intialize platform state.
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  //***

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("PIC Network"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Text(
                        'Please Activate HotSpot',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        AppSettings.openHotspotSettings(
                          asAnotherTask: true,
                        );
                      },
                      child: const Text(
                        'Activate Hotspot',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.black, // Background color
                      ),
                      onPressed: () {
                        print("pressed");
                        Navigator.pushNamed(context, '/Scanner');
                        const Icon(Icons.arrow_forward_ios);
                      },
                      child: const Text(
                        'Scan network',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.grey, // Background color
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/HostHomepage');
                      },
                      child: const Text(
                          'Enter Host Salon',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }

  List<Widget> getListOfActionButtons() {
    var actionItems = <Widget>[];
    actionItems.addAll([
      ElevatedButton(
        child: Text("WIFI"),
        onPressed: () {
          AppSettings.openWIFISettings();
        },
      ),
      ElevatedButton(
        child: Text("Hotspot"),
        onPressed: () {
          AppSettings.openHotspotSettings(
            asAnotherTask: true,
          );
        },
      ),
    ]);

    return actionItems;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
