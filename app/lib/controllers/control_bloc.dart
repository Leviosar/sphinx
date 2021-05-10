import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ControlBloc extends BlocBase {

  BehaviorSubject<bool> _timerReset = BehaviorSubject<bool>();

  BehaviorSubject<bool> get timerReset => this.timerReset;

  ControlBloc() {
    this._timerReset.add(false);
  }

  @override
  void dispose() {
    this._timerReset.sink.close();
    super.dispose();
  }
}