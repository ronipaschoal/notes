import 'package:flutter/material.dart';
import 'package:notes/datasources/repositories/note/note_mock.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/helpers/string.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/home/home_drawer.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/note_card.dart';
import 'package:notes/ui/scaffold.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  bool _isList = true;
  List<NoteModel> _noteList = noteListMock;

  Widget _list() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _noteList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemBuilder: (_, index) => NtNoteCard(note: _noteList[index]),
    );
  }

  Widget _grid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _noteList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (_, index) => NtNoteCard(note: _noteList[index]),
    );
  }

  TextField _search() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Pesquisar',
        prefixIcon: Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: NtColors.midGray, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: NtColors.darkGray, width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        contentPadding: EdgeInsets.all(16.0),
      ),
      onChanged: (value) => setState(() {
        _noteList = noteListMock
            .where(
              value.isEmpty
                  ? (note) => true
                  : (note) => note.title
                      .removeDiatrics()
                      .toLowerCase()
                      .contains(value.removeDiatrics().toLowerCase()),
            )
            .toList();
      }),
    );
  }

  Widget _title() {
    return const Image(
      height: 72.0,
      image: AssetImage('assets/icons/logo.png'),
    );
  }

  List<Widget> _actions() {
    return [
      IconButton(
        onPressed: () => setState(() => _isList = !_isList),
        icon: Icon(_isList ? Icons.grid_view : Icons.list),
      ),
    ];
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => NtNavigate.to(context, NtPaths.note),
      foregroundColor: NtColors.lightGray,
      backgroundColor: NtColors.darkGray,
      tooltip: 'Nova nota',
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(
          image: AssetImage('assets/icons/pencil.png'),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      color: NtColors.lightGray,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _search(),
            const SizedBox(height: 16.0),
            _isList ? _list() : _grid(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NtScaffold(
      title: _title(),
      actions: _actions(),
      drawer: const HomeDrawer(),
      floatingButton: _floatingButton(context),
      child: _body(context),
    );
  }
}
