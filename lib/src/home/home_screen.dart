import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../routes/router.dart';
import '../webview/webview.dart';
import '../login/model/login_model.dart';

import 'home_event.dart';
import 'home_state.dart';
import 'home_bloc.dart';

enum HomeItemType {
  qrCode,
  inOutManage,
  event,
  discussion,
  notification,
  communication
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomeForm();
  }
}

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends BasePage<HomeForm, HomeBloc, AppBloc> {
  HomeBloc _bloc;

  double _widthListItem;

  String _studentName = "";
  int _studentID;
  String _accessToken;

  @override
  HomeBloc getBlocData(BuildContext context) => _bloc;

  @override
  void initState() {
    super.initState();
    LogUtils.debug('HomeScreen - initState');

    _bloc = HomeBloc();

    _getStudentID();
  }

  @override
  Widget build(BuildContext context) {
    _widthListItem = ScreenUtils.getInstance(context).width - 45.0;

    return BlocProvider<HomeBloc>.value(
      value: _bloc,
      child: BlocConsumer<HomeBloc, HomeState>(
        builder: (context, state) {
          return MyNavigation(
            navigationData: NavigationData(
              isShowNavigation: true,
              navigationLeftButtonType: NavigationLeftButtonType.iconMenu,
              navigationTitle: _studentName,
            ),
            tapMenuButton: () => bloc.add(ToggleMenuEvent()),
            bodyWidget: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(15.0),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: [
                _homeListItem(HomeItemType.qrCode, state, context),
                _homeListItem(HomeItemType.inOutManage, state, context),
                _homeListItem(HomeItemType.event, state, context),
                _homeListItem(HomeItemType.discussion, state, context),
                _homeListItem(HomeItemType.notification, state, context),
                _homeListItem(HomeItemType.communication, state, context),
              ],
            ),
          );
        },
        listener: (context, state) {
          _handleHomeState(context, state);
        },
      ),
    );
  }

  Widget _homeListItem(type, HomeState state, BuildContext context) {
    switch (type) {
      case HomeItemType.qrCode:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_qr_code.png',
          title: multiLanguage.get('home_item_qr_code'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_qr_code'),
              url: ConstantsCore.WEB_QR_CODE + _studentID.toString(),
              token: _accessToken,
            ),
          ),
        );
        break;
      case HomeItemType.inOutManage:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_in_out_manage.png',
          title: multiLanguage.get('home_item_in_out_manage'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_in_out_manage'),
              url: ConstantsCore.WEB_IN_OUT_MANEGEMENT + _studentID.toString(),
              token: _accessToken,
            ),
          ),
        );
        break;
      case HomeItemType.event:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_event.png',
          title: multiLanguage.get('home_item_event'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_event'),
              url: ConstantsCore.WEB_EVENT + _studentID.toString(),
              token: _accessToken,
            ),
          ),
        );
        break;
      case HomeItemType.discussion:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_discussion.png',
          title: multiLanguage.get('home_item_discussion'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_discussion'),
              url: ConstantsCore.WEB_DISCUSSION + _studentID.toString(),
              token: _accessToken,
            ),
          ),
        );
        break;
      case HomeItemType.notification:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_notification.png',
          title: multiLanguage.get('home_item_notification'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_notification'),
              url: ConstantsCore.WEB_NOTIFICATION + _studentID.toString(),
              token: _accessToken,
            ),
          ),
        );
        break;
      case HomeItemType.communication:
        return HomeSelectItemGrid(
          assetImage: 'ic_home_item_communication.png',
          title: multiLanguage.get('home_item_communication'),
          onTap: () => Navigator.pushNamed(
            context,
            RouterID.WEBVIEW,
            arguments: WebViewData(
              title: multiLanguage.get('home_item_qr_code'),
              url: ConstantsCore.WEB_COMMUNICATION,
              token: _accessToken,
            ),
          ),
        );
        break;
      default:
        return Container();
    }
  }

  _handleHomeState(context, state) {}

  _getStudentID() async {
    var activeAccount = await SharedPreferencesManager.get(
        ConstantsCore.STORAGE_ACCOUNT_ACTIVE, "");
    LoginData currentAccount = await DBProvider.db.getUser(activeAccount);

    setState(() {
      _studentID = currentAccount.student_id;
      _studentName = currentAccount.student_name;
      _accessToken = currentAccount.access_token;
    });
  }
}
