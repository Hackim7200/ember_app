import 'dart:async';

import 'package:flutter/material.dart';

class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  late final Stopwatch _stopwatch;
  late final Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _timer = Timer.periodic(
      const Duration(milliseconds: 30),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _handleStartStop() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _isRunning = false;
      } else {
        _stopwatch.start();
        _isRunning = true;
      }
    });
  }

  void _handleReset() {
    setState(() {
      _stopwatch.reset();
      _stopwatch.stop();
      _isRunning = false;
    });
  }

  String _getFormattedTime() {
    final int milliseconds = _stopwatch.elapsed.inMilliseconds;

    final String formattedSeconds = ((milliseconds ~/ 1000) % 60)
        .toString()
        .padLeft(2, '0');
    final String formattedMinutes = ((milliseconds ~/ 1000) ~/ 60)
        .toString()
        .padLeft(2, '0');

    return '$formattedMinutes:$formattedSeconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer Display
              Container(
                height: 280,
                width: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isRunning ? Colors.green : const Color(0xff0395eb),
                    width: 6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (_isRunning ? Colors.green : const Color(0xff0395eb))
                              .withValues(alpha: 0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    _getFormattedTime(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Start/Stop Button
                  ElevatedButton(
                    onPressed: _handleStartStop,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isRunning ? Colors.red : Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      _isRunning ? 'Stop' : 'Start',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Reset Button
                  ElevatedButton(
                    onPressed: _handleReset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Status Text
              Text(
                _isRunning ? 'Timer is running...' : 'Timer is stopped',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
