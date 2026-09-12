import 'package:flutter/material.dart';
import 'event_details.dart';
import 'models/event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class AddEventPage extends StatefulWidget {
  final Function(Event) onAddEvent;

  const AddEventPage({
    super.key,
    required this.onAddEvent,
  });

  @override
  State<AddEventPage> createState() =>
      _AddEventPageState();
}

class _AddEventPageState
    extends State<AddEventPage> {

  TextEditingController nameController =
  TextEditingController();

  TextEditingController dateController =
  TextEditingController();

  TextEditingController locationController =
  TextEditingController();

  Future<void> getCurrentLocation() async {
    try {
      print("Button clicked");

      Position? position;

      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      } catch (e) {
        print("Using last known location");

        position =
        await Geolocator.getLastKnownPosition();
      }

      if (position == null) {
        throw Exception("Location unavailable");
      }

      final currentPosition = position;

      List<Placemark> placemarks =
      await placemarkFromCoordinates(
        currentPosition.latitude,
        currentPosition.longitude,
      );

      Placemark place = placemarks.first;

      setState(() {
        locationController.text =
        "${place.locality}, ${place.administrativeArea}";
      });

      print("Location added");
    } catch (e) {
      print("ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Unable to get location",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],

      appBar: AppBar(
        title: const Text(
          "Add Event",
        ),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const Icon(
              Icons.event_available,
              size: 90,
              color: Colors.brown,
            ),

            const SizedBox(height: 10),

            const Text(
              "Create New Event",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Fill in your event details below",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20),
              ),

              child: Padding(
                padding:
                const EdgeInsets.all(20),

                child: Column(
                  children: [

                    TextField(
                      controller:
                      nameController,

                      decoration:
                      InputDecoration(
                        labelText:
                        "Event Name",

                        prefixIcon:
                        const Icon(
                          Icons.event,
                        ),

                        filled: true,

                        fillColor:
                        Colors.pink[50],

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller: dateController,
                      readOnly: true,

                      decoration: InputDecoration(
                        labelText: "Event Date",
                        prefixIcon: const Icon(
                          Icons.calendar_month,
                        ),

                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            DateTime? pickedDate =
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              setState(() {
                                dateController.text =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              });
                            }
                          },
                        ),

                        filled: true,
                        fillColor: Colors.pink[50],

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onTap: () async {
                        DateTime? pickedDate =
                        await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2100),
                        );

                        if (pickedDate != null) {
                          setState(() {
                            dateController.text =
                            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                          });
                        }
                      },
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    TextField(
                      controller:
                      locationController,

                      decoration:
                      InputDecoration(
                        labelText:
                        "Event Location",

                        prefixIcon:
                        const Icon(
                          Icons.location_on,
                        ),

                        filled: true,

                        fillColor:
                        Colors.pink[50],

                        border:
                        OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(
                              15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    ElevatedButton.icon(
                      onPressed: getCurrentLocation,

                      icon: const Icon(
                        Icons.my_location,
                      ),

                      label: const Text(
                        "Use Current Location",
                      ),

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        foregroundColor: Colors.white,
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    SizedBox(
                      width:
                      double.infinity,

                      child:
                      ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          Colors.brown,

                          foregroundColor:
                          Colors.white,

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 16,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                15),
                          ),
                        ),

                        onPressed: () {

                          if (nameController.text.isEmpty ||
                              dateController.text.isEmpty ||
                              locationController.text.isEmpty) {

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(

                              const SnackBar(
                                content: Text(
                                  "Please fill in all fields",
                                ),
                              ),
                            );
                          }

                          else {
                            final newEvent = Event(
                              name: nameController.text,
                              date: DateTime.parse(dateController.text),
                              location: locationController.text,
                            );

                            widget.onAddEvent(newEvent);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EventDetailsPage(
                                  eventName: newEvent.name,
                                  eventDate: newEvent.date.toString().split(' ')[0],
                                  eventLocation: newEvent.location,
                                ),
                              ),
                            );
                          }
                        },

                        child:
                        const Text(
                          "Save Event",

                          style:
                          TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
