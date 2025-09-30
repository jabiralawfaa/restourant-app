import 'package:flutter/material.dart';
import 'package:restaurant_app/data/pesanan.dart';

class ListMenu extends StatelessWidget {
  final Pesanan item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const ListMenu({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Quantity Circle (Left)
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                item.jumlah.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Item Name (Center-Left)
          Expanded(
            flex: 2,
            child: Text(
              item.nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          
          // Price (Center-Right)
          Text(
            'Rp ${item.harga.toInt()}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Remove Button
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.remove,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),
          
          const SizedBox(width: 8),
          
          // Add Button
          GestureDetector(
            onTap: onAdd,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Icon(
                Icons.add,
                size: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}