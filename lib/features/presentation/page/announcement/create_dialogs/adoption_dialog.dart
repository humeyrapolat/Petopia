import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/adoption/adoption_entity.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/presentation/cubit/adoption/adoption_cubit.dart';
import 'package:uuid/uuid.dart';

class AdoptionAnimalDialog extends StatefulWidget {
  final AnimalEntity currentUser;

  const AdoptionAnimalDialog({super.key, required this.currentUser});

  @override
  State<AdoptionAnimalDialog> createState() => _AdoptionAnimalDialogState();
}

class _AdoptionAnimalDialogState extends State<AdoptionAnimalDialog> {
  String sehir = "";
  String hayvanTuru = "";
  int hayvanYasi = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Hayvan Sahiplendirme Formu'),
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
            _createAdoption(context);
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

  _createAdoption(BuildContext context) {
    BlocProvider.of<AdoptionCubit>(context)
        .createAdoption(
            adoption: AdoptionEntity(
      city: sehir,
      type: hayvanTuru,
      age: hayvanYasi,
      adoptionPostId: const Uuid().v1(),
      creatorUid: widget.currentUser.uid,
    ))
        .then((value) {
      _clear();
      Navigator.of(context).pop();
    });
  }

  _clear() {
    setState(() {
      sehir = "";
      hayvanTuru = "";
      hayvanYasi = 0;
    });
  }
}
