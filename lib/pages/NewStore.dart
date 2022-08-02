import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/CreateProduct.dart';
import 'package:flutter_login_ui/pages/cart.dart';
import 'package:flutter_login_ui/pages/store.dart';
import 'package:firebase_core/firebase_core.dart';

/// This is the stateful widget that the main application instantiates.
class NewStoreStateWidget extends StatefulWidget {
  const NewStoreStateWidget({Key? key}) : super(key: key);

  @override
  State<NewStoreStateWidget> createState() => _NewStoreStateWidget();
}

/// This is the private State class that goes with MyStatefulWidget.
/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _NewStoreStateWidget extends State<NewStoreStateWidget>
    with TickerProviderStateMixin {
    late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home DevZeros'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.production_quantity_limits),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Tab(
                    icon: Icon(Icons.add_circle_outline_sharp),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(
              child:  StorePageState(title: 'Store'),
            ),
            Center(
              child: CreateProduct(type: false,)
            ),
          ],
        ),
      ),
    );
  }
}