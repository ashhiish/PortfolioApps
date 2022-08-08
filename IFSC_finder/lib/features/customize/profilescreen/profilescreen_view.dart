import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifsc_finder/data/model/hello_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ifsc_finder/trans/translations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ifsc_finder/redux/app/app_state.dart';
import 'package:ifsc_finder/features/customize/profilescreen/profilescreen_view_model.dart';
import 'package:ifsc_finder/redux/action_report.dart';
import 'package:ifsc_finder/utils/progress_dialog.dart';

class ProfileScreenView extends StatelessWidget {
  ProfileScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileScreenViewModel>(
      distinct: true,
      converter: (store) => ProfileScreenViewModel.fromStore(store),
      builder: (_, viewModel) => ProfileScreenViewContent(
            viewModel: viewModel,
          ),
    );
  }
}

class ProfileScreenViewContent extends StatefulWidget {
  final ProfileScreenViewModel viewModel;

  ProfileScreenViewContent({Key key, this.viewModel}) : super(key: key);

  @override
  _ProfileScreenViewContentState createState() => _ProfileScreenViewContentState();
}

class _ProfileScreenViewContentState extends State<ProfileScreenViewContent> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final TrackingScrollController _scrollController = TrackingScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController pageController;
  int page = 0;
  List pages = ["Home","Notice","Mine"];
  var _status;
  var _processBar;

  @override
  void initState() {
    super.initState();
    if (this.widget.viewModel.hellos.length == 0) {
      _status = ActionStatus.running;
      this.widget.viewModel.getHellos(true, getHellosCallback);
    }
	pageController = PageController(initialPage: this.page);
  }

  void getHellosCallback(ActionReport report) {
    setState(() {
      _status = report.status;
    });
  }

  void showError(String error) {
    final snackBar = SnackBar(content: Text(error));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var widget;

    widget = NotificationListener(
        onNotification: _onNotification,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          child: ListView.builder(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: this.widget.viewModel.hellos.length + 1,
            itemBuilder: (_, int index) => _createItem(context, index),
          ),
        ));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(pages[page]),
      ),
	  drawer: _buildDrawer(),
      body: widget,
	  bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(pages[0]),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text(pages[1]),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Text(pages[2]),
              backgroundColor: Colors.blue)
        ], onTap: onTap, currentIndex: page)
    );
  }
  bool _onNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (notification.metrics.extentAfter < 15.0) {
        // load more
        if (this._status != ActionStatus.running) {
          // have next page
          _loadMoreData();
          setState(() {});
        }
      }
    }

    return true;
  }

  Future<Null> _loadMoreData() {
    _status = ActionStatus.running;
    widget.viewModel.getHellos(false, getHellosCallback);
    return null;
  }

  Future<Null> _handleRefresh() async {
    _refreshIndicatorKey.currentState.show();
    _status = ActionStatus.running;
    widget.viewModel.getHellos(true, getHellosCallback);
    return null;
  }

  _createItem(BuildContext context, int index) {
    if (index < this.widget.viewModel.hellos?.length) {
      return Container(
              child: _HelloListItem(
                hello: this.widget.viewModel.hellos[index],
                onTap: () {
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(
                  //    builder: (context) =>
                  //        ViewHello(hello: this.widget.viewModel.hellos[index]),
                  //  ),
                  //);
                },
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))));
    }

    return Container(
      height: 44.0,
      child: Center(
        child: _getLoadMoreWidget(),
      ),
    );
  }

  Widget _getLoadMoreWidget() {
    if (this._status == ActionStatus.running) {
      return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator());
    } else {
      return SizedBox();
    }
  }

  void onTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  Drawer _buildDrawer() {
    var fontFamily = "Roboto";
    var accountEmail = Text(
        "haystack1206@gmail.com",
        style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontFamily: fontFamily
        )
    );
    var accountName = Text(
        "HAY",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontFamily: fontFamily
        )
    );
    var accountPicture = CircleAvatar(
        child: Image.asset("assets/icons/ic_launcher.png"),
        backgroundColor: Theme.of(context).accentColor
    );

    var header = UserAccountsDrawerHeader(
      accountEmail: accountEmail,
      accountName: accountName,
      onDetailsPressed: _onTap,
      currentAccountPicture: accountPicture,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor
      ),
    );

    var tileItem1 = ListTile(
        leading: Icon(Icons.add_a_photo),
        title: Text("Add Photo"),
        subtitle: Text("Add a photo to your album"),
        onTap: _onTap
    );
    var tileItem2 = ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text("Exit"),
        onTap: _onTap
    );

    var listView = ListView(children: [header, tileItem1, tileItem2]);

    var drawer = Drawer(child: listView);

    return drawer;
  }

  void _onTap() {
    // Update the state of the app
    // ...
    // Then close the drawer
    Navigator.pop(context);
  }

  void hideProcessBar() {
    if (_processBar != null && _processBar.isShowing()) {
      _processBar.hide();
      _processBar = null;
    }
  }

  void showProcessBar(String msg) {
    if (_processBar == null) {
      _processBar = new ProgressDialog(context);
    }
    _processBar.setMessage(msg);
    _processBar.show();
  }
}

class _HelloListItem extends ListTile {
  _HelloListItem({Hello hello, GestureTapCallback onTap})
      : super(
            title: Text("Title"),
            subtitle: Text("Subtitle"),
            leading: CircleAvatar(child: Text("T")),
            onTap: onTap);
}
