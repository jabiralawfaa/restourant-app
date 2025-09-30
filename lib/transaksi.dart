import 'package:flutter/material.dart';
import 'package:restaurant_app/data/pesanan.dart';

class TransaksiPage extends StatelessWidget {
  final List<Pesanan> pesananTerpilih;

  const TransaksiPage({
    super.key,
    required this.pesananTerpilih,
  });

  @override
  Widget build(BuildContext context) {
    // Saring pesanan yang memiliki jumlah > 0
    final List<Pesanan> pesananAktif = pesananTerpilih.where((item) => item.jumlah > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Anda'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header "PESANAN" dan Garis
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Divider(thickness: 1.5),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pesananAktif.length,
              itemBuilder: (context, index) {
                final item = pesananAktif[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      // Jumlah Pesanan
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                          child: Text(
                            '${item.jumlah}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Nama Makanan
                      Expanded(
                        child: Text(
                          item.nama,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      // Harga per Item
                      Text(
                        'Rp. ${item.harga}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Tampilkan pop-up "Transaksi berhasil"
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Transaksi Berhasil"),
                        content: const Text("Pesanan Anda telah berhasil dibuat."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); 
                              Navigator.of(context).pop(); 
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Bayar'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Batal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}