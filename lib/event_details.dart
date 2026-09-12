import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {

  final String eventName;
  final String eventDate;
  final String eventLocation;

  const EventDetailsPage({
    super.key,
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.pink[50],

      appBar: AppBar(

        title: const Text(
          "Event Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(

            elevation: 8,

            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(25),
            ),

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,

                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    "Successfully Saved!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(

                    padding:
                    const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Colors.brown[50],
                      borderRadius:
                      BorderRadius.circular(15),
                    ),

                    child: Column(

                      children: [

                        Text(
                          "Event Name",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Colors.brown[700],
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          eventName,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          textAlign:
                          TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Event Date",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Colors.brown[700],
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          eventDate,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          textAlign:
                          TextAlign.center,
                        ),

                        const SizedBox(height: 20),

                        Text(
                          "Event Location",
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                            color:
                            Colors.brown[700],
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          eventLocation,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          textAlign:
                          TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(

                    width: double.infinity,

                    child: ElevatedButton.icon(

                      style:
                      ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.brown,
                        foregroundColor:
                        Colors.white,
                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                        ),
                      ),

                      icon: const Icon(
                        Icons.arrow_back,
                      ),

                      label: const Text(
                        "Add Another Event",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),

                      onPressed: () {

                        Navigator.pop(
                          context,
                          'reset',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}