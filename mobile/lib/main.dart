import 'package:flutter/material.dart';
import 'package:mobile/screen/list.dart';
import 'package:mobile/service/transacao_service.dart';

void main() {
  runApp(BancoApp());
}

class BancoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaTransacoes(), // Inicializando com a tela de listagem
    );
  }
}
