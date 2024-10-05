import 'package:flutter/material.dart';

class CadastroRefeicaoPage extends StatefulWidget {
  @override
  _CadastroRefeicaoPageState createState() => _CadastroRefeicaoPageState();
}

class _CadastroRefeicaoPageState extends State<CadastroRefeicaoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _tipoRefeicaoController = TextEditingController();
  final TextEditingController _precoRefeicaoController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  // Método para salvar a refeição
  void _salvarRefeicao() {
    if (_formKey.currentState!.validate()) {
      // Adicione a lógica de salvar a refeição
      print('Refeição salva: ${_tipoRefeicaoController.text} - ${_precoRefeicaoController.text}');
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Refeição'),
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
                // Título
                Text(
                  'Detalhes da Refeição',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                
                // Campo para Tipo de Refeição
                _buildTextField(
                  controller: _tipoRefeicaoController,
                  label: 'Tipo de Refeição',
                  icon: Icons.fastfood,
                ),
                
                // Campo para Preço da Refeição
                _buildTextField(
                  controller: _precoRefeicaoController,
                  label: 'Preço (R\$)',
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                
                // Campo para Descrição
                _buildTextField(
                  controller: _descricaoController,
                  label: 'Descrição',
                  icon: Icons.description,
                  maxLines: 3,
                ),
                
                SizedBox(height: 30),
                
                // Botão para Salvar a Refeição
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarRefeicao,
                    child: Text('Salvar Refeição'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para criar os campos de entrada com estilo personalizado
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira o $label';
          }
          return null;
        },
      ),
    );
  }
}
