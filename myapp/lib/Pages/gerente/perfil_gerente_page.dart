import 'package:flutter/material.dart';

class PerfilGerentePage extends StatefulWidget {
  @override
  _PerfilGerentePageState createState() => _PerfilGerentePageState();
}

class _PerfilGerentePageState extends State<PerfilGerentePage> {
  // Controladores de texto para os campos de nome e e-mail
  final TextEditingController _nomeController = TextEditingController(text: 'Gerente');
  final TextEditingController _emailController = TextEditingController(text: 'gerente@example.com');

  bool _receberNotificacoes = true;
  bool _temaEscuro = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Gerente'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Informações Pessoais
            Text('Informações Pessoais', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),
            _buildTextField('Nome', _nomeController, Icons.person),
            SizedBox(height: 20),
            _buildTextField('E-mail', _emailController, Icons.email),
            SizedBox(height: 30),

            // Seção de Preferências
            Text('Preferências do App', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 20),

            // Switch para tema escuro
            SwitchListTile(
              title: Text('Tema Escuro'),
              value: _temaEscuro,
              onChanged: (bool value) {
                setState(() {
                  _temaEscuro = value;
                });
              },
              secondary: Icon(Icons.brightness_6),
            ),
            SizedBox(height: 10),

            // Switch para receber notificações
            SwitchListTile(
              title: Text('Receber Notificações'),
              value: _receberNotificacoes,
              onChanged: (bool value) {
                setState(() {
                  _receberNotificacoes = value;
                });
              },
              secondary: Icon(Icons.notifications),
            ),
            SizedBox(height: 30),

            // Botão para salvar as alterações
            Center(
              child: ElevatedButton(
                onPressed: _salvarAlteracoes,
                child: Text('Salvar Alterações'),
              ),
            ),
            SizedBox(height: 20),

            // Botão para logout
            Center(
              child: TextButton(
                onPressed: _logout,
                child: Text(
                  'Sair',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir campos de texto personalizados
  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Função para salvar as alterações feitas no perfil
  void _salvarAlteracoes() {
    // Aqui você pode adicionar a lógica para salvar as alterações no perfil
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterações salvas com sucesso!')),
    );
  }

  // Função para realizar logout
  void _logout() {
    // Aqui você pode adicionar a lógica de logout, como limpar dados do usuário e redirecionar para a tela de login
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logout realizado com sucesso!')),
    );
  }

  @override
  void dispose() {
    // Libera os recursos dos controladores de texto quando a tela for destruída
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
