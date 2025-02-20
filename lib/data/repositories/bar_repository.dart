import 'package:visualizador_charts/data/data_sources/local_data_source.dart';
import 'package:visualizador_charts/data/models/bar_model.dart';

class BarRepository {
  final LocalDataSource localDataSource;
  final tipoChart = TipoChart.bar;

  BarRepository({required this.localDataSource});

  BarModel obtenerDatosBarras() {
    final barrasDatos = localDataSource.obtenerDatos(tipoChart);

    return BarModel.convertirDeDataLocal(barrasDatos);
  }

  void guardarBarrasDatos(BarModel barModel) async {
    await localDataSource.setEjeX(data: barModel.ejeX, tipo: tipoChart);
    await localDataSource.setEjeY(
      data: barModel.ejeY.map((elemento) {
        return elemento.toString();
      }).toList(),
      tipo: tipoChart,
    );
  }
}

final barRepository = BarRepository(localDataSource: localDataSource);
