import '../../core/core.dart';

import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {}
}
