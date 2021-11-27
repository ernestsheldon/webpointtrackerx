import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [

            Expanded(
              flex: 4,
              child: Image.asset(
                "maxresdefault.jpg",scale: 1.0,),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email here',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  hintText: 'Enter Password Here',
                ),
              ),
            ),
            SizedBox(width: 20,),
            Container(child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 20,),
                Expanded(
                  flex: 4,
                    child: ElevatedButton(child: Text("login"),onPressed: () {},)),
                SizedBox(width: 20,),
                Expanded(
                    flex: 4,
                    child: ElevatedButton(child: Text("Create Account"),onPressed: () {},)),
                SizedBox(width: 20,),
              ],
            ))



          ],
        ),
      ),

    );
  }
}
