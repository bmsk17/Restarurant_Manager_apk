import 'package:flutter/material.dart';
import 'package:myapp/Pages/cadastros/cadastro_empresa_page.dart';
import 'package:myapp/Pages/cadastros/cadastro_refeicao_page.dart';
import 'package:myapp/Pages/financeiro/financeiro_page.dart';
import 'package:myapp/Pages/gerente/perfil_gerente_page.dart';
import 'package:myapp/Pages/pedido/lista_pedidos_page.dart';
import 'package:myapp/Pages/pedido/registro_pedido_page.dart';
import 'package:myapp/Pages/refeicao/detalhes_refeicao_page.dart';
import 'package:myapp/Pages/relatorio/relatorio_mensal_page.dart';
import 'package:myapp/Pages/relatorio/resumo_diario_page.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciamento'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            // Botão para Cadastro de Empresa
            _buildNavigationButton(
              context,
              label: 'Cadastro Empresa',
              icon: Icons.business,
              destination: CadastroEmpresaPage(),
            ),
            // Comentando os botões que não possuem telas ainda
            
            _buildNavigationButton(
              context,
              label: 'Cadastro Refeição',
              icon: Icons.restaurant_menu,
              destination: CadastroRefeicaoPage(),
            ),
            
            _buildNavigationButton(
              context,
              label: 'Registrar Pedido',
              icon: Icons.add_shopping_cart,
              destination: RegistroPedidoPage(),
            ),

            
            _buildNavigationButton(
              context,
              label: 'Lista de Pedidos',
              icon: Icons.list,
              destination: ListaPedidosPage(),
            ),
            
            _buildNavigationButton(
              context,
              label: 'Detalhes Refeição',
              icon: Icons.info_outline,
              destination: DetalhesRefeicaoPage(),
            ),
            
            _buildNavigationButton(
              context,
              label: 'Financeiro',
              icon: Icons.account_balance_wallet,
              destination: FinanceiroPage(),
            ),
            
            _buildNavigationButton(
              context,
              label: 'Resumo Diário',
              icon: Icons.today,
              destination: ResumoDiarioPage(),
            ),

            
            _buildNavigationButton(
              context,
              label: 'Relatório Mensal',
              icon: Icons.insert_chart,
              destination: RelatorioMensalPage(),
            ),

            _buildNavigationButton(
              context,
              label: 'Perfil Gerente',
              icon: Icons.person,
              destination: PerfilGerentePage(),
            ),
          ],
        ),
      ),
    );
  }

  // Função para criar cada botão de navegação
  Widget _buildNavigationButton(BuildContext context,
      {required String label, required IconData icon, required Widget destination}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        onPrimary: Theme.of(context).primaryColor,
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Theme.of(context).primaryColor),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
