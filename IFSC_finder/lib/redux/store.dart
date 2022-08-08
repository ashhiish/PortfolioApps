import 'package:logging/logging.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:ifsc_finder/redux/app/app_state.dart';
import 'package:ifsc_finder/redux/app/app_reducer.dart';

Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: []
      ..addAll([
        LoggingMiddleware<dynamic>.printer(level: Level.ALL),
      ]),
  );
}
