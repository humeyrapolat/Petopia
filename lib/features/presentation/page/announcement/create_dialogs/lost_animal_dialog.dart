import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petopia/features/domain/entities/animal/animal_entity.dart';
import 'package:petopia/features/domain/entities/lost/lost_entity.dart';
import 'package:petopia/features/presentation/cubit/lost/lost_cubit.dart';

class LostAnimalDialog extends StatefulWidget {
  final AnimalEntity currentUser;

  const LostAnimalDialog({super.key, required this.currentUser});

  @override
  _LostAnimalDialogState createState() => _LostAnimalDialogState();
}

class _LostAnimalDialogState extends State<LostAnimalDialog> {
  late String selectedCity;
  late String selectedDistrict;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //TODO : Kullanıcı kaydı oluştururken kullanıcının adres bilgisini alalım
  // böylece il ve ilçe seçimlerini otomatik olarak yapabiliriz

  List<String> cities = ['İstanbul', 'Ankara', 'İzmir']; // Şehirlerin listesi
  Map<String, List<String>> districts = {
    'İstanbul': ['Kadıköy', 'Beşiktaş', 'Şişli'], // İstanbul ilçeleri
    'Ankara': ['Çankaya', 'Kızılay', 'Etimesgut'], // Ankara ilçeleri
    'İzmir': ['Karşıyaka', 'Bornova', 'Konak'], // İzmir ilçeleri
  };

  @override
  void initState() {
    // TODO: implement initState
    selectedCity = cities[0];
    selectedDistrict = districts[selectedCity]![0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Kayıp İlanı Oluştur'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Görsel yükleme alanı
          // Buraya görsel yükleme için bir widget ekleyebilirsiniz

          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'İsim',
            ),
          ),
          DropdownButtonFormField<String>(
            value: selectedCity,
            decoration: const InputDecoration(
              labelText: 'Şehir',
            ),
            items: cities.map((String city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedCity = newValue!;
                selectedDistrict = null!; // İlçe seçimi sıfırlanıyor
              });
            },
          ),
          if (selectedCity != null)
            DropdownButtonFormField<String>(
              value: selectedDistrict,
              decoration: const InputDecoration(
                labelText: 'İlçe',
              ),
              items: districts[selectedCity]!.map((String district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistrict = newValue!;
                });
              },
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            _createLost(context);
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

  _createLost(BuildContext context) {
    BlocProvider.of<LostCubit>(context)
        .createLost(
            lost: LostEntity(
                city: selectedCity,
                age: 1,
                creatorUid: widget.currentUser.uid,
                name: _nameController.text,
                date: DateTime.now(),
                lostAnimalId: widget.currentUser.uid! + Random().nextInt(100).toString(),
                imageUrl: "url",
                isKnowName: true))
        .then((value) {
      _clear();
      Navigator.of(context).pop();
    });
  }

  _clear() {
    setState(() {
      selectedCity = cities[0];
      selectedDistrict = districts[selectedCity]![0];
    });
  }
}

// Dialogu çağırmak için kullanabileceğiniz örnek kullanım:
// showDialog(context: context, builder: (context) => LostItemDialog());
