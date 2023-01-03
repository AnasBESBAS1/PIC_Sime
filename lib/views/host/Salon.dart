import 'package:flutter/material.dart';
import '../../httpServer/HttpCommunication.dart';

class Salon extends StatefulWidget {
  const Salon({super.key});

  @override
  State<Salon> createState() => _Salon();
}

class _Salon extends State<Salon> {
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
          title: const Text("Salon"),
          backgroundColor: Colors.black,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Center(
                      child: Text(
                        'One last step ..',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your Name',
                        hintText: "ex : Tito",
                      ),
                      onChanged: (text) {
                        setState(() {
                          nameValue = nameController.text;
                        });
                      },
                    ),
                  ),
                  Text(
                    "name to send : $nameValue",
                    style: const TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(80),
                          backgroundColor: Colors.black,
                        ),
                        onPressed: () {
                          comm.sendMessage(nameValue);
                          Navigator.pushNamed(context, '/GuestPage');
                          const Icon(Icons.arrow_forward_ios);
                        },
                        child: const Text(
                          'Enter',
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
