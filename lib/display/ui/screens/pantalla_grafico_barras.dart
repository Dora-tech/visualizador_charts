import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualizador_charts/data/models/bar_model.dart';
import 'package:visualizador_charts/data/repositories/bar_repository.dart';
import 'package:visualizador_charts/display/ui/components/input_grafico.dart';
import 'package:visualizador_charts/display/ui/utils/utils.dart';

class PantallaGraficoBarras extends StatefulWidget {
  const PantallaGraficoBarras({super.key});

  @override
  State<PantallaGraficoBarras> createState() => _PantallaGraficoBarrasState();
}

class _PantallaGraficoBarrasState extends State<PantallaGraficoBarras> {
  final _ejeXTextEditingController = TextEditingController();
  final _ejeYTextEditingController = TextEditingController();
  final _idFormulario = GlobalKey<FormState>();

  BarModel? _barModel;

  @override
  void initState() {
    super.initState();
    setState(() {
      _barModel = barRepository.obtenerDatosBarras();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_barModel == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico de barras'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      direction: TooltipDirection.bottom,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(_barModel!.ejeX[value.toInt()]);
                        },
                      ),
                    ),
                  ),
                  barGroups: _barModel!.ejeY.asMap().entries.map((valor) {
                    return BarChartGroupData(
                      x: valor.key,
                      barRods: [
                        BarChartRodData(toY: valor.value, color: Colors.blue),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Form(
            key: _idFormulario,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 8,
                children: [
                  InputGrafico(
                    controller: _ejeXTextEditingController,
                    label: 'Dato eje X',
                    autocorrect: false,
                    textInputType: TextInputType.text,
                    validator: (valor) {
                      return ValidacionDeData.validarCampoObligatorio(valor);
                    },
                  ),
                  InputGrafico(
                    controller: _ejeYTextEditingController,
                    label: 'Dato eje Y',
                    autocorrect: false,
                    textInputType: TextInputType.number,
                    validator: (valor) {
                      return ValidacionDeData.validarNumero(valor);
                    },
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final esValiado = _idFormulario.currentState?.validate();
                      final barModel = _barModel;

                      if (esValiado == true && barModel != null) {
                        setState(() {
                          barModel.ejeX.add(_ejeXTextEditingController.text);
                          barModel.ejeY.add(
                              double.parse(_ejeYTextEditingController.text));
                        });

                        barRepository.guardarBarrasDatos(barModel);
                      }
                    },
                    label: const Text('Agregar'),
                    icon: Icon(Icons.add),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Alertas.mostrarAlertaDeConfirmacion(context,
                          alBorrar: (ctx) {
                        final barModel = _barModel;
                        if (barModel != null) {
                          setState(() {
                            barModel.ejeX.removeLast();
                            barModel.ejeY.removeLast();
                          });

                          barRepository.guardarBarrasDatos(barModel);

                          Navigator.pop(ctx);
                        }
                      });
                    },
                    label: const Text('Borrar último'),
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _ejeXTextEditingController.dispose();
    _ejeYTextEditingController.dispose();
  }
}
