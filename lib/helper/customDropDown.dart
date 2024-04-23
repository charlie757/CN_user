import 'package:flutter/material.dart';

customDropDown(
    {required BuildContext context,
    required List<Map<String, dynamic>> itemList,
    value,
    var hintText,
    Function(Map<String, dynamic>)? onChanged}) {
  return Container(
    width: double.infinity,
    height: 50,
    padding: const EdgeInsets.only(left: 15, right: 5),
    decoration: BoxDecoration(
        border: Border.all(
          width: .6,
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(6)),
    child: DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        hint: Text(
          hintText ?? "",
          style: const TextStyle(color: Colors.black45, fontSize: 14),
        ),
        value: value,
        icon: const Icon(Icons.keyboard_arrow_down),
        items: itemList
            .map<DropdownMenuItem<dynamic>>((Map<String, dynamic> items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items['title'],
              style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Ubuntu',
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
          );
        }).toList(),
        onChanged: onChanged != null
            ? (dynamic newValue) {
                print("newvalue...$newValue");
                onChanged(newValue);
              }
            : null,
      ),
    ),
  );
}
