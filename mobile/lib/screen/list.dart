import 'package:flutter/material.dart';
import 'formulario.dart';
import 'package:mobile/service/transacao_service.dart';

class ListaTransacoes extends StatefulWidget {
  @override
  _ListaTransacoesState createState() => _ListaTransacoesState();
}

class _ListaTransacoesState extends State<ListaTransacoes> {
  final TransacoesService _service = TransacoesService();
  List<Map<String, dynamic>> _transacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarTransacoes();
  }

  Future<void> _carregarTransacoes() async {
    final transacoes = await _service.getAll();
    setState(() {
      _transacoes = transacoes;
    });
  }

  void _adicionarTransacao(Map<String, dynamic> transacao) async {
    await _service.create(transacao);
    _carregarTransacoes(); // Atualizar a lista após adicionar
  }

  void _editarTransacao(int id, Map<String, dynamic> transacao) async {
    await _service.update(id, transacao);
    _carregarTransacoes(); // Atualizar a lista após editar
  }

  void _deletarTransacao(int id) async {
    await _service.delete(id);
    _carregarTransacoes(); // Atualizar a lista após deletar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Transações'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Formulario(
                    onSubmit: (novaTransacao) {
                      _adicionarTransacao(novaTransacao);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _transacoes.length,
        itemBuilder: (context, index) {
          final transacao = _transacoes[index];
          return ListTile(
            title: Text(transacao['descricao'] ?? 'Sem descrição'),
            subtitle: Text('Valor: ${transacao['valor']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Formulario(
                          transacao: transacao,
                          onSubmit: (transacaoEditada) {
                            _editarTransacao(transacao['id'], transacaoEditada);
                          },
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deletarTransacao(transacao['id']);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
