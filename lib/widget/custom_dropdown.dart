import 'package:flutter/material.dart';

class GenericDropdown<T> extends StatefulWidget {
  final List<T>? items;
  final T? selectedValue;
  final String Function(T)? getDisplayValue;
  final String Function(T)? getValue;
  final void Function(String)? onChanged;
  final InputDecoration? decoration;
  final FocusNode? focusNode;

  const GenericDropdown(
      {super.key,
      this.items,
      this.getDisplayValue,
      this.getValue,
      this.onChanged,
      this.selectedValue,
      this.decoration,
      this.focusNode});

  @override
  _GenericDropdownState<T> createState() => _GenericDropdownState<T>();
}

class _GenericDropdownState<T> extends State<GenericDropdown<T>> {
  String? currentValue;

  @override
  void initState() {
    super.initState();

    if (widget.items != null && widget.items!.isNotEmpty) {
      //// Check if items are not null or empty and set the initial value
      if (widget.selectedValue != null) {
        currentValue = widget.getValue!(widget.selectedValue as T);
      } else {
        currentValue = widget.getValue!(widget.items!.first);
      }
    } else {
      currentValue = null; // Ensure currentValue is null if items are empty
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items == null || widget.items!.isEmpty) {
      // Return disabled DropdownButton with a placeholder if items are null or empty
      return DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: widget.decoration ?? widget.decoration,
          value: null,
          items: const [
            DropdownMenuItem<String>(
              value: null,
              child: Tooltip(
                message: 'This is a very long text that might not fit',
                child: Text(
                  'Long text...',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
          onChanged: (newValue) {
            setState(() {
              currentValue = newValue;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(newValue!);
            }
          },
          focusNode: widget.focusNode // Disable interaction
          );
    } else {
      // Return a normal functioning DropdownButton
      return DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: widget.decoration ?? widget.decoration,
        value: currentValue,
        onChanged: (newValue) {
          setState(() {
            currentValue = newValue;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(newValue!);
          }
        },
        focusNode: widget.focusNode,
        items: widget.items!.map((T item) {
          return DropdownMenuItem<String>(
            value: widget.getValue!(item),
            child: Text(widget.getDisplayValue!(item)),
          );
        }).toList(),
      );
    }
  }
}
