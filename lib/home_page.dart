import 'package:flutter/material.dart';
import 'cadastrar_page.dart'; // Importa a página de cadastro

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define o estado inicial de cada item (0 - verde, 1 - laranja, 2 - vermelho, 3 - cinza com ícone de artigo)
  List<int> itemStates = [0, 1, 2, 3];
  List<String> titles = [
    "PROCEDIMENTO CONCLUÍDO",
    "PROCEDIMENTO DENTRO DO PRAZO",
    "PROCEDIMENTO FORA DO PRAZO",
    "AJUDA COM AS ATIVIDADES",
  ];
  List<String> subtitles = [
    "Quando você concluir o procedimento, registre ao clicar no item com marcação verde.",
    "Quando o procedimento estiver dentro do prazo, registre no item com marcação em amarelo.",
    "Quando o procedimento estiver fora do prazo, registre no item com marcação em vermelho.",
    "Utilize esse recurso para melhor gerenciamento de suas atividades, você pode excluir com icone lixeira e manter ambiente organizado. Bom trabalho :)"
  ];

  List<String> filteredTitles = [];
  List<String> filteredSubtitles = [];
  List<int> filteredItemStates = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredTitles = List.from(titles);
    filteredSubtitles = List.from(subtitles);
    filteredItemStates = List.from(itemStates);

    searchController.addListener(() {
      _filterItems(searchController.text);
    });
  }

  void _filterItems(String query) {
    List<String> newTitles = [];
    List<String> newSubtitles = [];
    List<int> newItemStates = [];

    // Filtra os itens de acordo com o texto da busca
    if (query.isEmpty) {
      newTitles = List.from(titles);
      newSubtitles = List.from(subtitles);
      newItemStates = List.from(itemStates);
    } else {
      for (int i = 0; i < titles.length; i++) {
        if (titles[i].toLowerCase().contains(query.toLowerCase())) {
          newTitles.add(titles[i]);
          newSubtitles.add(subtitles[i]);
          newItemStates.add(itemStates[i]);
        }
      }
    }

    setState(() {
      filteredTitles = newTitles;
      filteredSubtitles = newSubtitles;
      filteredItemStates = newItemStates;
    });
  }

  void _toggleState(int index) {
    setState(() {
      // Muda o estado entre 0 (verde), 1 (laranja), 2 (vermelho), e 3 (cinza default)
      filteredItemStates[index] = (filteredItemStates[index] + 1) % 4;
      int originalIndex = titles.indexOf(filteredTitles[index]);
      itemStates[originalIndex] = filteredItemStates[index];
    });
  }

  void _removeItem(int index) {
    setState(() {
      int originalIndex = titles.indexOf(filteredTitles[index]);
      titles.removeAt(originalIndex);
      subtitles.removeAt(originalIndex);
      itemStates.removeAt(originalIndex);

      filteredTitles.removeAt(index);
      filteredSubtitles.removeAt(index);
      filteredItemStates.removeAt(index);
    });
  }

  // Função para obter a cor e o ícone com base no estado do item
  Map<String, dynamic> _getColorAndIcon(int state) {
    switch (state) {
      case 0:
        return {
          'color': Colors.green,
          'icon': Icons.check_circle,
        };
      case 1:
        return {
          'color': Colors.orange,
          'icon': Icons.access_time,
        };
      case 2:
        return {
          'color': Colors.red,
          'icon': Icons.warning,
        };
      case 3: // Estado padrão para novos cadastros: ícone article e cor cinza
      default:
        return {
          'color': Colors.grey,
          'icon': Icons.article, // Ícone article na cor cinza
        };
    }
  }

  // Função que abre a página de cadastro e aguarda os dados retornados
  Future<void> _navigateToCadastro() async {
    final newAtendimento = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastrarPage()),
    );

    // Se houver novos dados retornados, adiciona à lista
    if (newAtendimento != null) {
      setState(() {
        titles.add(newAtendimento['titulo']);
        subtitles.add(newAtendimento['subtitulo']);
        itemStates.add(3); // Novo item começa com o estado 3 (cinza, ícone article)

        // Atualiza os itens filtrados após adicionar um novo item
        filteredTitles = List.from(titles);
        filteredSubtitles = List.from(subtitles);
        filteredItemStates = List.from(itemStates);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Notas"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/visualizar');
                },
                child: const Text('VISUALIZAR'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/agenda');
                },
                child: const Text('AGENDA'),
              ),
              ElevatedButton(
                onPressed: _navigateToCadastro, // Abre a página de cadastro
                child: const Text('CADASTRAR'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Pesquisar por título',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTitles.length,
              itemBuilder: (context, index) {
                var stateData = _getColorAndIcon(filteredItemStates[index]);
                return GestureDetector(
                  onTap: () => _toggleState(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: stateData['color'],
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(
                        stateData['icon'],
                        color: stateData['color'],
                      ),
                      title: Text(
                        filteredTitles[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(filteredSubtitles[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeItem(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}