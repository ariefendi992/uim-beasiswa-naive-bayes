import 'package:flutter/material.dart';
import 'package:ft_uim_naive_bayes/utils/theme.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String title;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;

  const CustomDropdownFormField({
    Key? key,
    required this.title,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField(
            focusColor: kGreyColor,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(defaultRadius),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(color: kBlackColor)),
              focusColor: kBlackColor,
            ),
            hint: Text('.:: Pilih ::.'),
            items: items,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}
