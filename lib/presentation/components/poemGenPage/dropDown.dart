import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDown extends StatefulWidget {
  List<String>  items = [];
  String? title;
  DropDown({super.key,required this.items,required this.title});

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  // List<String> items = [
  //   'Thoughtful',
  //   'Creative',
  //   'Intelligent',
  //   'Curious',
  //   'Adventurous',
  //   'Passionate',
  //   'Determined',
  //   'Empathetic',
  // ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              widget.title!,
              style: GoogleFonts.manrope(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Colors.white, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 0),
                )
              ]
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedItem,
              hint: Text('Select an option', style: TextStyle(color: Colors.white)),
              dropdownColor: Colors.black,
              style: TextStyle(color: Colors.white),
              underline: SizedBox(),
              items: widget.items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
