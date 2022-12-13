import 'package:joule_meus_projetos/home_app/home_app_widget.dart';
import 'package:joule_meus_projetos/login/login_widget.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplachscreenWidget extends StatefulWidget {
  const SplachscreenWidget({Key? key}) : super(key: key);

  @override
  _SplachscreenWidgetState createState() => _SplachscreenWidgetState();
}

class _SplachscreenWidgetState extends State<SplachscreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    verificacaoToken().then((value) {
      print(value);
      if (value == true) {
        context.go('/projetosreferentes');
      } else {
        context.go('/projetosreferentes');
      }
    });
    // On page load action.
    // SchedulerBinding.instance.addPostFrameCallback((_) async {
    //  context.pushNamed('home_app');
    //});
  }

  @override
  Widget build(BuildContext context) {
    verificacaoToken();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Future<bool> verificacaoToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('accessToken');
    if (token != null) {
      print('Token: $token');
      return true;
    } else {
      print('Token: $token');
      return false;
    }
  }
}
