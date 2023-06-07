import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdoptionAnimalDialog extends StatelessWidget {
  String sehir = "";
  String hayvanTuru = "";
  int hayvanYasi = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hayvan Sahiplenme Formu'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: const InputDecoration(
              labelText: 'Şehir',
            ),
            onChanged: (value) {
              sehir = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Hayvan Türü',
            ),
            onChanged: (value) {
              hayvanTuru = value;
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Hayvan Yaşı',
            ),
            onChanged: (value) {
              hayvanYasi = int.parse(value);
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // İlanı gönderme işlemleri burada gerçekleştirilebilir
            Navigator.of(context).pop();
          },
          child: const Text('Gönder'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('İptal'),
        ),
      ],
    );
  }
}
