import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/bottomsheet_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/lama_bekerja/lama_bekerja_bloc.dart';

class LamaBekerjaBottomSheet extends StatefulWidget {
  const LamaBekerjaBottomSheet({super.key});

  @override
  State<LamaBekerjaBottomSheet> createState() =>
      _LamaBekerjaBottomSheetState();
}

class _LamaBekerjaBottomSheetState extends State<LamaBekerjaBottomSheet> {
  late final LamaBekerjaBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomSheetAppBar(
          title: 'Pilih Lama Bekerja',
        ),
        Flexible(
          child: Scrollbar(
            thumbVisibility: true,
            child: ListView.builder(
              itemCount: bloc.items.length,
              shrinkWrap: true,
              itemBuilder: (_, int i) => CustomListTile(
                title: bloc.items[i],
                useDefaultTrail: false,
                onTap: () => Navigator.pop(
                  context,
                  bloc.items[i],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
