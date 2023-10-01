import 'package:foss/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:foss/supabase/constants.dart';
import 'package:redux/redux.dart';

class FetchDataAction {
  final String _fname;
  final String _lname;
  final String _rollNo;
  final String _regNo;
  final int _phoneNo;

  String get fname => _fname;
  String get lname => _lname;
  String get rollNo => _rollNo;
  String get regNo => _regNo;
  int get phoneNo => _phoneNo;

  FetchDataAction(
      this._fname, this._lname, this._rollNo, this._regNo, this._phoneNo);
}
