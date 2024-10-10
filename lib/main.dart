import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProgressTracker(),
    );
  }
}

class ProgressTracker extends StatefulWidget {
  @override
  _ProgressTrackerState createState() => _ProgressTrackerState();
}

class _ProgressTrackerState extends State<ProgressTracker> {
  int guidedSessions = 0; // Track number of completed guided sessions
  int personalSessions = 0; // Track number of completed personal sessions
  int journalReadings = 0; // Track number of completed journal readings
  int meditationSessions = 0; // Track number of completed meditation sessions

  void incrementProgress(String type) {
    setState(() {
      switch (type) {
        case 'guided':
          if (guidedSessions < 5) guidedSessions++; // Increment by 1 session
          break;
        case 'personal':
          if (personalSessions < 5) personalSessions++; // Increment by 1 session
          break;
        case 'journal':
          if (journalReadings < 5) journalReadings++; // Increment by 1 session
          break;
        case 'meditation':
          if (meditationSessions < 5) meditationSessions++; // Increment by 1 session
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Calculate progress based on completed sessions (max 5)
    double guidedSessionProgress = guidedSessions / 5.0;
    double personalSessionProgress = personalSessions / 5.0;
    double journalReadingProgress = journalReadings / 5.0;
    double meditationSessionProgress = meditationSessions / 5.0;

    double totalProgress = (guidedSessionProgress +
        personalSessionProgress +
        journalReadingProgress +
        meditationSessionProgress) /
        4; // Average progress of all sessions

    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Item Progress Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Track Your Sessions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Guided Sessions Progress
            _buildProgressItem(
              title: 'Guided Sessions',
              progress: guidedSessionProgress,
              sessionCount: guidedSessions,
              onIncrement: () => incrementProgress('guided'),
              color: Colors.blue, // Color for Guided Sessions
            ),
            const SizedBox(height: 20),

            // Personal Sessions Progress
            _buildProgressItem(
              title: 'Personal Sessions',
              progress: personalSessionProgress,
              sessionCount: personalSessions,
              onIncrement: () => incrementProgress('personal'),
              color: Colors.green, // Color for Personal Sessions
            ),
            const SizedBox(height: 20),

            // Journal Readings Progress
            _buildProgressItem(
              title: 'Journal Readings',
              progress: journalReadingProgress,
              sessionCount: journalReadings,
              onIncrement: () => incrementProgress('journal'),
              color: Colors.orange, // Color for Journal Readings
            ),
            const SizedBox(height: 20),

            // Meditation Sessions Progress
            _buildProgressItem(
              title: 'Meditation Sessions',
              progress: meditationSessionProgress,
              sessionCount: meditationSessions,
              onIncrement: () => incrementProgress('meditation'),
              color: Colors.purple, // Color for Meditation Sessions
            ),
            const SizedBox(height: 20),

            // Total Progress
            Text(
              'Total Progress: ${(totalProgress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Total Progress Bar
            LinearProgressIndicator(
              value: totalProgress,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressItem({
    required String title,
    required double progress,
    required int sessionCount, // Add sessionCount parameter
    required VoidCallback onIncrement,
    required Color color, // Add color parameter
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: progress,
          minHeight: 10,
          backgroundColor: Colors.grey[300],
          color: color, // Use the provided color for the progress bar
        ),
        const SizedBox(height: 5),
        Text(
          'Sessions Completed: $sessionCount / 5', // Display session count
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: onIncrement,
          child: const Text('Increment Progress'),
        ),
      ],
    );
  }
}
