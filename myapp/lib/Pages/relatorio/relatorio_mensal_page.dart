import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class RelatorioMensalPage extends StatefulWidget {
  @override
  _RelatorioMensalPageState createState() => _RelatorioMensalPageState();
}

class _RelatorioMensalPageState extends State<RelatorioMensalPage> {
  // Dados fictícios para o relatório mensal
  final List<Map<String, dynamic>> _relatorioMensal = [
    {
      'empresa': 'Empresa A',
      'totalCafe': 100,
      'totalAlmoco': 150,
      'totalLanche': 50,
      'totalJantar': 80,
      'faturamento': 2800.0,
    },
    {
      'empresa': 'Empresa B',
      'totalCafe': 80,
      'totalAlmoco': 120,
      'totalLanche': 40,
      'totalJantar': 60,
      'faturamento': 2200.0,
    },
    {
      'empresa': 'Empresa C',
      'totalCafe': 120,
      'totalAlmoco': 180,
      'totalLanche': 60,
      'totalJantar': 100,
      'faturamento': 3500.0,
    },
  ];

  DateTime _selectedMonth = DateTime.now();

  // Método para selecionar o mês e o ano
  Future<void> _escolherMes(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      // Mostra apenas mês e ano no calendário
      initialDatePickerMode: DatePickerMode.year,
    );
    if (pickedDate != null && pickedDate != _selectedMonth) {
      setState(() {
        _selectedMonth = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Relatório Mensal'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo para selecionar o mês e o ano
            Text('Selecione o Mês e Ano', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => _escolherMes(context),
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Mês do Relatório',
                    prefixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  controller: TextEditingController(
                    text: DateFormat('MMMM yyyy', 'pt_BR').format(_selectedMonth),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Título da tabela de resumo
            Text('Resumo Mensal', style: Theme.of(context).textTheme.headline6),
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
                    DataColumn(label: Text('Faturamento (R\$)')),
                  ],
                  rows: _relatorioMensal.map((pedido) {
                    return DataRow(cells: [
                      DataCell(Text(pedido['empresa'])),
                      DataCell(Text(pedido['totalCafe'].toString())),
                      DataCell(Text(pedido['totalAlmoco'].toString())),
                      DataCell(Text(pedido['totalLanche'].toString())),
                      DataCell(Text(pedido['totalJantar'].toString())),
                      DataCell(Text(pedido['faturamento'].toStringAsFixed(2))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Gráfico Simples (Bar Chart)
            Text('Visualização do Faturamento', style: Theme.of(context).textTheme.headline6),
            SizedBox(height: 10),
            Expanded(
              child: _buildBarChart(),
            ),
          ],
        ),
      ),
    );
  }

  // Função para construir o gráfico de barras
  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxFaturamento(),
        barTouchData: BarTouchData(enabled: true),
        titlesData: FlTitlesData(
          leftTitles: SideTitles(showTitles: true),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) {
              return _relatorioMensal[value.toInt()]['empresa'];
            },
            getTextStyles: (context, value) => TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarChartGroups(),
      ),
    );
  }

  // Função para construir grupos de barras para o gráfico
  List<BarChartGroupData> _buildBarChartGroups() {
    return _relatorioMensal.asMap().entries.map((entry) {
      int index = entry.key;
      Map<String, dynamic> pedido = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: pedido['faturamento'].toDouble(),
            width: 20,
            colors: [Colors.blue],
          ),
        ],
      );
    }).toList();
  }

  // Função para obter o valor máximo de faturamento para ajustar o gráfico
  double _getMaxFaturamento() {
    double maxFaturamento = _relatorioMensal.fold(
        0.0, (max, pedido) => max > pedido['faturamento'] ? max : pedido['faturamento']);
    return maxFaturamento + (maxFaturamento * 0.1); // Adiciona 10% ao topo para ajustar o gráfico
  }
}
