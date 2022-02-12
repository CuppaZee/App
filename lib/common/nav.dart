import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Nav {
  static pushNamed(BuildContext context, String name) {
    Navigator.pushNamed(context, name);
    var block = BlocProvider.of<NavCubit>(context);
    block.increment();
  }

  static push<T extends Object?>(BuildContext context, Route<T> route) {
    Navigator.push(context, route);
    var block = BlocProvider.of<NavCubit>(context);
    block.increment();
  }

}

class NavCubit extends Cubit<int> {
  NavCubit() : super(0);

  void increment() => emit(state + 1);
}