import 'package:flutter/material.dart';

class TileDeGraficos extends StatelessWidget {
  final String titulo;
  final VoidCallback alPresionar;

  const TileDeGraficos({
    required this.titulo,
    required this.alPresionar,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(titulo),
      trailing: Icon(Icons.arrow_forward),
      onTap: alPresionar,
    );
  }
}
