
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'listPage.dart';

class incrementPage extends StatefulWidget {
  //list sayfasından gelen veriler
  final int initialValue;
  final String nameValue;
  final VoidCallback onIncrement;
//constructor olustur
  incrementPage(
      {
        required this.initialValue,
        required this.nameValue,
        required this.onIncrement});

  @override
  _incrementPageState createState() => _incrementPageState();
}

class _incrementPageState extends State<incrementPage> with SingleTickerProviderStateMixin {
  late int _value;
  late String _name;
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    // sayfa acılmadan hemen yüklensin
    _value = widget.initialValue;
    _name = widget.nameValue;
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
// value arttır fonsiyonu
  void _incrementValue() {
    setState(() {
      _value++;
      widget.onIncrement();
    });
  }
  // kaydet ve cık butonu
  void _goToListPage(){
    Get.offAndToNamed(listPage().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(alignment: Alignment.center,
                children: [
                  // animasyon widgeti
                  SpinKitDualRing(
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width*0.4,
                    duration: Duration(milliseconds: 1200),
                  ),
                  Column(
                      children: [
                        Text(
                          '⚕   $_value',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            '$_name',
                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ]),
                ]),
            SizedBox(height: MediaQuery.of(context).size.height*0.25),
            Column(
              children: [
                GestureDetector(
                  onTap: _goToListPage,
                  child: Container(
                      width:MediaQuery.of(context).size.width*0.5,
                      height: MediaQuery.of(context).size.height*0.07,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text("KAYDET VE ÇIK"))),),
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
                Container(
                  width:MediaQuery.of(context).size.width*0.2,
                  height: MediaQuery.of(context).size.width*0.2,
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.add,
                      size: MediaQuery.of(context).size.width*0.15,
                      color: Colors.black,),
                    onPressed: _incrementValue,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}