class AppState {
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

  AppState(
    this._fname,
    this._lname,
    this._rollNo,
    this._regNo,
    this._phoneNo,
  );

  AppState.initialState()
      : _fname = "",
        _lname = "",
        _rollNo = "",
        _regNo = "",
        _phoneNo = 0;
}
