import 'dart:async';
import 'package:redux/redux.dart';
import 'package:ifsc_finder/data/model/hello_data.dart';
import 'package:ifsc_finder/redux/action_report.dart';
import 'package:ifsc_finder/redux/app/app_state.dart';
import 'package:ifsc_finder/features/action_callback.dart';
import 'package:ifsc_finder/redux/hello/hello_actions.dart';

class ProfileScreenViewModel {
  final Hello hello;
  final List<Hello> hellos;
  final Function(bool, ActionCallback) getHellos;

  ProfileScreenViewModel({
    this.hello,
    this.hellos,
    this.getHellos,
  });

  static ProfileScreenViewModel fromStore(Store<AppState> store) {
    return ProfileScreenViewModel(
      hello: store.state.helloState.hello,
      hellos: store.state.helloState.hellos.values.toList() ?? [],
      getHellos: (isRefresh, callback) {
        final Completer<ActionReport> completer = Completer<ActionReport>();
        store.dispatch(GetHellosAction(isRefresh: isRefresh, completer: completer));
        completer.future.then((status) {
          callback(status);
        }).catchError((error) => callback(error));
      },
    );
  }
}
