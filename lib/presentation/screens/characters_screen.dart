import 'package:blockflutter/presentation/blocs/character_bloc.dart';
import 'package:blockflutter/presentation/blocs/characters_events.dart';
import 'package:blockflutter/presentation/blocs/characters_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CharactersScreen extends StatefulWidget{
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen>{
  String _filter = '';

  @override
  void inisState(){
    super.initState();
    context.read<CharacterBloc>().add(LoadCharactersEvent(_filter));
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Personajes de Harry Potter')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value){
                      setState(() {
                        _filter = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Filtrar por nombre',
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: (){
                    context
                      .read<CharacterBloc>().add(LoadCharactersEvent(_filter));
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<CharacterBloc, CharacterState>(
              builder: (context, state) {
                if(state.isLoading){
                  return const Center(child: CircularProgressIndicator());
                }
                else if(state.errorMessage.isNotEmpty){
                  return Center(child: Text(state.errorMessage));
                }
                else if(state.characters.isNotEmpty){
                  return ListView.builder(
                    itemCount: state.characters.length,
                    itemBuilder: (context, index){
                      final character = state.characters[index];
                      return ListTile(
                        leading: Image.network(character.image),
                        title: Text(character.name),
                        subtitle: Text(character.house),
                      );
                    }
                  );
                }
                else{
                  return const Center(
                    child: Text('No hay personajes que coincidan con el filtro'),
                  );
                }
              },
            ),
          )
        ],
      )
    );
  }
}