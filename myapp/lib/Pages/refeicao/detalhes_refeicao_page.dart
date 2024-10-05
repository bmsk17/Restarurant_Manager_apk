import 'package:flutter/material.dart';

class DetalhesRefeicaoPage extends StatefulWidget {
  // Dados fictícios de exemplo para a refeição
  final Map<String, dynamic> refeicao = {
    'tipo': 'Almoço',
    'data': '2023-10-05',
    'quantidade': 10,
    'precoUnitario': 25.0,
  };

  @override
  _DetalhesRefeicaoPageState createState() => _DetalhesRefeicaoPageState();
}

class _DetalhesRefeicaoPageState extends State<DetalhesRefeicaoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos
  late TextEditingController _quantidadeController;
  late TextEditingController _precoUnitarioController;

  @override
  void initState() {
    super.initState();
    // Inicializando os controladores com os dados da refeição fictícia
    _quantidadeController =
        TextEditingController(text: widget.refeicao['quantidade'].toString());
    _precoUnitarioController =
        TextEditingController(text: widget.refeicao['precoUnitario'].toString());
  }

  @override
  void dispose() {
    // Liberando recursos ao destruir a tela
    _quantidadeController.dispose();
    _precoUnitarioController.dispose();
    super.dispose();
  }

  // Método para salvar as alterações na refeição
  void _salvarAlteracoes() {
    if (_formKey.currentState!.validate()) {
      // Aqui deve ser implementada a lógica de atualização da refeição
      print('Refeição atualizada: ${_quantidadeController.text}, ${_precoUnitarioController.text}');
      // Fechar a tela ao salvar
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Refeição'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Exibindo o tipo da refeição
                Text(
                  'Tipo de Refeição: ${widget.refeicao['tipo']}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),

                // Campo para Data
                Text(
                  'Data da Refeição: ${widget.refeicao['data']}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Divider(height: 30),

                // Campo para Quantidade
                Text('Quantidade', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 8),
                TextFormField(
                  controller: _quantidadeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantidade',
                    prefixIcon: Icon(Icons.fastfood),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a quantidade';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Campo para Preço Unitário
                Text('Preço Unitário (R\$)', style: Theme.of(context).textTheme.subtitle1),
                SizedBox(height: 8),
                TextFormField(
                  controller: _precoUnitarioController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: 'Preço Unitário',
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o preço unitário';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Exibir o total calculado
                _buildTotalPrice(),

                SizedBox(height: 30),

                // Botão para salvar alterações
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarAlteracoes,
                    child: Text('Salvar Alterações'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para calcular e exibir o preço total
  Widget _buildTotalPrice() {
    double quantidade = double.tryParse(_quantidadeController.text) ?? 0;
    double precoUnitario = double.tryParse(_precoUnitarioController.text) ?? 0;
    double total = quantidade * precoUnitario;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total: R\$ ${total.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
