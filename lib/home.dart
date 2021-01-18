import 'package:check_mazdor/models/Database.dart';
import 'package:check_mazdor/models/mazdor.dart';
import 'package:check_mazdor/widget/mazdorAdd.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import './widget/insertTarikh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Mazdor> testMazdor = [
    Mazdor(name: "sahal", phoneNO: "345"),
    Mazdor(name: "ishaque", phoneNO: "344"),
    Mazdor(name: "Sarwan", phoneNO: "342"),
    Mazdor(name: "Ahmed", phoneNO: "3451"),
  ];
  void _addNewMazdor(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return MazdorAdd( forHomeState: forRunTheSet);
        });
  }

  void _insertTarikh(BuildContext ctx, int id)
  {
    showModalBottomSheet(context : ctx, builder:(_){
        return InsertTarikh(id:id, forHomeState: forRunTheSet);
    });
  }

   
   void forRunTheSet()
   {
     setState(() {
       
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mazdor App Clone"),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => _addNewMazdor(context)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Mazdor rnd = testMazdor[math.Random().nextInt(testMazdor.length)];
          await DBProvider.db.newMazdor(rnd);
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Mazdor>>(
        future: DBProvider.db.getAllMazdor(),
        builder: (BuildContext context, AsyncSnapshot<List<Mazdor>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Mazdor item = snapshot.data[index];
                  return Dismissible(
                      key: UniqueKey(),
                      background: Container(
                        color: Colors.green,
                      ),
                      onDismissed: (direction) {
                        DBProvider.db.deleteMazdor(item.id);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 35,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child:Text(item.id.toString()),
                            ),
                          ),
                        ),
                        subtitle: Text(item.tarikh.toString()),
                        title: FlatButton(
                          child: Text(item.name),
                          onPressed: () { _insertTarikh(context, item.id);
                          print(item.tarikh);
                          } ,
                        ),
                      ));
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
