




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat_dio/textModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';


class Chat extends StatefulWidget {
  final String nickName;
  final String idioma;
  const Chat({super.key, required this.nickName, required this.idioma});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final db = FirebaseFirestore.instance;
  final textController = TextEditingController();
  String userId = '';

  @override
  void initState() {
    super.initState();
    carregarUsuario();
  }

  void carregarUsuario() async{
    final prefs = await SharedPreferences.getInstance();
    var uuid = const Uuid();
    userId = prefs.getString('user_id')?? uuid.v4();
    setState(() {
      
    });
  }

  void orderMsg(List<TextModel> msg) {
  msg.sort((a, b) => a.dataHora.compareTo(b.dataHora));
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat', style: TextStyle(color: Colors.white),), backgroundColor:  Theme.of(context).colorScheme.inversePrimary,),
      body: Column(
        children: [
          Expanded(child: StreamBuilder<QuerySnapshot>(
            stream: db.collection('chats_${widget.idioma}').snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData?const Center(child: 
              CircularProgressIndicator()):
              ListView(
                children: snapshot.data!.docs.map(
                  (e){
                   
                    var textModel = TextModel.fromJson(e.data() as Map<String, dynamic>);
                    return Align(
                      alignment: userId == textModel.userId?Alignment.centerRight:Alignment.topLeft,
                      child: Container(
                        
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                           color: textModel.userId==userId? Colors.green[400]:Colors.blue[400]),
                      child: Column(
                        crossAxisAlignment: userId == textModel.userId?CrossAxisAlignment.end:CrossAxisAlignment.start,
                        children: [
                          Text(textModel.nickname!, style: const TextStyle(color: Colors.white, fontSize: 10, ),),
                          Text(textModel.text!, style: const TextStyle(color: Colors.white),),
                        ],
                      ),
                                        ),
                    );
                  }
                  
                  ).toList()
              );
            }
          )),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Container(
            
              padding: const EdgeInsets.only(left: 16),
              decoration: BoxDecoration(border: Border.all(color: Colors.green[700]!, width: 1.5), borderRadius: BorderRadius.circular(12), ),
              child: Row(
                children: [
                   Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(border: InputBorder.none,),
                    ),
                  ),
                  IconButton(onPressed: ()async{
                    var chatModel = TextModel(
                      text: textController.text, 
                      userId: userId,
                      nickname: widget.nickName);

                    await db.collection('chats_${widget.idioma}').add(chatModel.toJson());


                  }, icon:  Icon(Icons.send, color: Colors.green[400]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
