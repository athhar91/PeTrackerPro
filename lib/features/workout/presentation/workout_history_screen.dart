import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:pe_track/core/api/api_service.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  const WorkoutHistoryScreen({super.key});

  @override
  State<WorkoutHistoryScreen> createState() => _WorkoutHistoryScreenState();
}

class _WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<dynamic> _workouts = [];
  final ImagePicker _picker = ImagePicker();
  final _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _refreshWorkouts();
  }

  void _refreshWorkouts() async {
    final data = await _apiService.getWorkouts();
    setState(() {
      _workouts = data;
    });
  }

  Future<void> _addWorkout() async {
    final titleController = TextEditingController();
    final notesController = TextEditingController();
    XFile? media;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Log Workout'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Workout Title'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: notesController,
                  decoration: const InputDecoration(labelText: 'Notes'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                if (media != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Image.file(
                      File(media!.path),
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final img = await _picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (img != null) setDialogState(() => media = img);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Add Image'),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        final vid = await _picker.pickVideo(
                          source: ImageSource.gallery,
                        );
                        if (vid != null) setDialogState(() => media = vid);
                      },
                      icon: const Icon(Icons.video_library),
                      label: const Text('Add Video'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  await _apiService.addWorkout({
                    'title': titleController.text,
                    'notes': notesController.text,
                    'mediaPath': media?.path,
                    'mediaType': media?.path.split('.').last,
                    'timestamp': DateTime.now().toIso8601String(),
                  });
                  if (context.mounted) {
                    Navigator.pop(context);
                    _refreshWorkouts();
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: _workouts.isEmpty
          ? const Center(child: Text('No workouts logged yet'))
          : ListView.builder(
              itemCount: _workouts.length,
              itemBuilder: (context, index) {
                final workout = _workouts[index];
                return Card(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (workout['mediaPath'] != null)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child:
                              workout['mediaType'] == 'mp4' ||
                                  workout['mediaType'] == 'mov'
                              ? Container(
                                  height: 200,
                                  width: double.infinity,
                                  color: Colors.black26,
                                  child: const Icon(
                                    Icons.play_circle_fill,
                                    size: 60,
                                  ),
                                )
                              : Image.file(
                                  File(workout['mediaPath']),
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout['title'],
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(workout['notes'] ?? ''),
                            const SizedBox(height: 12),
                            Text(
                              DateFormat(
                                'MMM dd, yyyy • HH:mm',
                              ).format(DateTime.parse(workout['timestamp'])),
                              style: const TextStyle(
                                color: Colors.white60,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWorkout,
        child: const Icon(Icons.add),
      ),
    );
  }
}
