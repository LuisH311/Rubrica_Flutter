import 'package:crud/db/operation.dart';
import 'package:crud/models/note.dart';
import 'package:crud/pages/save_page.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  static const String ROUTE = "/";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, SavePage.ROUTE /* arguments: Note.empty() */);
        },
      ),
      appBar: AppBar(
        title: const Text("Listado"),
      ),
      body: Container(
          child: _MyList()),
    );
  }
}

class _MyList extends StatefulWidget {
 
  @override
  State<_MyList> createState() => _MyListState();
}

class _MyListState extends State<_MyList> {
  List<Note> notes = [];

  @override
  void initState() {
    _loadData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(

      itemCount: notes.length,
      itemBuilder: (_, i) => createItem(i),
    );
  }

  _loadData() async{

    List<Note> auxNote = await Operation.notes();

    setState(() {
       notes = auxNote;
    });
     
  }

  createItem(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 5),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white,)),
        ),
      onDismissed: (direction){
        print(direction);
        Operation.delete(notes[i]);
      },
      
      child: ListTile(
        title: Text(notes[i].title),
        trailing: MaterialButton(
          onPressed: (){
            Navigator.pushNamed(context, SavePage.ROUTE, arguments: notes[i]);
          },
          child: Icon(Icons.edit)),
      ),
    );
}
}



