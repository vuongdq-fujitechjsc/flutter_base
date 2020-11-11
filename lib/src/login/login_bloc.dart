import '../../core/core.dart';

import 'login_event.dart';
import 'login_state.dart';
import 'login_repository.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginRepository _repository;

  LoginBloc() : super(LoginInitial()) {
    _repository = LoginRepository();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressed) {
      yield LoginInProgress();

      if (event.username.isEmptyTrim() || event.password.isEmptyTrim()) {
        yield LoginValidate();
        return;
      }

      final errorMessage =
          await _repository.login(event.username, event.password);
      if (errorMessage == null) {
        yield LoginSuccess();
      } else {
        yield LoginFailure(errorMessage: errorMessage);
      }
    }
  }
}
