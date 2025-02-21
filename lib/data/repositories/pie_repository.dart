import 'package:visualizador_charts/data/data_sources/local_data_source.dart';
import 'package:visualizador_charts/data/models/pie_model.dart';

class PieRepository {
  PieModel obtenerDatosPie() {
    final datos = localDataSource.obtenerDatos(TipoChart.pie);
    return PieModel.convertirDeDataLocal(
      datosEtiquetas: datos.datosEjeX,
      datosValores: datos.datosEjeY,
    );
  }

  Future<void> guardarDatosPie(PieModel modelo) async {
    await localDataSource.setEjeX(data: modelo.etiquetas, tipo: TipoChart.pie);
    await localDataSource.setEjeY(
        data: modelo.valores.map((e) => e.toString()).toList(),
        tipo: TipoChart.pie);
  }
}

final pieRepository = PieRepository();