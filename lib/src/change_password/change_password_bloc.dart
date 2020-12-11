import '../../core/core.dart';

import 'change_password_event.dart';
import 'change_password_state.dart';
import 'change_password_repository.dart';

class ChangePasswordBloc
    extends BaseBloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordRepository _repository;

  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    _repository = ChangePasswordRepository();
  }

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is ChangePasswordPressed) {
      yield ChangePasswordInProgress();

      bool isSuccess = await _repository.changePassword(
          event.oldPassword, event.newPassword);
      if (isSuccess) {
        yield ChangePasswordSuccess();
      } else {
        yield ChangePasswordFailure(errorMessage: multiLanguage.get('MSG015'));
      }
    }
  }
}
