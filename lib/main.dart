import 'package:country_flags/country_flags.dart';
import 'package:firebase_chat_dio/chat.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
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
      title: 'Chat Lang',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green[700]!),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ChatTo ME'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void selectRoom({required BuildContext context,required String idioma,required String nickName}){
  Navigator.push(context, MaterialPageRoute(builder: (_)=>Chat(nickName: nickName, idioma: idioma,)));
}

class _MyHomePageState extends State<MyHomePage> {
  var nickNameController = TextEditingController();
  var idiomas = <String, String>{'Ingles':'EN', 'Frances':'FR', 'Espanhol':'ES'};


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(8),
                height: 230,
                child: Image.asset('assets/images/lang.jpg', fit: BoxFit.fill)),
            ),
            const Text(
              'Informe seu apelido:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: TextField(
                controller: nickNameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black87),
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            const Text(
              'Informe a sala:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15,),
            Expanded(
              child: ListView(
                children: [
                  InkWell(
                    onTap: (){
                      selectRoom(context: context, idioma: idiomas['Frances']!, nickName: nickNameController.text);
                    },
                    child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CountryFlag.fromCountryCode(
                                'FR',
                                shape: const Circle(),
                              ),
                            ),
                            SizedBox(width: 20,),
                            const Text(
                              'Francês',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      selectRoom(context: context, idioma: idiomas['Ingles']!, nickName: nickNameController.text);
                    },
                    child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CountryFlag.fromCountryCode(
                                'US',
                                shape: const Circle(),
                              ),
                            ),
                            SizedBox(width: 20,),
                            const Text(
                              'Inglês',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        
                      ),
                    ),
                  ),
                   InkWell(
                    onTap: (){
                      selectRoom(context: context, idioma: idiomas['Espanhol']!, nickName: nickNameController.text);
                    },
                     child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CountryFlag.fromCountryCode(
                                'ES',
                                shape: const Circle(),
                              ),
                            ),
                            SizedBox(width: 20,),
                            const Text(
                              'Espanhol',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        
                      ),
                                       ),
                   )
                ],
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (_) =>
            //                   Chat(nickName: nickNameController.text)));
            //     },
            //     child: const Text(
            //       'Iniciar chat',
            //       style: TextStyle(
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
