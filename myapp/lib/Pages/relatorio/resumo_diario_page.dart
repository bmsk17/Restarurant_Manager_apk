import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class ResumoDiarioPage extends StatefulWidget {
  @override
  _ResumoDiarioPageState createState() => _ResumoDiarioPageState();
}

class _ResumoDiarioPageState extends State<ResumoDiarioPage> {
  // Dados fictícios para os pedidos
  final List<Map<String, dynamic>> _resumoPedidos = [
    {
      'empresa': 'Empresa A',
      'cafe': 10,
      'almoco': 15,
      'lanche': 5,
      'jantar': 8,
      'valorTotal': 280.0,
    },
    {
      'empresa': 'Empresa B',
      'cafe': 8,
      'almoco': 12,
      'lanche': 4,
      'jantar': 6,
      'valorTotal': 220.0,
    },
    {
      'empresa': 'Empresa C',
      'cafe': 12,
      'almoco': 18,
      'lanche': 6,
      'jantar': 10,
      'valorTotal': 350.0,
    },
  ];

  DateTime _selectedDate = DateTime.now();

  // Método para selecionar uma data
  Future<void> _escolherData(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
        title: Text('Resumo Diário'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo para selecionar a data
            Text('Selecione a Data',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _escolherData(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Data do Resumo',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  controller: TextEditingController(
                    text: DateFormat('dd/MM/yyyy').format(_selectedDate),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Título da tabela de resumo
            Text('Resumo de Pedidos',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),

            // Tabela com Resumo de Pedidos
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Empresa')),
                    DataColumn(label: Text('Café')),
                    DataColumn(label: Text('Almoço')),
                    DataColumn(label: Text('Lanche')),
                    DataColumn(label: Text('Jantar')),
                    DataColumn(label: Text('Valor Total (R\$)')),
                  ],
                  rows: _resumoPedidos.map((pedido) {
                    return DataRow(cells: [
                      DataCell(Text(pedido['empresa'])),
                      DataCell(Text(pedido['cafe'].toString())),
                      DataCell(Text(pedido['almoco'].toString())),
                      DataCell(Text(pedido['lanche'].toString())),
                      DataCell(Text(pedido['jantar'].toString())),
                      DataCell(Text(pedido['valorTotal'].toStringAsFixed(2))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Gráfico Simples (Pizza Chart)
            Text('Visualização de Refeições',
                style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            Expanded(
              child: _buildPieChart(),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir o gráfico de pizza
  Widget _buildPieChart() {
    // Calcula os totais de cada refeição
    final totalCafe =
        _resumoPedidos.fold(0, (sum, pedido) => sum + pedido['cafe'] as int);
    final totalAlmoco =
        _resumoPedidos.fold(0, (sum, pedido) => sum + pedido['almoco'] as int);
    final totalLanche =
        _resumoPedidos.fold(0, (sum, pedido) => sum + pedido['lanche'] as int);
    final totalJantar =
        _resumoPedidos.fold(0, (sum, pedido) => sum + pedido['jantar'] as int);

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: [
          _buildPieChartSection('Café', totalCafe.toDouble(), Colors.blue),
          _buildPieChartSection('Almoço', totalAlmoco.toDouble(), Colors.red),
          _buildPieChartSection(
              'Lanche', totalLanche.toDouble(), Colors.orange),
          _buildPieChartSection('Jantar', totalJantar.toDouble(), Colors.green),
        ],
      ),
    );
  }

  // Método auxiliar para criar seções do gráfico de pizza
  PieChartSectionData _buildPieChartSection(
      String title, double value, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      title: '$title (${value.toInt()})',
      radius: 60,
      titleStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
