import 'package:flutter/material.dart';

class RoundedSearchBar extends StatefulWidget {
  const RoundedSearchBar({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.onTextChanged,
  }) : super(key: key);

  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  final Function()? onTextChanged;

  @override
  State<RoundedSearchBar> createState() => _RoundedSearchBarState();
}

class _RoundedSearchBarState extends State<RoundedSearchBar> {
  late ColorScheme colorScheme;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    textEditingController.addListener(() {
      if (widget.onTextChanged != null) widget.onTextChanged!();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    colorScheme = Theme.of(context).colorScheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: 'Search',
          border: OutlineInputBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          filled: true,
          fillColor: colorScheme.primaryContainer,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: suffixIcon(),
        ),
      ),
    );
  }

  Widget? suffixIcon() {
    if (textEditingController.text.isNotEmpty) {
      return const Icon(Icons.close);
    }
    return null;
  }
}
