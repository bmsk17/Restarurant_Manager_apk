import 'package:flutter/material.dart';

class ListaPedidosPage extends StatefulWidget {
  @override
  _ListaPedidosPageState createState() => _ListaPedidosPageState();
}

class _ListaPedidosPageState extends State<ListaPedidosPage> {
  // Dados fictícios para os pedidos (para simulação)
  final List<Map<String, dynamic>> _pedidos = [
    {
      'data': '2023-10-01',
      'empresa': 'Empresa A',
      'status': 'Pendente',
      'valorTotal': 200.0,
    },
    {
      'data': '2023-10-02',
      'empresa': 'Empresa B',
      'status': 'Pago',
      'valorTotal': 350.0,
    },
    {
      'data': '2023-10-03',
      'empresa': 'Empresa C',
      'status': 'Pendente',
      'valorTotal': 150.0,
    },
    {
      'data': '2023-10-04',
      'empresa': 'Empresa A',
      'status': 'Pago',
      'valorTotal': 500.0,
    },
  ];

  // Variáveis de filtragem
  String _filtroEmpresa = '';
  String _filtroStatus = '';

  @override
  Widget build(BuildContext context) {
    // Filtra os pedidos conforme os filtros selecionados
    List<Map<String, dynamic>> pedidosFiltrados = _pedidos.where((pedido) {
      if (_filtroEmpresa.isNotEmpty &&
          !pedido['empresa'].toLowerCase().contains(_filtroEmpresa.toLowerCase())) {
        return false;
      }
      if (_filtroStatus.isNotEmpty && pedido['status'] != _filtroStatus) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Pedidos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Filtros
            Text(
              'Filtrar Pedidos',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            _buildFiltroEmpresa(),
            SizedBox(height: 10),
            _buildFiltroStatus(),
            SizedBox(height: 20),

            // Título da lista de pedidos
            Text(
              'Pedidos Registrados',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),

            // Lista de Pedidos
            Expanded(
              child: pedidosFiltrados.isNotEmpty
                  ? ListView.builder(
                      itemCount: pedidosFiltrados.length,
                      itemBuilder: (context, index) {
                        final pedido = pedidosFiltrados[index];
                        return _buildPedidoItem(pedido);
                      },
                    )
                  : Center(child: Text('Nenhum pedido encontrado')),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir o item do pedido na lista
  Widget _buildPedidoItem(Map<String, dynamic> pedido) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: pedido['status'] == 'Pago'
              ? Colors.green
              : Colors.orange,
          radius: 24,
          child: Icon(
            pedido['status'] == 'Pago' ? Icons.check : Icons.access_time,
            color: Colors.white,
          ),
        ),
        title: Text(
          pedido['empresa'],
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              'Data: ${pedido['data']}',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14),
            ),
            Text(
              'Status: ${pedido['status']}',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14),
            ),
          ],
        ),
        trailing: Text(
          'R\$ ${pedido['valorTotal'].toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
        ),
        onTap: () {
          // Ação ao clicar em um pedido (ex: exibir detalhes ou editar)
        },
      ),
    );
  }

  // Widget para construir o campo de filtro por empresa
  Widget _buildFiltroEmpresa() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Filtrar por Empresa',
        prefixIcon: Icon(Icons.business),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _filtroEmpresa = value;
        });
      },
    );
  }

  // Widget para construir o campo de filtro por status
  Widget _buildFiltroStatus() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Filtrar por Status',
        prefixIcon: Icon(Icons.filter_list),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: _filtroStatus.isEmpty ? null : _filtroStatus,
      items: [
        DropdownMenuItem(child: Text('Pendente'), value: 'Pendente'),
        DropdownMenuItem(child: Text('Pago'), value: 'Pago'),
        DropdownMenuItem(child: Text('Todos'), value: ''),
      ],
      onChanged: (value) {
        setState(() {
          _filtroStatus = value ?? '';
        });
      },
    );
  }
}
