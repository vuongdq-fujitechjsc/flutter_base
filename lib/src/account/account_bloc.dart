import 'package:mimamu/src/account/account_event.dart';
import 'package:mimamu/src/account/account_screen.dart';
import 'package:mimamu/src/account/account_state.dart';

import '../../core/core.dart';

class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {}
}
