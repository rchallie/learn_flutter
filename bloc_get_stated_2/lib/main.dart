import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() => runApp(MyApp());

enum CounterEvent { increment }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        //addError(Exception('increment error!'), StackTrace.current);
        yield state + 1;
        break;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // Print the event called
  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onChange(Change<int> change) {
    print(change);
    super.onChange(change);
  }

  // Print the transitionner between current and next state
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print(transition);
  }
}

class SimpleWidget extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterBloc, int>(
      bloc: BlocProvider.of<CounterBloc>(context),
      builder: (context, state) {
        return (
          Container(
            child: Text('$state'),
            padding: EdgeInsets.all(10.0),
          )
        );
      }
    );
  }
}

class MyApp extends StatelessWidget {

  CounterBloc counter_bloc = CounterBloc();

  // Async call
  // Future<void> _onPress() async
  // {
  //   final bloc = CounterBloc();
  //   final subscription = bloc.stream.listen(print);
  //   bloc.add(CounterEvent.increment);
  //   await Future.delayed(Duration.zero);
  //   await subscription.cancel();
  //   await bloc.close();
  // }

  void _onPress() {
    CounterBloc()
      ..add(CounterEvent.increment)
      ..close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            height: 150,
            child: Column(
              children: [
                BlocBuilder<CounterBloc, int>(
                  bloc: counter_bloc,
                  builder: (context, state) {
                    return (
                      Container(
                        child: Text('$state'),
                        padding: EdgeInsets.all(10.0),
                      )
                    );
                  }
                ),
                BlocProvider.value(
                  value: counter_bloc,
                  child: SimpleWidget(),
                ),
                FloatingActionButton(
                  onPressed: () => counter_bloc.add(CounterEvent.increment),
                  child: Icon(Icons.plus_one),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}