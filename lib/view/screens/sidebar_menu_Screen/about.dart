import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 36, 36),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'About',
          style: TextStyle(
              color: Color.fromARGB(255, 227, 251, 92),
              fontSize: 25,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              """About Life Leaf

Welcome to Life Leaf, a comprehensive tool designed to nurture personal growth and development, empowering users to track and celebrate their journey through life's milestones and aspirations.

Features:

Goals: Set and track personal goals, marking progress as you strive towards your ambitions.

Journals: Chronicle your thoughts, experiences, and reflections with the freedom to record entries for any date. Enhance your entries with images to capture memorable moments.

Memories: Organize cherished memories into distinct categories, such as trips or special events, with the ability to assign cover photos for each collection.

Reminders: Stay on track with customizable reminders and alarms, ensuring important tasks and events are never forgotten.

Habits: Cultivate positive habits by monitoring progress and streaks, fostering personal growth and accountability.

Privacy and Security:

Life Leaf prioritizes the privacy and security of its users. We do not collect any personal data beyond what is necessary for account creation and authentication. Your information is safeguarded, providing you with a safe and secure environment to document your journey.

Developed by AkshayNath K S:

Life Leaf is the brainchild of AkshayNath K S, a dedicated developer committed to empowering individuals on their path to self-improvement. For inquiries or support, please contact AkshayNath K S at akshaynathks@gmail.com.

Get Started:

Unlock the full potential of Life Leaf by signing in or signing up today. Embark on a journey of self-discovery, growth, and fulfillment with Life Leaf as your trusted companion.

""",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
