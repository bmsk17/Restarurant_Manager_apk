import 'package:flutter/material.dart';
import 'package:myapp/Pages/cadastros/cadastro_empresa_page.dart';
import 'package:myapp/Pages/home/home_page.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  // Inicializa o Flutter para suportar código assíncrono
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa os dados de localidade para a formatação de datas
  await initializeDateFormatting('pt_BR', null);

  // Executa o aplicativo Flutter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodyapp Gerenciamento',
      theme: _buildFoodyAppTheme(),
      debugShowCheckedModeBanner: false, // Desabilita o banner de debug
      home:  HomePage(),
    );
  }
}

// Método para construir o tema personalizado "Foodyapp"
ThemeData _buildFoodyAppTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
    // Cores principais do tema
    primaryColor: Color(0xFF32CD32), // Verde vibrante
    colorScheme: base.colorScheme.copyWith(
      primary: Color(0xFF32CD32), // Verde vibrante
      secondary: Color(0xFF32CD32), // Acento verde
    ),
    scaffoldBackgroundColor: Color(0xFFF8F8F8), // Fundo claro
    
    // Estilos de AppBar
    appBarTheme: AppBarTheme(
      elevation: 0, // Remove sombra
      backgroundColor: Colors.transparent, // Fundo transparente
      iconTheme: IconThemeData(color: Colors.black), // Ícones pretos
      titleTextStyle: TextStyle( // Ajuste correto para texto da AppBar
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Estilos de Botão
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF32CD32), // Cor do botão
        onPrimary: Colors.white, // Texto do botão
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordas arredondadas
        ),
        elevation: 5,
      ),
    ),

    // Estilo de Inputs/TextFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // Remove bordas visíveis
      ),
      labelStyle: TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      prefixIconColor: Color(0xFF32CD32), // Cor do ícone prefixo
    ),

    // Tipografia Geral
    textTheme: base.textTheme.copyWith(
      headline1: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      bodyText2: TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
      button: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    
    // Outras personalizações
    iconTheme: IconThemeData(color: Color(0xFF32CD32)),
  );
}