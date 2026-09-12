import 'package:flutter/material.dart';
import 'add_event.dart';
import 'bottomnav.dart';
import 'upcoming_events.dart';
import 'register.dart';
import 'login.dart';
import 'models/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'add_review.dart';
import 'reviews_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    loadEvents();
  }

  String username = "";

  int currentIndex = 0;

  List<Event> events = [];

  Future<void> saveEvents() async {

    final prefs =
    await SharedPreferences.getInstance();

    String currentUser =
        prefs.getString('currentUser') ?? '';

    List<String> eventStrings =
    events.map((event) {

      return jsonEncode({
        'name': event.name,
        'date': event.date.toIso8601String(),
        'location': event.location,
        'imagePath': event.imagePath,
        'isFavorite': event.isFavorite,
      });

    }).toList();

    await prefs.setStringList(
      'events_$currentUser',
      eventStrings,
    );
  }

  Future<void> loadEvents() async {

    final prefs =
    await SharedPreferences.getInstance();

    String currentUser =
        prefs.getString('currentUser') ?? '';

    List<String> savedEvents =
        prefs.getStringList(
          'events_$currentUser',
        ) ??
            [];

    List<Event> loadedEvents =
    savedEvents.map((e) {

      final data = jsonDecode(e);

      return Event(
        name: data['name'],
        date: DateTime.parse(
          data['date'],
        ),
        location: data['location'],
        imagePath: data['imagePath'],
        isFavorite: data['isFavorite'] ?? false,
      );

    }).toList();

    setState(() {
      events = loadedEvents;
    });
  }

  void addEvent(Event event) {

    setState(() {

      events.add(event);

      events.sort(
            (a, b) => a.date.compareTo(b.date),
      );
    });

    saveEvents();
  }

  void registerUser(String name) {

    setState(() {

      username = name;

      isLoggedIn = true;
    });
  }

  void loginUser(String name) {

    setState(() {

      username = name;
      isLoggedIn = true;
    });

    loadEvents();
  }

  void deleteEvent(int index) {

    setState(() {

      events.removeAt(index);
    });

    saveEvents();
  }

  Future<void> logoutUser() async {

    final prefs =
    await SharedPreferences.getInstance();

    await prefs.remove('currentUser');

    setState(() {

      username = "";
      isLoggedIn = false;
      events.clear();
      currentIndex = 0;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Logged Out",
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {

    final pages = [

      DashboardPage(
        username: username,
      ),

      AddEventPage(
        onAddEvent: addEvent,
      ),

      UpcomingEventsPage(
        events: events,
        onDelete: deleteEvent,
        onUpdate: saveEvents,
      ),

      RegisterPage(
        onRegister: registerUser,
      ),
    ];

    return Scaffold(

      backgroundColor: Colors.pink[50],

      appBar: AppBar(

        title: const Text(
          "Memoir Reminder",

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,

        backgroundColor: Colors.brown,

        foregroundColor: Colors.white,

        elevation: 5,
      ),

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(

              decoration: BoxDecoration(

                gradient: LinearGradient(

                  colors: [

                    Colors.pinkAccent,
                    Colors.brown,
                  ],
                ),
              ),

              child: Center(

                child: Text(

                  "Memoir Reminder",

                  style: TextStyle(

                    color: Colors.white,

                    fontSize: 24,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            ListTile(

              leading: const Icon(Icons.home),

              title: const Text("Home"),

              onTap: () {

                setState(() {

                  currentIndex = 0;
                });

                Navigator.pop(context);
              },
            ),

            ListTile(

              leading: const Icon(Icons.add),

              title: const Text("Add Event"),

              onTap: () {

                setState(() {

                  currentIndex = 1;
                });

                Navigator.pop(context);
              },
            ),

            ListTile(

              leading: const Icon(Icons.upcoming),

              title: const Text("Upcoming Events"),

              onTap: () {

                setState(() {

                  currentIndex = 2;
                });

                Navigator.pop(context);
              },
            ),

            isLoggedIn

                ? ListTile(
              leading: const Icon(
                Icons.logout,
              ),

              title: const Text(
                "Logout",
              ),

              onTap: () {
                logoutUser();
                Navigator.pop(context);
              },
            )

                : ListTile(
              leading: const Icon(
                Icons.person,
              ),

              title: const Text(
                "Register",
              ),

              onTap: () {
                setState(() {
                  currentIndex = 3;
                });

                Navigator.pop(context);
              },
            ),

            if (!isLoggedIn)
              ListTile(
              leading: const Icon(
                Icons.login,
              ),
              title: const Text(
                "Login",
              ),
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoginPage(
                            onLogin: loginUser,
                        ),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.rate_review),
              title: const Text("Write Review"),
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AddReviewPage(),
                  ),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.reviews),
              title: const Text("View Reviews"),
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReviewsPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavPage(

        currentIndex: currentIndex,
        isLoggedIn: isLoggedIn,

        onTap: (index) {

          if (isLoggedIn && index == 3) {

            logoutUser();
            return;
          }

          setState(() {

            currentIndex = index;
          });
        },
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {

  final String username;

  const DashboardPage({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Column(

        children: [

          Padding(

            padding: const EdgeInsets.all(16),

            child: ClipRRect(

              borderRadius:
              BorderRadius.circular(25),

              child: Stack(

                alignment: Alignment.center,

                children: [

                  Image.asset(

                    'assets/images/polkadots.jpeg',

                    width: double.infinity,

                    height: 260,

                    fit: BoxFit.cover,
                  ),

                  Container(

                    width: double.infinity,

                    height: 260,

                    color:
                    Colors.black.withOpacity(0.3),
                  ),

                  Padding(

                    padding:
                    const EdgeInsets.all(20),

                    child: Column(

                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [

                        const Text(

                          "Memoir",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontSize: 50,

                            fontWeight: FontWeight.bold,

                            color: Colors.white,

                            letterSpacing: 1.5,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(

                          username.isEmpty
                              ? "Remember every moment."
                              : "Welcome back, $username!",

                          textAlign: TextAlign.center,

                          style: const TextStyle(

                            fontSize: 22,

                            fontWeight: FontWeight.w600,

                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 15),

                        const Text(

                          "Your personal event companion.\n"
                              "Manage events, stay organized,\n"
                              "and never miss an important moment.",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontSize: 16,

                            color: Colors.white,

                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 50,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              children: [

                imageCard(
                  "assets/images/masjid.jpg",
                  "Prayer Reminder",
                  "If prayer becomes a habit, success becomes a lifestyle",
                ),

                const SizedBox(height: 20),

                imageCard(
                  "assets/images/exam.jpg",
                  "Exam",
                  "Pain of regret or pain of discipline?",
                ),

                const SizedBox(height: 20),

                imageCard(
                  "assets/images/wedding.jpg",
                  "Wedding Events",
                  "All because two people fell in love",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget imageCard(

      String image,

      String title,

      String subtitle,

      ) {

    return Container(

      padding:
      const EdgeInsets.all(10),

      decoration:

      BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [

          BoxShadow(

            color:
            Colors.black12,

            blurRadius: 6,

            offset:
            const Offset(2,2),
          ),
        ],
      ),

      child: Column(

        children: [

          ClipRRect(

            borderRadius:
            BorderRadius.circular(15),

            child: Image.asset(

              image,

              width: double.infinity,

              height: 220,

              fit: BoxFit.contain,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Text(

            title,

            style:
            const TextStyle(

              fontWeight:
              FontWeight.bold,

              fontSize: 15,
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Text(

            subtitle,

            textAlign:
            TextAlign.center,

            style:
            const TextStyle(

              fontSize: 12,

              color:
              Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}