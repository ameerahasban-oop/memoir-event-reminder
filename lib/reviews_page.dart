import 'package:flutter/material.dart';
import 'review_service.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() =>
      _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {

  Future<List<dynamic>> loadReviews() async {
    return await ReviewService.getReviews();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("User Reviews"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<List<dynamic>>(

        future: loadReviews(),

        builder: (context, snapshot) {

          if (snapshot.connectionState ==
              ConnectionState.waiting) {

            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData ||
              snapshot.data!.isEmpty) {

            return const Center(
              child: Text("No reviews yet"),
            );
          }

          final reviews = snapshot.data!.reversed.toList();

          return ListView.builder(

            itemCount: reviews.length,

            itemBuilder: (context, index) {

              final item = reviews[index];

              return Card(

                margin: const EdgeInsets.all(10),

                child: Padding(

                  padding: const EdgeInsets.all(15),

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(
                        item["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [

                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),

                          const SizedBox(width: 5),

                          Text(
                            item["rating"].toString(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        item["review"],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        item["date"].toString(),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}