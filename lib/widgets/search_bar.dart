import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white70),
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/search-normal.png", color: Colors.white70),
                      SizedBox(width: 10),
                      Text(
                        'Search for your task...',
                        style: TextStyle(color: Colors.white70, fontFamily: "Lato", fontSize: 16),
                      ),
                    ],
                  ),
                );
  }
}