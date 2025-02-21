import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualizador_charts/data/models/pie_model.dart';
import 'package:visualizador_charts/data/repositories/pie_repository.dart';
import 'package:visualizador_charts/display/ui/components/input_grafico.dart';
import 'package:visualizador_charts/display/ui/utils/utils.dart'; // ✅ Importación agregada

class PantallaGraficoPie extends StatefulWidget {
  const PantallaGraficoPie({super.key});

  @override
  State<PantallaGraficoPie> createState() => _PantallaGraficoPieState();
}

class _PantallaGraficoPieState extends State<PantallaGraficoPie> {
  final TextEditingController _etiquetaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  PieModel _pieModel = PieModel(etiquetas: [], valores: []); // ✅ Inicializa el modelo para evitar null

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() async {
    final datosPie = await pieRepository.obtenerDatosPie();
    setState(() {
      _pieModel = datosPie;
    });
  }

  void _agregarValor() {
    final etiqueta = _etiquetaController.text.trim();
    final valor = double.tryParse(_valorController.text);

    if (etiqueta.isNotEmpty && valor != null) {
      setState(() {
        _pieModel.etiquetas.add(etiqueta);
        _pieModel.valores.add(valor);
      });

      pieRepository.guardarDatosPie(_pieModel);
      _etiquetaController.clear();
      _valorController.clear();
    }
  }

  void _borrarUltimo() {
    if (_pieModel.etiquetas.isNotEmpty && _pieModel.valores.isNotEmpty) {
      setState(() {
        _pieModel.etiquetas.removeLast();
        _pieModel.valores.removeLast();
      });

      pieRepository.guardarDatosPie(_pieModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de Pie'),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back), // ✅ Ícono estilo iOS
          onPressed: () => Navigator.pop(context), // Volver al menú principal
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sections: _pieModel.valores.asMap().entries.map((entry) {
                  int index = entry.key;
                  return PieChartSectionData(
                    value: entry.value,
                    title: _pieModel.etiquetas[index],
                    color: PieModel.getColor(_pieModel.etiquetas[index]), // ✅ Color corregido
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
                InputGrafico(
                  label: 'Etiqueta',
                  controller: _etiquetaController,
                  autocorrect: false,
                  textInputType: TextInputType.text,
                ),
                InputGrafico(
                  label: 'Valor',
                  controller: _valorController,
                  autocorrect: false,
                  textInputType: TextInputType.number,
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