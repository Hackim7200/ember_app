// import 'dart:async';

// import 'package:flutter/material.dart';

// enum TimerType { pomodoro, shortBreak, longBreak }

// class PomodoroTimer extends StatefulWidget {
//   const PomodoroTimer({super.key});

//   @override
//   State<PomodoroTimer> createState() => _PomodoroTimerState();
// }

// class _PomodoroTimerState extends State<PomodoroTimer> {
//   Timer? _timer;
//   bool _isRunning = false;
//   TimerType _currentTimerType = TimerType.pomodoro;
//   int _remainingSeconds = 25 * 60; // 25 minutes for Pomodoro

//   // Timer durations in seconds
//   static const Map<TimerType, int> _timerDurations = {
//     TimerType.pomodoro: 25 * 60, // 25 minutes
//     TimerType.shortBreak: 5 * 60, // 5 minutes
//     TimerType.longBreak: 15 * 60, // 15 minutes
//   };

//   @override
//   void initState() {
//     super.initState();
//     _resetTimer();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   void _startTimer() {
//     if (_timer != null) return;

//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_remainingSeconds > 0) {
//           _remainingSeconds--;
//         } else {
//           _onTimerComplete();
//         }
//       });
//     });
//     setState(() {
//       _isRunning = true;
//     });
//   }

//   void _stopTimer() {
//     _timer?.cancel();
//     _timer = null;
//     setState(() {
//       _isRunning = false;
//     });
//   }

//   void _resetTimer() {
//     _stopTimer();
//     setState(() {
//       _remainingSeconds = _timerDurations[_currentTimerType]!;
//     });
//   }

//   void _onTimerComplete() {
//     _stopTimer();
//     _showCompletionDialog();
//   }

//   void _showCompletionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Timer Complete!'),
//         content: Text(_getCompletionMessage()),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _resetTimer();
//             },
//             child: const Text('Start New Timer'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Close'),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getCompletionMessage() {
//     switch (_currentTimerType) {
//       case TimerType.pomodoro:
//         return 'Great work! Time for a short break.';
//       case TimerType.shortBreak:
//         return 'Break time is over! Ready for another Pomodoro?';
//       case TimerType.longBreak:
//         return 'Long break complete! Ready to get back to work?';
//     }
//   }

//   void _switchTimerType(TimerType type) {
//     if (_currentTimerType != type) {
//       setState(() {
//         _currentTimerType = type;
//         _remainingSeconds = _timerDurations[type]!;
//         _isRunning = false;
//       });
//       _stopTimer();
//     }
//   }

//   String _getFormattedTime() {
//     final int minutes = _remainingSeconds ~/ 60;
//     final int seconds = _remainingSeconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
//   }

//   String _getTimerTypeName() {
//     switch (_currentTimerType) {
//       case TimerType.pomodoro:
//         return 'Pomodoro';
//       case TimerType.shortBreak:
//         return 'Short Break';
//       case TimerType.longBreak:
//         return 'Long Break';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Timer Display
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 20),
//             decoration: BoxDecoration(
//               border: Border.all(
//                 color: _isRunning ? Colors.green : const Color(0xff0395eb),
//                 width: 6,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: (_isRunning ? Colors.green : const Color(0xff0395eb))
//                       .withValues(alpha: 0.3),
//                   blurRadius: 20,
//                   spreadRadius: 5,
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               children: [
//                 // Timer Type Buttons
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     _buildTimerTypeButton(
//                       'Pomodoro',
//                       TimerType.pomodoro,
//                       _currentTimerType == TimerType.pomodoro,
//                     ),
//                     _buildTimerTypeButton(
//                       'Short Break',
//                       TimerType.shortBreak,
//                       _currentTimerType == TimerType.shortBreak,
//                     ),
//                     _buildTimerTypeButton(
//                       'Long Break',
//                       TimerType.longBreak,
//                       _currentTimerType == TimerType.longBreak,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),

//                 // Timer Display
//                 Center(
//                   child: Text(
//                     _getFormattedTime(),
//                     style: const TextStyle(
//                       color: Colors.black,
//                       fontSize: 64,
//                       fontWeight: FontWeight.bold,
//                       fontFamily: 'monospace',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 30),

//                 // Start/Stop Button
//                 ElevatedButton(
//                   onPressed: _isRunning ? _stopTimer : _startTimer,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: _isRunning ? Colors.red : Colors.green,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 40,
//                       vertical: 20,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Text(
//                     _isRunning ? 'Stop' : 'Start',
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTimerTypeButton(String label, TimerType type, bool isSelected) {
//     return TextButton(
//       onPressed: () => _switchTimerType(type),
//       style: TextButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         backgroundColor: isSelected
//             ? const Color(0xff0395eb).withValues(alpha: 0.1)
//             : null,
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           color: isSelected ? const Color(0xff0395eb) : Colors.grey[600],
//           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }
