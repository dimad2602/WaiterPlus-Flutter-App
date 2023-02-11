import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _addMessage = '';
  List todoList = [];

  @override
  void initState() {
    super.initState();

    todoList.addAll(['Морковь', 'Лук', 'Перец', 'Сделать дела']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[200],
        appBar: AppBar(
          title: Text('Alo kuku'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                child: Card(
                  child: ListTile(
                    title: Text(todoList[index]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.red[700],
                      ),
                      onPressed: () {
                        setState(() {
                          todoList.removeAt(index);
                        });
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  //if(direction == DismissDirection.endToStart)
                  setState(() {
                    todoList.removeAt(index);
                  });
                },
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.cyanAccent,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          onPressed: (){
            _addMessage = '';
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Text('Добавить элемент'),
                content: TextField(
                  onChanged: (String value){
                      setState(() {
                          _addMessage = value;
                      });
                  },
                ),
                actions: [
                  ElevatedButton(onPressed: (){
                    if (_addMessage != ''){
                      setState(() {
                        todoList.add(_addMessage);
                      });
                    }
                    Navigator.of(context).pop();
                  }, child: const Text('Добавить'))
                ],
              );
            });
          },
        ),
    );
  }
}
