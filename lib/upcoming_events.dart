import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'models/event.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpcomingEventsPage extends StatefulWidget {
  final List<Event> events;
  final Function(int) onDelete;
  final Function() onUpdate;


  const UpcomingEventsPage({
    super.key,
    required this.events,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  State<UpcomingEventsPage> createState() =>
      _UpcomingEventsPageState();
}

class _UpcomingEventsPageState
    extends State<UpcomingEventsPage> {

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage(
      int originalIndex,
      Event event,
      ) async {

    final XFile? image =
    await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {

        widget.events[originalIndex] =
            Event(
              name: event.name,
              date: event.date,
              location: event.location,
              imagePath: image.path,
              isFavorite: event.isFavorite,
            );
      });

      widget.onUpdate();
    }
  }

  void showEditDialog(
      int originalIndex,
      Event event) {

    TextEditingController nameController =
    TextEditingController(text: event.name);

    TextEditingController locationController =
    TextEditingController(text: event.location);

    TextEditingController dateController =
    TextEditingController(
      text: event.date
          .toLocal()
          .toString()
          .split(' ')[0],
    );

    DateTime selectedDate = event.date;

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(

          title: const Text(
            "Edit Event",
          ),

          content: StatefulBuilder(
            builder: (context, setDialogState) {

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: "Event Name",
                        prefixIcon: Icon(Icons.event),
                      ),
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: "Event Date",
                        prefixIcon:
                        Icon(Icons.calendar_month),
                      ),

                      onTap: () async {

                        DateTime? pickedDate =
                        await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {

                          setDialogState(() {

                            selectedDate = pickedDate;

                            dateController.text =
                            pickedDate
                                .toString()
                                .split(' ')[0];
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    TextField(
                      controller: locationController,
                      decoration: const InputDecoration(
                        labelText: "Location",
                        prefixIcon:
                        Icon(Icons.location_on),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              onPressed: () {

                setState(() {

                  widget.events[originalIndex] =
                      Event(
                        name: nameController.text,
                        date: selectedDate,
                        location:
                        locationController.text,
                        imagePath: event.imagePath,
                        isFavorite: event.isFavorite,
                      );
                });

                widget.onUpdate();

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final sortedEvents =
    List<Event>.from(widget.events);

    // nearest upcoming first
    sortedEvents.sort(
          (a, b) =>
          a.date.compareTo(b.date),
    );

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Upcoming Events",
        ),
        backgroundColor:
        Colors.brown,
        foregroundColor:
        Colors.white,
      ),

      body: sortedEvents.isEmpty

          ? const Center(
        child: Text(
          "No events added yet",
        ),
      )

          : ListView.builder(

        itemCount:
        sortedEvents.length,

        itemBuilder:
            (context, index) {

          final event =
          sortedEvents[index];

          int originalIndex =
          widget.events.indexOf(
              event);

          return Card(

            elevation: 4,

            margin:
            const EdgeInsets.all(
                10),

            shape:
            RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
                  15),
            ),

            child: Padding(

              padding:
              const EdgeInsets.all(
                  10),

                child: Column(

                    children: [

                    if (event.imagePath != null)
                ClipRRect(
                borderRadius:
                BorderRadius.circular(10),

            child: Image.file(
              File(event.imagePath!),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

              if (event.imagePath != null)
              const SizedBox(height: 10),

                  ListTile(

                    leading:
                    const CircleAvatar(
                      backgroundColor:
                      Colors.brown,

                      child: Icon(
                        Icons.event,
                        color:
                        Colors.white,
                      ),
                    ),

                    title: Text(
                      event.name,

                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),

                    subtitle: Column(

                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                      children: [

                        const SizedBox(
                          height: 5,
                        ),

                        Text(
                          " ${event.date.toLocal().toString().split(' ')[0]}",
                        ),

                        Text(
                          " ${event.location}",
                        ),
                      ],
                    ),
                  ),

                  const Divider(),

                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.end,

                    children: [

                      IconButton(
                        icon: const Icon(
                          Icons.cloud,
                          color:
                          Colors.blue,
                        ),

                        onPressed:
                            () async {

                          final weather =
                          await WeatherService
                              .getWeather(
                              event.location);

                          showDialog(
                            context:
                            context,

                            builder:
                                (_) =>
                                AlertDialog(

                                  title:
                                  const Text(
                                    "Today's Weather",
                                  ),

                                  content:
                                  Text(
                                    weather,
                                  ),

                                  actions: [

                                    TextButton(
                                      onPressed:
                                          () {
                                        Navigator.pop(
                                            context);
                                      },

                                      child:
                                      const Text(
                                          "OK"),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color:
                          Colors.orange,
                        ),

                        onPressed: () {
                          showEditDialog(
                            originalIndex,
                            event,
                          );
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.image,
                          color: Colors.purple,
                        ),

                        onPressed: () {
                          pickImage(
                            originalIndex,
                            event,
                          );
                        },
                      ),

                      IconButton(
                        icon: Icon(
                          event.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),

                        onPressed: () {

                          setState(() {

                            widget.events[originalIndex] = Event(
                              name: event.name,
                              date: event.date,
                              location: event.location,
                              imagePath: event.imagePath,
                              isFavorite: !event.isFavorite,
                            );

                          });

                          widget.onUpdate();
                        },
                      ),

                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color:
                          Colors.red,
                        ),

                        onPressed: () {
                          widget.onDelete(
                              originalIndex);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}