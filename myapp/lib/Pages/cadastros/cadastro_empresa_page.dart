import 'package:flutter/material.dart';

class CadastroEmpresaPage extends StatefulWidget {
  @override
  _CadastroEmpresaPageState createState() => _CadastroEmpresaPageState();
}

class _CadastroEmpresaPageState extends State<CadastroEmpresaPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _contatoController = TextEditingController();
  final TextEditingController _precoCafeController = TextEditingController();
  final TextEditingController _precoAlmocoController = TextEditingController();
  final TextEditingController _precoLancheController = TextEditingController();
  final TextEditingController _precoJantarController = TextEditingController();

  void _salvarEmpresa() {
    if (_formKey.currentState!.validate()) {
      // Lógica para salvar os dados
      print('Empresa Salva: ${_nomeController.text}');
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Empresa'),
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
                // Título da Seção
                Text('Informações da Empresa', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                _buildTextField(
                    controller: _nomeController,
                    label: 'Nome da Empresa',
                    icon: Icons.business),
                _buildTextField(
                    controller: _cnpjController,
                    label: 'CNPJ',
                    icon: Icons.confirmation_number),
                _buildTextField(
                    controller: _enderecoController,
                    label: 'Endereço',
                    icon: Icons.location_on),
                _buildTextField(
                    controller: _contatoController,
                    label: 'Contato (Telefone/Email)',
                    icon: Icons.contact_phone),
                SizedBox(height: 20),
                Text('Preços das Refeições', style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                _buildTextField(
                    controller: _precoCafeController,
                    label: 'Preço do Café da Manhã (R\$)',
                    icon: Icons.free_breakfast),
                _buildTextField(
                    controller: _precoAlmocoController,
                    label: 'Preço do Almoço (R\$)',
                    icon: Icons.lunch_dining),
                _buildTextField(
                    controller: _precoLancheController,
                    label: 'Preço do Lanche (R\$)',
                    icon: Icons.fastfood),
                _buildTextField(
                    controller: _precoJantarController,
                    label: 'Preço do Jantar (R\$)',
                    icon: Icons.dinner_dining),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarEmpresa,
                    child: Text('Salvar Empresa'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
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
