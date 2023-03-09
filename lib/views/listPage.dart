import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'incrementPage.dart';

class ListItem {
  String name;
  int number;

  ListItem(this.name, this.number);
}
class listPage extends StatefulWidget {
  const listPage({Key? key}) : super(key: key);

  @override
  State<listPage> createState() => _listPageState();
}

class _listPageState extends State<listPage> {
  List<ListItem> _items = [];
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  late SharedPreferences _prefs;


  @override
  void initState() {
    super.initState();
    _loadListItems();
  }
  //shared preferences fonksiyonları
  void _loadListItems() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _items = (_prefs.getStringList('list_items') ?? []).map((item) {
        List<String> split = item.split(':');
        return ListItem(split[0], int.parse(split[1]));
      }).toList();
    });
  }
  void _saveListItems() {
    List<String> items =
    _items.map((item) => '${item.name}:${item.number}').toList();
    _prefs.setStringList('list_items', items);
  }
  void _addListItem() {
    setState(() {
      _items.add(
          ListItem(_nameController.text, int.parse(_numberController.text)));
      _nameController.clear();
      _numberController.clear();
      _saveListItems();
    });
  }
  void _incrementNumber(int index) {
    setState(() {
      _items[index].number++;
      _saveListItems();
    });
  }

  // yeni veri eklenecek olan alert dialog
  void alert() {
    showDialog(
      context: context,
      builder: (context) {
        return Opacity(
          opacity: 0.7,
          child: AlertDialog(
            icon: Icon(Icons.cloud_outlined),
            actionsAlignment: MainAxisAlignment.start,
            title: Text('Sayaç Adı :'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Verilecek İsim :',
                  ),
                ),
                TextField(
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Adet :',
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send),
                      Text('Kaydet', textAlign: TextAlign.center),
                    ],
                  ),
                  onTap: (){
                    _addListItem();
                    Navigator.pop(context);}
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: alert,
                child: Container(
                  transformAlignment: Alignment.bottomCenter,
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      color: Colors.black,
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: Center(
                      child: Text(" YENİ\nSAYAÇ\nEKLE\n     +",
                          style: TextStyle(color: Colors.white))),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                          style: BorderStyle.solid)),
                  child: GestureDetector(
                    onTap: ()=>
                    {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => incrementPage(
                            initialValue: _items[index].number,
                            nameValue: _items[index].name,
                            onIncrement: () => _incrementNumber(index),
                          ),
                        ),
                      ),
                    },
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${_items[index].name}',
                              style: TextStyle(color: Colors.white)),
                          Opacity(
                              opacity: 0.7,
                              child: Row(
                                children: [
                                  Text('Adet: ${_items[index].number}',
                                      style: TextStyle(color: Colors.white)),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _items.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}