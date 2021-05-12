import 'package:bgv/components/alert/alert.dart';
import 'package:bgv/components/home/home.dart';
import 'package:bgv/components/login/login.dart';
import 'package:bgv/components/personelFile/PFiles.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class FRouter {
  static final FluroRouter router = FluroRouter();

  static Handler _loginHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          LoginPage());
  static Handler _homeHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => Home(
          // page: params['name'][0],
          // extra: params['extra'][0],
          ));
  static Handler _pFileHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => Pfile(
          // page: params['name'][0],
          // extra: params['extra'][0],
          ));
  static Handler _alertHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => Alert(
          // page: params['name'][0],
          // extra: params['extra'][0],
          ));

  static void setupRouter() {
    router.define("/", handler: _loginHandler);

    router.define("/main",
        handler: _homeHandler, transitionType: TransitionType.fadeIn);
    router.define("/pfile",
        handler: _pFileHandler, transitionType: TransitionType.fadeIn);
    router.define("/alert",
        handler: _alertHandler, transitionType: TransitionType.fadeIn);
  }
}
