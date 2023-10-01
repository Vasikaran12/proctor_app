import 'package:foss/redux/app_state.dart';
import 'actions.dart';

AppState reducer(AppState prev, dynamic action) {
  if (action is FetchDataAction) {
    return AppState(action.fname, action.lname, action.rollNo, action.regNo,
        action.phoneNo);
  } else {
    return prev;
  }
}
