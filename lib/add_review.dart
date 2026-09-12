import 'package:flutter/material.dart';
import 'review_service.dart';

class AddReviewPage extends StatefulWidget {
  const AddReviewPage({super.key});

  @override
  State<AddReviewPage> createState() =>
      _AddReviewPageState();
}

class _AddReviewPageState
    extends State<AddReviewPage> {

  TextEditingController reviewController =
  TextEditingController();

  int rating = 5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Write a Review"),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const Text(
              "Rate our Memoir App",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Tap a star to rate",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                    (index) => IconButton(
                  icon: Icon(
                    index < rating
                        ? Icons.star
                        : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      rating = index + 1;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(

              controller: reviewController,

              maxLines: 5,

              decoration: InputDecoration(

                hintText: "Write your review...",

                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  foregroundColor: Colors.white,
                ),

                onPressed: () async {

                  bool success =
                  await ReviewService.addReview(
                    review:
                    reviewController.text,
                    rating: rating.toString(),
                  );

                  if (success) {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Review submitted successfully!",
                        ),
                      ),
                    );

                    Navigator.pop(context);

                  } else {

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      const SnackBar(
                        content: Text(
                          "Failed To Submit Review",
                        ),
                      ),
                    );
                  }
                },

                child: const Text(
                  "Submit Review",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}