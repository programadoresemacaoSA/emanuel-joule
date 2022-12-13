import 'dart:convert';

import 'package:joule_meus_projetos/projetosreferentes/widgets/prejeto_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ProjetosreferentesWidget extends StatefulWidget {
  const ProjetosreferentesWidget({Key? key}) : super(key: key);

  @override
  _ProjetosreferentesWidgetState createState() =>
      _ProjetosreferentesWidgetState();
}

class _ProjetosreferentesWidgetState extends State<ProjetosreferentesWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List> projetos;

  Future<List> pegarProjetos() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // await sharedPreferences.clear();

    String? accessToken = sharedPreferences.getString('accessToken');
    String? codigo = sharedPreferences.getString('codigo');
    var url = Uri.parse(
        'http://162.241.79.26:4000/api/parceiro-project?codigoParceiro=PA-1570-GD');
    var response = await http.get(url, headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2Mzk3NjM3MDIxNjIxZDRlYjQyMDBkMTEiLCJ0aXBvVXN1YXJpbyI6InBhcmNlaXJvIiwiaWF0IjoxNjcwOTM2MjQ0LCJleHAiOjE2NzA5Mzk4NDR9.d6RNJFHmThxZgGCmNKlogevSzhu6DkIAaTg6TY_8ixo',
    });
    print(response.body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['result'];
    } else {
      throw Exception('erro');
    }
  }

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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 60,
                    icon: Icon(
                      Icons.chevron_left,
                      color: Color(0xFF969696),
                      size: 30,
                    ),
                    onPressed: () async {
                      context.pushNamed('home_app');
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(45, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          'assets/images/joule-logo.431198cc_(1).png',
                          width: 60,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '|',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF414141),
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Meus projetos',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF414141),
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 30, 10, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Olá, SolarLife!',
                    style: FlutterFlowTheme.of(context).title1.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF0F1113),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                            child: Text(
                              'Projetos referentes a ',
                              style: FlutterFlowTheme.of(context).bodyText1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 48, 0, 0),
                        child: Text(
                          '2022',
                          style:
                              FlutterFlowTheme.of(context).bodyText1.override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFFFFCD00),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List>(
                    future: projetos,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Erro!'),
                        );
                      } else if (snapshot.hasData) {
                        return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ProjetoWidget(
                                projeto: snapshot.data![index],
                                pagina: () {
                                  context.go('/detalhesProjeto');
                                },
                              );
                            });
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
