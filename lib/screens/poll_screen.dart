import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({super.key});

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Polls'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(96.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  vote(false);
                },
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Icon(Icons.icecream), Text('Ice-cream')]),
              ),
              ElevatedButton(
                onPressed: () {
                  vote(true);
                },
                child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [Icon(Icons.local_pizza), Text('Pizza')]),
              ),
            ],
          ),
        ));
  }

  Future<void> vote(bool voteForPizza) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    CollectionReference polls = db.collection('poll');

    QuerySnapshot snapshot = await polls.get();

    List<QueryDocumentSnapshot> docs = snapshot.docs;

    DocumentSnapshot poll = docs.first;
    final id = poll.id;

    if (voteForPizza) {
      await polls.doc(id).update({
        'pizza': FieldValue.increment(1),
      });
    } else {
      await polls.doc(id).update({
        'icecream': FieldValue.increment(1),
      });
    }
  }
}
