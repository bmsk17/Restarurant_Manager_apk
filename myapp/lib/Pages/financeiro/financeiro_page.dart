import 'package:flutter/material.dart';

class FinanceiroPage extends StatefulWidget {
  @override
  _FinanceiroPageState createState() => _FinanceiroPageState();
}

class _FinanceiroPageState extends State<FinanceiroPage> {
  // Dados fictícios para os pedidos financeiros
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

  // Variáveis para filtros
  String _filtroPeriodo = 'Dia';
  String _filtroStatus = '';

  @override
  Widget build(BuildContext context) {
    // Filtra os pedidos conforme os filtros selecionados
    List<Map<String, dynamic>> pedidosFiltrados = _pedidos.where((pedido) {
      if (_filtroStatus.isNotEmpty && pedido['status'] != _filtroStatus) {
        return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Financeiro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filtro por Período
            _buildFiltroPeriodo(),
            SizedBox(height: 10),

            // Filtro por Status de Pagamento
            _buildFiltroStatus(),
            SizedBox(height: 20),

            // Título da lista de pedidos
            Text(
              'Pedidos Financeiros',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),

            // Lista de Pedidos (envolvida em Expanded)
            Expanded(
              child: ListView.builder(
                itemCount: pedidosFiltrados.length,
                itemBuilder: (context, index) {
                  final pedido = pedidosFiltrados[index];
                  return _buildPedidoItem(pedido);
                },
              ),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
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
            ),
            // Botão para marcar como pago com borda
            if (pedido['status'] == 'Pendente')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      _marcarComoPago(pedido);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).primaryColor), // Adiciona a borda
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Borda arredondada
                      ),
                    ),
                    child: Text(
                      'Marcar como Pago',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget para construir o campo de filtro por período
  Widget _buildFiltroPeriodo() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Filtrar por Período',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: _filtroPeriodo,
      items: [
        DropdownMenuItem(child: Text('Dia'), value: 'Dia'),
        DropdownMenuItem(child: Text('Semana'), value: 'Semana'),
        DropdownMenuItem(child: Text('Mês'), value: 'Mês'),
      ],
      onChanged: (value) {
        setState(() {
          _filtroPeriodo = value!;
        });
      },
    );
  }

  // Widget para construir o campo de filtro por status de pagamento
  Widget _buildFiltroStatus() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Filtrar por Status de Pagamento',
        prefixIcon: Icon(Icons.filter_list),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      value: _filtroStatus.isEmpty ? null : _filtroStatus,
      items: [
        DropdownMenuItem(child: Text('Todos'), value: ''),
        DropdownMenuItem(child: Text('Pendente'), value: 'Pendente'),
        DropdownMenuItem(child: Text('Pago'), value: 'Pago'),
      ],
      onChanged: (value) {
        setState(() {
          _filtroStatus = value ?? '';
        });
      },
    );
  }

  // Método para marcar um pedido como pago
  void _marcarComoPago(Map<String, dynamic> pedido) {
    setState(() {
      pedido['status'] = 'Pago';
    });
  }
}
