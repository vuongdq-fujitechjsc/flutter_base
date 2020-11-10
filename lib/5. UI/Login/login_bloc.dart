import 'package:mimamu/2.%20Services/network/http_client.dart';
import 'package:mimamu/3.%20Utilities/log_util.dart';
import 'package:mimamu/core/apps/base_bloc.dart';
import 'package:mimamu/4.%20Base/Event/rx_bus_model.dart';
import 'package:mimamu/5.%20UI/Login/login_event.dart';
import 'package:mimamu/5.%20UI/Login/login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  final oAuth;

  LoginBloc(this.oAuth)
      : assert(oAuth != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressed) {
      yield LoginInProgress();

      var map = Map<String, String>();
      map['loginID'] = event.username.trim();
      map['password'] = event.password.trim();

      //call http normal
      HttpClient.getInstance().post('/login', body: map, onCompleted: (model) {
        LogUtil.debug('Call API - onComplete');
      }, onFailed: (error) {
        LogUtil.error('Call API - onFailed {message: ${error.errorMessage}}');
      });

      //call rx http
      HttpClient.getInstance().rxPost('/login', body: map).listen(
          (response) {
            if (parentBloc != null && parentBloc is BaseBloc) {
              (parentBloc as BaseBloc).emitEvent(
                  RxEventModel('RxEventModel - Test emit event', 'DQV'));
              // parentBloc.add();
            }
            this.add(LoginEventSuccess());
          },
          onDone: () {},
          onError: (error) {
            this.add(LoginEventFailure());
          });
    }

    if (event is LoginEventSuccess) {
      yield LoginSuccess();
    }

    if (event is LoginEventFailure) {
      yield LoginFailure(error: 'error');
    }
  }

  @override
  void dispatchEvent(RxEventModel event) {}
}
