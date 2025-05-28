import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:note_taker/features/home_screen/bloc/bloc.dart';
import 'package:note_taker/features/home_screen/bloc/state.dart';
import 'package:note_taker/generated/assets.dart';
import 'package:note_taker/shared/model/note.dart';

import 'bloc/event.dart';
import 'screen_wrapper.dart';

const List<Color> noteColors = [
  Color(0xFFC4FFCA),
  Color(0xFFC5CBFF),
  Color(0xFFFBBECF),
  Color(0xFF96F4F4),
  Color(0xFFFDF3BF),
  Color(0xFFFEC5FF),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Recent Notes'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(Assets.iconsSearch),
            ),
          ],
          actionsPadding: const EdgeInsets.only(right: 16.0),
        ),
        body: SafeArea(
          child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              return _buildNotes(context, state.notes);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildNotes(BuildContext context, List<Note> notes) {
    if (notes.isEmpty) {
      return Center(child: Text('No notes available'));
    }
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeScreenBloc>().add(LoadNotesEvent());
      },
      child: MasonryGridView.count(
        padding: const EdgeInsets.all(32),
        crossAxisCount: 2,
        mainAxisSpacing: 14,
        crossAxisSpacing: 20,
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];

          int randomNumber = Random.secure().nextInt(100);
          Color randomColor = noteColors[randomNumber % noteColors.length];

          return Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: randomColor,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  note.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(note.content),
              ],
            ),
          );
        },
      ),
    );
  }
}
