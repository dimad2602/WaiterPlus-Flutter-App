import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[200],
        appBar: AppBar(
          title: Text('Alo kuku'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const Text('Main screen', style: TextStyle(fontSize: 20, color: Colors.white),),
            ElevatedButton(
                onPressed: () {
                   Navigator.pushNamed(context, '/todo');
                  //Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false); //отключение стрелки назад
                  //Navigator.pushReplacementNamed(context, '/todo');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: //Text('Заметки'),
                    const Icon(
                  Icons.note_alt_rounded,
                  color: Colors.lightBlueAccent,
                  size: 40,
                ))
          ],
        ));
  }
}
