import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';
import 'package:payuung_pribadi_clone/components/custom_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_loading.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/address_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/address/address_view.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/biodata_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/biodata/biodata_view.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/company_bloc.dart';
import 'package:payuung_pribadi_clone/features/personal_information/company/company_view.dart';
import 'package:payuung_pribadi_clone/features/profile/profile_view.dart';
import 'package:payuung_pribadi_clone/utils/unfocus_node.dart';
import 'package:timelines_plus/timelines_plus.dart';

class PersonalInformationView extends StatefulWidget {
  const PersonalInformationView({super.key});

  static const String routeName =
      '${ProfileView.routeName}/personal-information';

  @override
  State<PersonalInformationView> createState() =>
      _PersonalInformationViewState();
}

class _PersonalInformationViewState extends State<PersonalInformationView>
    with TickerProviderStateMixin {
  final BiodataBloc biodataBloc = BiodataBloc();
  final AddressBloc addressBloc = AddressBloc();
  final CompanyBloc companyBloc = CompanyBloc();

  final List<String> stepperLabel = [
    'Biodata Diri',
    'Alamat Pribadi',
    'Informasi Perusahaan',
  ];

  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 3,
      vsync: this,
      animationDuration: Duration.zero,
    );
  }

  @override
  void dispose() {
    biodataBloc.close();
    addressBloc.close();
    companyBloc.close();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => unfocusNode(context),
      child: Stack(
        children: [
          Scaffold(
            appBar: CustomAppBar(
              title: CustomText.title('Informasi Pribadi'),
            ),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Stepper(
                  tabController: tabController,
                  labels: stepperLabel,
                ),
                Flexible(
                  child: TabBarView(
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      BlocProvider.value(
                        value: biodataBloc,
                        child: BiodataView(
                          onSuccess: () => tabController.index = 1,
                        ),
                      ),
                      BlocProvider.value(
                        value: addressBloc,
                        child: AddressView(
                          onBack: () => tabController.index = 0,
                          onSuccess: () => tabController.index = 2,
                        ),
                      ),
                      BlocProvider.value(
                        value: companyBloc,
                        child: CompanyView(
                          onBack: () => tabController.index = 1,
                          onSuccess: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          /// Loading
          Positioned.fill(
            child: BlocBuilder(
              bloc: biodataBloc,
              builder: (_, bioState) => BlocBuilder(
                bloc: addressBloc,
                builder: (_, addresstate) => BlocBuilder(
                  bloc: companyBloc,
                  builder: (_, comState) {
                    bool isLoading = bioState is AppStateLoading ||
                        addresstate is AppStateLoading ||
                        comState is AppStateLoading;
                    if (isLoading) {
                      return Container(
                        color: AppColors.black10,
                        width: kDeviceLogicalWidth,
                        height: kDeviceLogicalHeight,
                        child: Center(
                          child: CustomLoading.withBackground(),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.tabController,
    required this.labels,
  });

  final TabController tabController;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    const double barHeight = 2;
    return ListenableBuilder(
      listenable: tabController,
      builder: (_, __) {
        return Column(
          children: [
            Container(
              width: kDeviceLogicalWidth,
              margin: const EdgeInsets.only(bottom: 15, top: 10),
              child: FixedTimeline(
                direction: Axis.horizontal,
                mainAxisSize: MainAxisSize.max,
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (int i = 0; i < labels.length; i++) ...[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (i != 0)
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: barHeight,
                                    color: tabController.index >= i
                                        ? AppColors.primary
                                        : AppColors.primary15,
                                  ),
                                )
                              else
                                const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  tabController.index = i;
                                },
                                child: DotIndicator(
                                  size: 40,
                                  color: tabController.index >= i
                                      ? AppColors.primary
                                      : AppColors.primary15,
                                  child: Center(
                                    child: CustomText.title(
                                      '${i + 1}',
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                              if (i != tabController.length - 1)
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: barHeight,
                                    color: tabController.index > i
                                        ? AppColors.primary
                                        : AppColors.primary15,
                                  ),
                                )
                              else
                                const Spacer(),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (i != 0)
                                Expanded(
                                  flex: i == tabController.length - 1 ? 2 : 1,
                                  child: const SizedBox(),
                                ),
                              Expanded(
                                flex: 3,
                                child: CustomText.body(
                                  labels[i],
                                  textAlign: TextAlign.center,
                                  color: AppColors.primary,
                                ),
                              ),
                              if (i != tabController.length - 1)
                                Expanded(
                                  flex: i == 0 ? 2 : 1,
                                  child: const SizedBox(),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
