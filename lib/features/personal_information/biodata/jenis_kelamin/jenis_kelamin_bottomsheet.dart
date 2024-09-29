import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/components/bottomsheet_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/jenis_kelamin/jenis_kelamin_bloc.dart';

class JenisKelaminBottomSheet extends StatefulWidget {
  const JenisKelaminBottomSheet({super.key});

  @override
  State<JenisKelaminBottomSheet> createState() =>
      _JenisKelaminBottomSheetState();
}

class _JenisKelaminBottomSheetState extends State<JenisKelaminBottomSheet> {
  late final JenisKelaminBloc bloc;

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
          title: 'Pilih Jenis Kelamin',
        ),
        Flexible(
          child: Scrollbar(
            thumbVisibility: true,
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverList.list(
                  children: [
                    CustomListTile(
                      title: 'Laki-laki',
                      useDefaultTrail: false,
                      onTap: () => Navigator.pop(
                        context,
                        'Laki-laki',
                      ),
                    ),
                    CustomListTile(
                      title: 'Perempuan',
                      useDefaultTrail: false,
                      onTap: () => Navigator.pop(
                        context,
                        'Perempuan',
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
