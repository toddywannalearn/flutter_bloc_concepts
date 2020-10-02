

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';


class CounterCubit extends Cubit<CounterState>{
  CounterCubit() : super(CounterState(counterValue: 0));

  //state keyword
  void increment() => emit(CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(counterValue: state.counterValue - 1, wasIncremented: false));
}