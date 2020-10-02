import 'package:bloc_concepts/cubit/counter_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo With Bloc'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: BlocConsumer<CounterCubit, CounterState>(
                  listener: (context, state){
                    if(state.wasIncremented == true){
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Incremented'),
                          duration: Duration(milliseconds: 300),
                        ),);
                    }else{
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Decremented'),
                          duration: Duration(milliseconds: 300),
                        ),);
                    }
                  },
                    builder: (context, state) {
                      if(state.counterValue < 0){
                        return Text(
                          'Going negative bro ${state.counterValue.toString()}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        );
                      } else if(state.counterValue == 10){
                        return Text(
                          'Woow U click a lot ${state.counterValue.toString()}',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                        );
                      }
                      return Text(
                        state.counterValue.toString(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5,
                      );
                    }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      //or context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      context.bloc<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
