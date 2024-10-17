import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CadastrarPage extends StatefulWidget {
  const CadastrarPage({super.key});

  @override
  _CadastrarPageState createState() => _CadastrarPageState();
}

class _CadastrarPageState extends State<CadastrarPage> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();
  final TextEditingController _valorAtendimentoController = TextEditingController();
  final TextEditingController _lembreteController = TextEditingController();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2029),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _saveData() {
    String titulo = _tituloController.text.toUpperCase();
    String nomeCliente = _nomeClienteController.text;
    String telefone = _telefoneController.text;
    String endereco = _enderecoController.text;
    String lembrete = _lembreteController.text.isNotEmpty ? _lembreteController.text : "Sem lembrete";
    String valorAtendimento = _valorAtendimentoController.text;
    String dataAtendimento = _selectedDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
        : "Data não selecionada";

    // Aqui criamos um mapa com os dados para enviar de volta à HomePage
    Map<String, dynamic> atendimentoData = {
      'titulo': titulo,
      'subtitulo': 'Cliente: $nomeCliente, Data: $dataAtendimento',
      'estado': 0 // Estado inicial como 'verde'
    };

    // Retorna os dados para a página anterior (HomePage)
    Navigator.pop(context, atendimentoData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Procedimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título do Procedimento',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nomeClienteController,
              decoration: const InputDecoration(
                labelText: 'Nome do Cliente',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Número de Telefone',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _enderecoController,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(_selectedDate == null
                  ? 'Selecione a Data do Procedimento'
                  : 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _valorAtendimentoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor do Procedimento (em Reais)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _lembreteController,
              decoration: const InputDecoration(
                labelText: 'Observações (Opcional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('SALVAR'),
            ),
          ],
        ),
      ),
    );
  }
}
