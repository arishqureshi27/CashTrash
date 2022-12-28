import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/item_card.dart';

class PriceList extends StatelessWidget {
  const PriceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('category').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (!streamSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          streamSnapshot.data!.docs[index]['categoryName'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 160,
                        child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('category')
                                .doc(streamSnapshot.data!.docs[index].id)
                                .collection(streamSnapshot.data!.docs[index]
                                    ['categoryName'])
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, ind) {
                                    return ItemsCard(
                                        name: snapshot.data!.docs[ind]
                                            ['trashName'],
                                        price: snapshot.data!.docs[ind]
                                            ['trashPrice'],
                                        image: snapshot.data!.docs[ind]
                                            ['trashPic']);
                                  });
                            }),
                      )
                    ],
                  );
                },
                itemCount: streamSnapshot.data!.docs.length);
          },
        ),
      ),
    );
  }
}
