import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class HomeAppWidget extends StatefulWidget {
  const HomeAppWidget({Key? key}) : super(key: key);

  @override
  _HomeAppWidgetState createState() => _HomeAppWidgetState();
}

class _HomeAppWidgetState extends State<HomeAppWidget> {
  late Future<List> projetos;

  Future<List> pegarProjetos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // await sharedPreferences.clear();

    String? accessToken = sharedPreferences.getString('accessToken');
    String? codigo = sharedPreferences.getString('codigo');
    var url = Uri.parse('http://162.241.79.26:4000/api/parceiro-project/years?codigoParceiro=$codigo');
    var response = await http.get(url, headers: {
      'Authorization': accessToken!,
    });
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['years'];
    }else{
      throw Exception('erro');
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    projetos = pegarProjetos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: FutureBuilder<List>(
        future: projetos,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro!'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile();
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
