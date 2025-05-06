import 'package:flutter/material.dart'; //Para acceder a los widgets básicos como Scaffold, Column, etc

class CustomerSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final VoidCallback? onClear;

  const CustomerSearchBar({super.key, required this.onChanged, this.onClear});

  @override
  State<CustomerSearchBar> createState() => CustomerSearchBarState();
}

class CustomerSearchBarState extends State<CustomerSearchBar> {
  final TextEditingController _controller = TextEditingController();

  void clear() {
    _controller.clear();
    widget.onChanged('');
    if (widget.onClear != null) widget.onClear!();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          hintText: "Buscar Pokémon",
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(icon: Icon(Icons.clear), onPressed: clear),
          border: OutlineInputBorder(),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
