import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget visionViaje(Function ()? onTap, QueryDocumentSnapshot doc){
  
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(218, 194, 184, 184),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fecha de Tarifa:"+doc["Fecha de Tarifa"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
          Text(
             "Origen:"+doc["Origen"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
          Text(
            "Destino:"+doc["Destino"],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: Colors.black,
            ),
          ),
        ],
      )
    ),
  );
}