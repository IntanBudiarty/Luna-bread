import 'package:flutter/material.dart';

class PaymentMethodDropdown extends StatefulWidget {
  @override
  _PaymentMethodDropdownState createState() => _PaymentMethodDropdownState();
}

class _PaymentMethodDropdownState extends State<PaymentMethodDropdown> {
  String _selectedMethod = 'COD'; // Defaultnya adalah COD
  String _selectedBank = '';
  final Map<String, String> _bankAccounts = {
    'BCA': '123-456-7890',
    'BNI': '098-765-4321',
    'Mandiri': '112-233-4455',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown untuk memilih metode pembayaran
        DropdownButton<String>(
          value: _selectedMethod,
          onChanged: (String? newMethod) {
            setState(() {
              _selectedMethod = newMethod!;
            });
          },
          items:
              ['COD', 'Transfer Bank'].map((String method) {
                return DropdownMenuItem<String>(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
        ),
        if (_selectedMethod == 'Transfer Bank') ...[
          const SizedBox(height: 16),
          const Text('Pilih Bank:'),
          // Dropdown untuk memilih bank jika Transfer Bank dipilih
          DropdownButton<String>(
            value: _selectedBank.isEmpty ? null : _selectedBank,
            onChanged: (String? newBank) {
              setState(() {
                _selectedBank = newBank!;
              });
            },
            items:
                _bankAccounts.keys.map((String bank) {
                  return DropdownMenuItem<String>(
                    value: bank,
                    child: Text(bank),
                  );
                }).toList(),
          ),
          if (_selectedBank.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text('Nomor Rekening: ${_bankAccounts[_selectedBank]}'),
          ],
        ],
      ],
    );
  }
}
