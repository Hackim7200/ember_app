import 'package:flutter/material.dart';
import 'package:ember/features/Joke/joke_service.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  String _joke = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  Future<void> _fetchJoke() async {
    setState(() => _loading = true);
    final joke = await JokeService.fetchJoke();
    if (!mounted) {
      return; // <-- Add this line // this removes error when you dispose and return to page
    }
    setState(() {
      _joke = joke ?? 'No joke found.';
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Joke")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _loading
              ? const CircularProgressIndicator()
              : Text(
                  _joke,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchJoke,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
