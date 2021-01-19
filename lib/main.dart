import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartpluspharma/views/GettingStarted.dart';

//void main() => runApp(MyApp());
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
    .then((_) {
      runApp(new MyApp());
    });
}
// void main(){
//   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//     .then((_) {
//       runApp(MyApp());
//     });
// } 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: GettingStarted(),
    );
  }
}

