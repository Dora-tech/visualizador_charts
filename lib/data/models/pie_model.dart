import 'package:flutter/material.dart';
class PieModel {
  final List<String> etiquetas;
  final List<double> valores;

  PieModel({required this.etiquetas, required this.valores});

  // Mapeo de colores para las etiquetas ingresadas por el usuario
  static const Map<String, Color> colorMap = {
    'rojo': Colors.red,
    'azul': Colors.blue,
    'verde': Colors.green,
    'amarillo': Colors.yellow,
    'negro': Colors.black,
    'morado': Colors.purple,
    'naranja': Colors.orange,
    'rosado': Colors.pink,
    'gris': Colors.grey,
  };

  // Método para obtener el color asociado a una etiqueta
  static Color getColor(String etiqueta) {
    return colorMap[etiqueta.toLowerCase()] ?? Colors.grey;
  }

  factory PieModel.convertirDeDataLocal({
    required List<String> datosEtiquetas,
    required List<String> datosValores,
  }) {
    final valoresConvertidos = datosValores.map((valor) => double.tryParse(valor) ?? 0.0).toList();
    
    return PieModel(
      etiquetas: datosEtiquetas,
      valores: valoresConvertidos,
    );
  }
}