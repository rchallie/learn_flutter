import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() => runApp(MyApp());

class CounterCubit extends Cubit<int> {
  CounterCubit(int initialState) : super(initialState);

  void increment() {
    addError(Exception('increment error!'), StackTrace.current);
    emit(state + 1);
  }

  // Appelé au moment du emit
  // Donne le current state = avant changement
  // Donne nextState qui correspond à la futur valeur après changement
  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

class MyApp extends StatelessWidget
{
  void multiply(int nbr)
  {
    nbr *= 90;
    print(nbr);
  }

  // Async use of Cubit
  // Future<void> testCubit() async {
  //   final cubit = CounterCubit(0);
  //   final subscription = cubit.stream.listen(multiply);
  //   cubit.increment();
  //   await Future.delayed(Duration.zero);
  //   await subscription.cancel();
  //   await cubit.close();
  // }

  // Créer un observer général qui outputera
  // Son onChange quand un le onChange d'un Cubit est appelé
  void testCubit() {
    Bloc.observer = SimpleBlocObserver();
    CounterCubit(0)
      ..increment()
      ..close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: FloatingActionButton(
            onPressed: testCubit,
            child: new Icon(Icons.add)
          ),
        ),
      ),
    );
  }
}