import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../splashPage.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("a");
  }

  TextEditingController _controller = TextEditingController();
  String value="";
  void control(){
    _controller.text.isEmpty
        ? value="Lütfen boş bırakmayın !"
        : Get.to(splashPage(nameValue: _controller.text,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "İsminizi giriniz",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Opacity(
                opacity: 0.5,
                child: Text(
                  "Kimseyle paylaşmayacağımıza emin olabilirsiniz .",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height*0.15,),
            Container(
              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.07,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "İSMİNİZ :",

                ),
              ),
            ),
            Text(value,style: TextStyle(color: Colors.red, fontSize: 15),),
            SizedBox(height: MediaQuery.of(context).size.height*0.1,),
            GestureDetector(
              onTap: (){
                setState(() {
                  control();
                });
              },
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                height: MediaQuery.of(context).size.height*0.07,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text("\nSonraki",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 15,)),
              ),
            )
          ],
        ),
      ),
    );
  }
}