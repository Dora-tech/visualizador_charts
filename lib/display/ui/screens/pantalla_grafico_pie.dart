import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PantallaGraficoPie extends StatefulWidget {
  const PantallaGraficoPie({super.key});

  @override
  _PantallaGraficoPieState createState() => _PantallaGraficoPieState();
}

class _PantallaGraficoPieState extends State<PantallaGraficoPie> {
  final TextEditingController _etiquetaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  List<String> etiquetas = [];
  List<double> valores = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  Future<void> _cargarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      etiquetas = prefs.getStringList('etiquetas') ?? [];
      valores = prefs.getStringList('valores')?.map((e) => double.parse(e)).toList() ?? [];
    });
  }

  Future<void> _guardarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('etiquetas', etiquetas);
    prefs.setStringList('valores', valores.map((e) => e.toString()).toList());
  }

  void _agregarValor() {
    String etiqueta = _etiquetaController.text.trim();
    double? valor = double.tryParse(_valorController.text);

    if (etiqueta.isNotEmpty && valor != null) {
      setState(() {
        etiquetas.add(etiqueta);
        valores.add(valor);
      });
      _guardarDatos();
      _etiquetaController.clear();
      _valorController.clear();
    }
  }

  void _borrarUltimo() {
    if (etiquetas.isNotEmpty && valores.isNotEmpty) {
      setState(() {
        etiquetas.removeLast();
        valores.removeLast();
      });
      _guardarDatos();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Pie'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), // Regresar al menú principal
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: valores.asMap().entries.map((entry) {
                  int index = entry.key;
                  return PieChartSectionData(
                    value: entry.value,
                    title: etiquetas[index],
                    color: Colors.primaries[index % Colors.primaries.length],
                    radius: 80,
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _etiquetaController,
                  decoration: InputDecoration(labelText: "Etiqueta"),
                ),
                TextField(
                  controller: _valorController,
                  decoration: InputDecoration(labelText: "Valor"),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _agregarValor,
                      icon: Icon(Icons.add),
                      label: Text("Agregar"),
                    ),
                    ElevatedButton.icon(
                      onPressed: _borrarUltimo,
                      icon: Icon(Icons.delete),
                      label: Text("Borrar Último"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _etiquetaController.dispose();
    _valorController.dispose();
    super.dispose();
  }
}