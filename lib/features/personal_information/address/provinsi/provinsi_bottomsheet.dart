import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/bottomsheet_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/provinsi/provinsi_bloc.dart';

class ProvinsiBottomSheet extends StatefulWidget {
  const ProvinsiBottomSheet({super.key});

  @override
  State<ProvinsiBottomSheet> createState() =>
      _ProvinsiBottomSheetState();
}

class _ProvinsiBottomSheetState extends State<ProvinsiBottomSheet> {
  late final ProvinsiBloc bloc;

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
          title: 'Pilih Provinsi',
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
