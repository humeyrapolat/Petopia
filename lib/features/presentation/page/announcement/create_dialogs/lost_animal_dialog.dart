import 'package:flutter/material.dart';

class LostAnimalDialog extends StatefulWidget {
  @override
  _LostAnimalDialogState createState() => _LostAnimalDialogState();
}

class _LostAnimalDialogState extends State<LostAnimalDialog> {
  late String selectedCity;
  late String selectedDistrict;

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

          const TextField(
            decoration: InputDecoration(
              labelText: 'İsim',
            ),
          ),

          const TextField(
            decoration: InputDecoration(
              labelText: 'Açıklama',
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

// Dialogu çağırmak için kullanabileceğiniz örnek kullanım:
// showDialog(context: context, builder: (context) => LostItemDialog());
