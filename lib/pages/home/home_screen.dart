import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/helpers/sizes.dart';
import 'package:notes/models/note/note_model.dart';
import 'package:notes/pages/home/cubit/home_cubit.dart';
import 'package:notes/pages/home/home_drawer.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/note_card.dart';
import 'package:notes/ui/scaffold.dart';
import 'package:notes/ui/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _serachController = TextEditingController();

  List<Widget> _actions(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return [
      BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          return IconButton(
            onPressed: cubit.changeViewType,
            icon: state.homeViewType == HomeViewType.list
                ? const Icon(Icons.grid_view)
                : const Icon(Icons.list),
          );
        },
      ),
    ];
  }

  Widget _list(List<NoteModel> noteList) {
    return ListView.separated(
      padding: const EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: noteList.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8.0),
      itemBuilder: (_, index) => NtNoteCard(note: noteList[index]),
    );
  }

  Widget _grid(List<NoteModel> noteList) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      shrinkWrap: true,
      itemCount: noteList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 1.45,
      ),
      itemBuilder: (_, index) => NtNoteCard(note: noteList[index]),
    );
  }

  Widget _title() {
    return const Image(
      height: 72.0,
      image: AssetImage('assets/icons/logo.png'),
    );
  }

  Widget _floatingButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => NtNavigate.to(context, NtPaths.note),
      foregroundColor: NtColors.lightGray,
      backgroundColor: NtColors.darkGray,
      tooltip: 'Nova nota',
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Image(image: AssetImage('assets/icons/pencil.png')),
      ),
    );
  }

  Widget _success(BuildContext context, HomeSuccessState state) {
    const searchSize = 56.0;
    final cubit = context.read<HomeCubit>();

    return Column(
      children: [
        SizedBox(
          height: searchSize,
          child: NtTextfield(
            hintText: 'Pesquisar',
            prefixIcon: const Icon(Icons.search),
            controller: _serachController,
            onChanged: (value) => cubit.searchNote(value),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: SizesHelper.getUsableHeightAppBar(context) - searchSize,
            child: state.homeViewType == HomeViewType.list
                ? _list(state.noteList)
                : _grid(state.noteList),
          ),
        ),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (_, state) {
        return switch (state) {
          //TODO states implementation
          HomeInitialState() => const Center(child: Text('TODO')),
          HomeLoadingState() => const Center(child: Text('TODO')),
          HomeErrorState() => Center(child: Text(state.error)),
          HomeSuccessState() => _success(context, state),
        };
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    cubit.loadNoteList();

    return NtScaffold(
      title: _title(),
      actions: _actions(context),
      drawer: const HomeDrawer(),
      floatingButton: _floatingButton(context),
      child: _body(context),
    );
  }
}
