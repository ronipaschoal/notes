import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/note_list/note_list_cubit.dart';
import 'package:notes/helpers/navigate.dart';
import 'package:notes/helpers/sizes.dart';
import 'package:notes/pages/home/cubit/home_cubit.dart';
import 'package:notes/pages/home/home_drawer.dart';
import 'package:notes/ui/colors.dart';
import 'package:notes/ui/note_card.dart';
import 'package:notes/ui/scaffold.dart';
import 'package:notes/ui/widgets/text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _serachController = TextEditingController();
  late final _cubit = context.read<HomeCubit>();
  static const _searchSize = 56.0;

  @override
  void initState() {
    super.initState();
    _cubit.loadNoteList();
  }

  @override
  Widget build(BuildContext context) {
    return NtScaffold(
      title: const Image(
        height: 72.0,
        image: AssetImage('assets/icons/logo.png'),
      ),
      actions: [
        BlocBuilder<HomeCubit, HomeState>(
          builder: (_, state) {
            return IconButton(
              onPressed: _cubit.changeViewType,
              icon: state.homeViewType == HomeViewType.list
                  ? const Icon(Icons.grid_view)
                  : const Icon(Icons.list),
            );
          },
        ),
      ],
      drawer: const HomeDrawer(),
      floatingButton: FloatingActionButton(
        onPressed: () => NavigateHelper.to(context, NtPaths.note),
        foregroundColor: NtColors.lightGray,
        backgroundColor: NtColors.darkGray,
        tooltip: 'Nova nota',
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/icons/pencil.png')),
        ),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (_, state) {
          return switch (state) {
            //TODO states implementation
            HomeInitialState() => const Center(child: Text('TODO')),
            HomeLoadingState() => const Center(child: Text('TODO')),
            HomeErrorState() => Center(child: Text(state.error)),
            HomeSuccessState() => Column(
                children: [
                  SizedBox(
                    height: _searchSize,
                    child: NtTextfield(
                      hintText: 'Pesquisar',
                      prefixIcon: const Icon(Icons.search),
                      controller: _serachController,
                      onChanged: (value) => _cubit.searchNote(value),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: SizesHelper.getUsableHeightAppBar(context) -
                          _searchSize,
                      child: state.homeViewType == HomeViewType.list
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.noteList.length,
                              itemBuilder: (_, index) => NtNoteCard(
                                isCard: false,
                                note: state.noteList[index],
                                onTap: () => NavigateHelper.to(
                                  context,
                                  NtPaths.note,
                                  extra: state.noteList[index].id,
                                ),
                                onLongPress: () => context
                                    .read<NoteListCubit>()
                                    .delete(state.noteList[index]),
                              ),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8.0),
                              shrinkWrap: true,
                              itemCount: state.noteList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 1.45,
                              ),
                              itemBuilder: (_, index) => NtNoteCard(
                                note: state.noteList[index],
                                onTap: () => NavigateHelper.to(
                                  context,
                                  NtPaths.note,
                                  extra: state.noteList[index].id,
                                ),
                                onLongPress: () => context
                                    .read<NoteListCubit>()
                                    .delete(state.noteList[index]),
                              ),
                            ),
                    ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
