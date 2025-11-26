import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  const SearchBarWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:  TextField(
        controller: controller,
        decoration:const InputDecoration(
          hintText: "Search here...",
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.brown),
        ),
      ),
    );
  }
}
