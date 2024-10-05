import 'package:flutter/material.dart';

class RegistroPedidoPage extends StatefulWidget {
  @override
  _RegistroPedidoPageState createState() => _RegistroPedidoPageState();
}

class _RegistroPedidoPageState extends State<RegistroPedidoPage> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para os campos de texto
  final TextEditingController _quantidadeCafeController = TextEditingController();
  final TextEditingController _quantidadeAlmocoController = TextEditingController();
  final TextEditingController _quantidadeLancheController = TextEditingController();
  final TextEditingController _quantidadeJantarController = TextEditingController();
  
  // Variáveis para selecionar data e empresa
  DateTime _selectedDate = DateTime.now();
  String? _selectedEmpresa;

  // Exemplo de empresas disponíveis para seleção (pode ser carregado de um banco de dados)
  final List<String> _empresas = ['Empresa A', 'Empresa B', 'Empresa C'];

  // Método para salvar o pedido
  void _salvarPedido() {
    if (_formKey.currentState!.validate() && _selectedEmpresa != null) {
      // Adicione a lógica de salvar o pedido aqui
      print('Pedido salvo para a empresa $_selectedEmpresa na data $_selectedDate');
      _formKey.currentState!.reset();
    }
  }

  // Método para escolher uma data
  Future<void> _escolherData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Pedido'),
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
                // Seção Selecionar a Empresa
                Text(
                  'Selecione a Empresa',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedEmpresa,
                  hint: Text('Escolha a empresa'),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedEmpresa = newValue;
                    });
                  },
                  items: _empresas.map((empresa) {
                    return DropdownMenuItem(
                      value: empresa,
                      child: Text(empresa),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione uma empresa';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Divider(height: 1, color: Colors.grey),

                // Seção Selecionar a Data
                SizedBox(height: 20),
                Text(
                  'Selecione a Data',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _escolherData(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Data do Pedido',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: "${_selectedDate.toLocal()}".split(' ')[0],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione a data';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Divider(height: 1, color: Colors.grey),

                // Seção Quantidade de Refeições
                SizedBox(height: 20),
                Text(
                  'Quantidade de Refeições',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 10),
                _buildQuantidadeField(
                  controller: _quantidadeCafeController,
                  label: 'Café da Manhã',
                  icon: Icons.free_breakfast,
                ),
                SizedBox(height: 10),
                _buildQuantidadeField(
                  controller: _quantidadeAlmocoController,
                  label: 'Almoço',
                  icon: Icons.lunch_dining,
                ),
                SizedBox(height: 10),
                _buildQuantidadeField(
                  controller: _quantidadeLancheController,
                  label: 'Lanche',
                  icon: Icons.fastfood,
                ),
                SizedBox(height: 10),
                _buildQuantidadeField(
                  controller: _quantidadeJantarController,
                  label: 'Jantar',
                  icon: Icons.dinner_dining,
                ),

                // Espaço antes do botão
                SizedBox(height: 30),

                // Botão para Salvar o Pedido
                Center(
                  child: ElevatedButton(
                    onPressed: _salvarPedido,
                    child: Text('Salvar Pedido'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para criar campos de quantidade com estilo personalizado
  Widget _buildQuantidadeField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor, insira a quantidade para $label';
          }
          return null;
        },
      ),
    );
  }
}
