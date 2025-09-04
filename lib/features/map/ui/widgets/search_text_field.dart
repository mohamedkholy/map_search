import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final void Function() onClosePressed;
  final void Function(String) ontextChanged;
  final void Function() onTap;
  final ValueListenable<bool> isResultsVisible;
  final TextEditingController searchController;
  final FocusNode focusNode;
  const SearchTextField({
    super.key,
    required this.onClosePressed,
    required this.ontextChanged,
    required this.onTap,
    required this.isResultsVisible,
    required this.searchController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: onTap,
              controller: searchController,
              focusNode: focusNode,
              onChanged: ontextChanged,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey.shade500),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: isResultsVisible,
            builder: (context, value, child) {
              return value ? child! : Container();
            },
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: onClosePressed,
            ),
          ),
        ],
      ),
    );
  }
}
