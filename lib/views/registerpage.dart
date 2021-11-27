import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:webpointtracker/controllers/auth_controller.dart';
import 'package:webpointtracker/views/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Email here',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: TextField(
                controller: passwordController,
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
                    child: ElevatedButton(child: Text("Create Account"),onPressed: () {
                      AuthController.instance.register(emailController.text.trim(), passwordController.text.trim());

                    },)),
                SizedBox(width: 20,),
                SizedBox(width: 20,),
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Text(" have and account?"),

                      GestureDetector(
                        onTap: (){
                          Get.offAll(() => LoginPage());
                        },
                        child: Text("Sing In",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w900)
                        ),
                      )],
                  ),
                ),
                SizedBox(width: 20,),
              ],
            ))



          ],
        ),
      ),

    );
  }
}
