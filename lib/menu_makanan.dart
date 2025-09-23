import 'package:flutter/material.dart';
import 'package:restaurant_app/data/pesanan.dart';
import 'package:restaurant_app/components/list_menu.dart';
import 'package:restaurant_app/transaksi.dart';

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

enum MenuCategory { makanan, minuman }

class _MenuMakananPageState extends State<MenuMakananPage> {
  MenuCategory currentCategory = MenuCategory.makanan;
  int currentPage = 1;
  int itemsPerPage = 5;

  Map<MenuCategory, List<Pesanan>> menuData = {
    MenuCategory.makanan: [
      Pesanan(nama: 'Makanan 1', harga: 5000),
      Pesanan(nama: 'Makanan 2', harga: 5000),
      Pesanan(nama: 'Makanan 3', harga: 5000),
      Pesanan(nama: 'Makanan 4', harga: 5000),
      Pesanan(nama: 'Makanan 5', harga: 5000),
    ],
    MenuCategory.minuman: [
      Pesanan(nama: 'Minuman 1', harga: 7000),
      Pesanan(nama: 'Minuman 2', harga: 7000),
      Pesanan(nama: 'Minuman 3', harga: 7000),
      Pesanan(nama: 'Minuman 4', harga: 7000),
      Pesanan(nama: 'Minuman 5', harga: 7000),
    ],
  };

  List<Pesanan> get currentItems => menuData[currentCategory] ?? [];
  int get totalPages => 4; // Fixed total pages as shown in reference
  
  List<Pesanan> get displayedItems {
    if (currentPage <= 2) {
      // Pages 1-2: Makanan
      if (currentCategory != MenuCategory.makanan) {
        setState(() {
          currentCategory = MenuCategory.makanan;
        });
      }
      return menuData[MenuCategory.makanan] ?? [];
    } else {
      // Pages 3-4: Minuman
      if (currentCategory != MenuCategory.minuman) {
        setState(() {
          currentCategory = MenuCategory.minuman;
        });
      }
      return menuData[MenuCategory.minuman] ?? [];
    }
  }

  void _tambahPesanan(int index) {
    setState(() {
      currentItems[index].jumlah++;
    });
  }

  void _kurangiPesanan(int index) {
    setState(() {
      if (currentItems[index].jumlah > 0) {
        currentItems[index].jumlah--;
      }
    });
  }

  void _resetPesanan() {
    setState(() {
      for (var category in menuData.values) {
        for (var item in category) {
          item.jumlah = 0;
        }
      }
    });
  }

  void _changePage(int page) {
    setState(() {
      currentPage = page;
      // Update category based on page
      if (page <= 2) {
        currentCategory = MenuCategory.makanan;
      } else {
        currentCategory = MenuCategory.minuman;
      }
    });
  }

  void _previousPage() {
    if (currentPage > 1) {
      _changePage(currentPage - 1);
    }
  }

  void _nextPage() {
    if (currentPage < totalPages) {
      _changePage(currentPage + 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        title: const Text('MENUS'),
        backgroundColor: Color(0xFFF5F3FF),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetPesanan,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              currentCategory == MenuCategory.makanan ? 'Makanan' : 'Minuman',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Items List
          Expanded(
            child: ListView.builder(
              itemCount: displayedItems.length,
              itemBuilder: (context, index) {
                return ListMenu(
                  item: displayedItems[index],
                  onAdd: () => _tambahPesanan(index),
                  onRemove: () => _kurangiPesanan(index),
                );
              },
            ),
          ),
          
          // Pagination
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Previous Button
                GestureDetector(
                  onTap: currentPage > 1 ? _previousPage : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, size: 16, 
                             color: currentPage > 1 ? Colors.black : Colors.grey),
                        Text('Previous', 
                             style: TextStyle(
                               color: currentPage > 1 ? Colors.black : Colors.grey)),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Page Numbers
                ...List.generate(totalPages, (index) {
                  int pageNum = index + 1;
                  bool isActive = pageNum == currentPage;
                  
                  return GestureDetector(
                    onTap: () => _changePage(pageNum),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isActive ? Colors.black : Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        pageNum.toString(),
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.black,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }),
                
                const SizedBox(width: 16),
                
                // Next Button
                GestureDetector(
                  onTap: currentPage < totalPages ? _nextPage : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      children: [
                        Text('Next',
                             style: TextStyle(
                               color: currentPage < totalPages ? Colors.black : Colors.grey)),
                        Icon(Icons.chevron_right, size: 16,
                             color: currentPage < totalPages ? Colors.black : Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Color(0xFFF5F3FF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // tombol Transaction
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Get all selected items from both categories
                    final pesananTerpilih = <Pesanan>[];
                    for (var category in menuData.values) {
                      pesananTerpilih.addAll(category.where((item) => item.jumlah > 0));
                    }
                    
                    if (pesananTerpilih.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Silakan pilih setidaknya 1 menu.'),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransaksiPage(
                          pesananTerpilih: pesananTerpilih,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Transaction'),
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
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('Reset'),
                ),
              )
            ],
          )),
    );
  }
}
