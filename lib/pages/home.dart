import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _addMessage = '';
  List todoList = [];

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();

    initFirebase();

    todoList.addAll(['Морковь', 'Лук', 'Перец', 'Сделать дела']);
  }

  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
      return Scaffold(
        appBar: AppBar(title: Text('menu kuku', style: TextStyle(fontSize: 14, color: Colors.white),),), //если поменять класс, то эффект окрытия будет другой
        body: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
                icon: Icon(Icons.backspace_rounded, size: 30, color: Colors.green[400],)),
            Padding(padding: EdgeInsets.only(left: 40)),
            Text('menu kek', style: TextStyle(fontSize: 14, color: Colors.black),)
          ],
        )
      );
    })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text('Alo kuku'),
        centerTitle: true,
        actions: [IconButton(onPressed: _menuOpen,
            icon: Icon(Icons.menu_sharp))
        ],
      ),
      body: StreamBuilder( //<QuerySnapshot<Map<String, dynamic>>> ставиться после StreamBuilder
        stream: FirebaseFirestore.instance.collection('Deals').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Center(
              child: //Text('123132')
              CircularProgressIndicator(),
            );
            //Text('Нет записей');
          }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  // return ListTile(
                  //   title: Text(
                  //     snapshot.data!.docs[index].get('item'),
                  //   ),
                  // );
                  return Dismissible(
                    key: //UniqueKey(),
                        //ObjectKey(snapshot.data?.docs[index].id),
                      Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index].get('item')), //Text(todoList[index]),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red[700],
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('Deals').doc(snapshot.data!.docs[index].id).delete();
                            // setState(() {
                            //   todoList.removeAt(index);
                            // });
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      //if(direction == DismissDirection.endToStart)
                      FirebaseFirestore.instance.collection('Deals').doc(snapshot.data!.docs[index].id).delete();
                      // setState(() {
                      //   todoList.removeAt(index);
                      // });

                    },
                  );
                });
        },

      ),
      /*ListView.builder(
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
          }),*/
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyanAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          _addMessage = '';
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Добавить элемент'),
                  content: TextField(
                    onChanged: (String value) {
                      setState(() {
                        _addMessage = value;
                      });
                    },
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          if (_addMessage != '') {

                            FirebaseFirestore.instance.collection('Deals').add({'item': _addMessage});
                            /*setState(() {
                              todoList.add(_addMessage);
                            }
                            );*/
                          }
                          Navigator.of(context).pop();
                        },
                        child: const Text('Добавить'))
                  ],
                );
              });
        },
      ),
    );
  }
}
