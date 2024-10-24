import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

mixin RxEventTransformer {
  EventTransformer<Event> debounce<Event>({
    Duration duration = const Duration(milliseconds: 300),
  }) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
