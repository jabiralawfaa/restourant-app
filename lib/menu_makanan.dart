import 'package:flutter/material.dart';
import 'package:restaurant_app/data/pesanan.dart';
import 'package:restaurant_app/components/list_menu.dart';

void main() {
  runApp(const MenuMakananApp());
}

class MenuMakananApp extends StatelessWidget {
  const MenuMakananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuMakananPage(),
    );
  }
}

class MenuMakananPage extends StatefulWidget {
  const MenuMakananPage({super.key});
  @override
  _MenuMakananPageState createState() => _MenuMakananPageState();
}

class _MenuMakananPageState extends State<MenuMakananPage> {
  List<Pesanan> menuMakanan = [
    Pesanan(nama: 'Nasi Goreng', harga: 15000),
    Pesanan(nama: 'Mie Ayam', harga: 12000),
    Pesanan(nama: 'Sate Ayam', harga: 20000),
    Pesanan(nama: 'Gado-Gado', harga: 13000),
    Pesanan(nama: 'Bakso', harga: 14000),
  ];
  
  void _tambahPesanan(int index) {
    setState(() {
      menuMakanan[index].jumlah++;
    });
  }

  void _kurangiPesanan(int index) {
    setState(() {
      if (menuMakanan[index].jumlah > 0) {
        menuMakanan[index].jumlah--;
      }
    });
  }

  void _resetPesanan() {
    setState(() {
      for (var item in menuMakanan) {
        item.jumlah = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Makanan'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetPesanan,
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          itemCount: menuMakanan.length,
          itemBuilder: (context, index) {
            return ListMenu(
              item: menuMakanan[index],
              onAdd: () => _tambahPesanan(index),
              onRemove: () => _kurangiPesanan(index),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // tombol Transaksi
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'transaksi');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                child: const Text('Transaksi'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: _resetPesanan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16)
                ),
                child: const Text('Reset'),
              ),
            )
          ],
        )
      ),
    );
  }

}