import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../routes/router.dart';
import '../login/model/login_model.dart';
import '../main/main.dart';

import 'account_event.dart';
import 'account_state.dart';
import 'account_bloc.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountForm();
  }
}

class AccountForm extends StatefulWidget {
  AccountForm({Key key}) : super(key: key);

  @override
  _AccountFormState createState() => _AccountFormState();
}

class _AccountFormState extends BasePage<AccountForm, AccountBloc, AppBloc>
    with SingleTickerProviderStateMixin {
  int _countListUser;
  List<LoginData> _listUser;
  var _activeAccount;

  @override
  void initState() {
    super.initState();
    LogUtils.debug('AccountScreen - initState');

    _countListUsers();
  }

  @override
  AccountBloc getBlocData(BuildContext context) => AccountBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => this.bloc,
      child: BlocConsumer<AccountBloc, AccountState>(
        builder: (context, state) {
          return MyNavigation(
            navigationData: NavigationData(
              isShowNavigation: true,
              navigationLeftButtonType: NavigationLeftButtonType.iconBack,
              navigationTitle: multiLanguage.get('account_navigation_title'),
            ),
            bodyWidget: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: ScreenUtils.getInstance(context).height -
                        44.0 -
                        20.0 -
                        44.0 -
                        16.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      itemCount: _countListUser != null ? _countListUser : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          background: Container(color: Colors.red),
                          key: Key(_listUser[index].account_name),
                          child: Container(
                            color:
                                _listUser[index].account_name == _activeAccount
                                    ? Colors.grey
                                    : null,
                            child: ListTile(
                              title: Text(
                                  '${_listUser[index].student_name} (${_listUser[index].account_name})'),
                              onTap: () {
                                SharedPreferencesManager.putString(
                                    ConstantsCore.STORAGE_ACCOUNT_ACTIVE,
                                    _listUser[index].account_name);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                            ),
                          ),
                          onDismissed: (direction) {
                            setState(() {
                                DBProvider.db.deleteUser(_listUser[index]);
                              });
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                    ),
                  ),
                  Container(
                    color: HexColor(Color.COLOR_MAIN),
                    child: FlatButton(
                      child: Text(
                        multiLanguage.get('account_navigation_bottom_button'),
                        style: TextStyle(
                          color: HexColor(Color.COLOR_WHITE),
                        ),
                      ),
                      minWidth: ScreenUtils.getInstance(context).width,
                      height: 44.0,
                      onPressed: () =>
                          {Navigator.pushNamed(context, RouterID.ADD_ACCOUNT)},
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) => _handleAccountState(context, state),
      ),
    );
  }

  _handleAccountState(context, state) {}

  _countListUsers() async {
    int _count = await DBProvider.db.countUser();
    var _list = await DBProvider.db.getAllUser();
    var _account = await SharedPreferencesManager.get(
        ConstantsCore.STORAGE_ACCOUNT_ACTIVE, "");
    setState(() {
      _countListUser = _count;
      _listUser = _list;
      _activeAccount = _account;
    });
  }
}
