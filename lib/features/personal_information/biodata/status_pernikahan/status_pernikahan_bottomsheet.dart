import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/bottomsheet_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/status_pernikahan/status_pernikahan_bloc.dart';

class StatusPernikahanBottomSheet extends StatefulWidget {
  const StatusPernikahanBottomSheet({super.key});

  @override
  State<StatusPernikahanBottomSheet> createState() =>
      _StatusPernikahanBottomSheetState();
}

class _StatusPernikahanBottomSheetState extends State<StatusPernikahanBottomSheet> {
  late final StatusPernikahanBloc bloc;

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
          title: 'Pilih Status Pernikahan',
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
