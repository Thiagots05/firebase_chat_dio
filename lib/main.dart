import 'package:firebase_chat_dio/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Firebase DIO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[700]!),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Chat Firebase DIO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nickNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(color: Colors.white),),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           const Text(
            'Informe seu apelido:',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: nickNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder( borderSide:const BorderSide(color: Colors.black87), borderRadius: BorderRadius.circular(12))
              ),
            ),
          ),
          ElevatedButton(
           
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>Chat(nickName: nickNameController.text)));
      
          },
          
          child: const  Text('Iniciar chat', style: TextStyle(fontWeight: FontWeight.w700,),))
          
        ],
      ),

    );
  }
}
