import 'package:ember/features/event/model/counter_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// In features/event/providers/counter_provider.dart
final counterProvider = ChangeNotifierProvider<CounterModel>((ref) {
  return CounterModel(counter: 0);
});