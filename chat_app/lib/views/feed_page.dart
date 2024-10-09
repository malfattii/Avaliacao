import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatefulWidget {
  FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto
      appBar: AppBar(
        title: Text('Feedbacks'),
        centerTitle: true,
        backgroundColor: Colors.black, // Mantém a coerência com o fundo
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Feedbacks').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar feedbacks',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return Center(
              child: Text(
                'Nenhum feedback disponível',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.white, // Linha de separação branca
            ),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(),
                title: Text(
                  snapshot.data.docs[index]['username'],
                  style: TextStyle(color: Colors.white), // Texto branco
                ),
                subtitle: Text(
                  snapshot.data.docs[index]['message'],
                  style: TextStyle(color: Colors.white), // Texto branco
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 30,
        color: const Color.fromARGB(255, 242, 238, 238),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirestoreService().postFeedback(
                        messageController.text,
                      );
                      messageController.clear();
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Icon(Icons.send),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
