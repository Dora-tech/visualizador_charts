import 'package:visualizador_charts/data/data_sources/local_data_source.dart';
import 'package:visualizador_charts/data/models/line_model.dart';

class LineRepository {
  final LocalDataSource localDataSource;
  final tipoChart = TipoChart.line;

  LineRepository({required this.localDataSource});

  LineModel obtenerDatos() {
    final puntosDatos = localDataSource.obtenerDatos(tipoChart);

    return LineModel.convertirDeDataLocal(puntosDatos);
  }

  void guardarPuntosDatos(LineModel lineModel) async {
    await localDataSource.setEjeX(
      data: lineModel.ejeX.map((elemento) {
        return elemento.toString();
      }).toList(),
      tipo: tipoChart,
    );
    await localDataSource.setEjeY(
      data: lineModel.ejeY.map((elemento) {
        return elemento.toString();
      }).toList(),
      tipo: tipoChart,
    );
  }
}

final lineRepository = LineRepository(localDataSource: localDataSource);
