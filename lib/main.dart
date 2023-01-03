import 'package:flutter/material.dart';
import './views/guest/Guest.dart';
import './views/host/Host.dart';
import './views/host/Scanner.dart';
import './views/guest/GuestPage.dart';
import './views/host/HostHomepage.dart';
import './views/host/HostSecondryPage.dart';
import './httpServer/HttpServer.dart';
import '/views/host/ListWidget.dart';
import './views/host/MainMenu.dart';
import './views/host/Salon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/MainMenu',
        routes: {
          '/MainMenu': (context) =>  MainMenu(),
          '/Scanner': (context) =>  ScannerWidget(),
          '/Host' :  (context) => Host(),
          '/Guest' :  (context) => Guest(),
          '/Salon' :  (context) => Salon(),
          '/Http_Server' : (context) => Http_Server(),
          '/GuestPage' : (context) => GuestPage(),
          '/HostHomepage' : (context) => HostHomepage(),
          '/ListWidget' : (context) => ListWidget(),
          '/RecordToStreamExample' : (context) => RecordToStreamExample(),
        });
  }
}

       // home:const SwitchView(),
