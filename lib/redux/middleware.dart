import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import 'app_state.dart';
import 'actions.dart';
import 'package:flutter/material.dart';
import 'package:foss/supabase/constants.dart';

ThunkAction<AppState> fetchData() => (Store<AppState> store) async {
      try {
        print('success... I am inside middleware :)');
        final List<dynamic> data =
            await sb.from('student').select() as List<dynamic>;
        print(data);
        // store.dispatch(FetchDataAction(
        //     data[0]['first_name'],
        //     data[0]['last_name'],
        //     data[0]['roll_number'],
        //     data[0]['register_number'],
        //     data[0]['phone_number']));
        print('succes2... I reached end of middleware');
      } catch (e) {
        print('failed');
        print(e.toString());
        return;
      }
    };
