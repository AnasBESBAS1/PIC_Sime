import 'package:flutter/material.dart';
import '../../httpServer/HttpCommunication.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidget();
}

class _ListWidget extends State<ListWidget> {
  late Communication comm;
  TextEditingController nameController = TextEditingController();
  String nameValue = "";


  @override
  void initState() {
    createComm();
    super.initState();
  }

  Future<void> createComm() async {
    comm = Communication(
      onUpdate: () {
        setState(() {});
      },
    );
    await comm.startServe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("List"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: const [
                  Text("List"),
                  Text("List"),
                  Text("List"),
                  Text("List"),
                  Text("List"),
                ],
              ),
            )));
  }
}
