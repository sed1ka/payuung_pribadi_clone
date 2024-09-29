import 'package:flutter/material.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/device_measurement.dart';
import 'package:payuung_pribadi_clone/commons/local_image.dart';
import 'package:payuung_pribadi_clone/commons/themes.dart';
import 'package:payuung_pribadi_clone/components/icon_label_button.dart';
import 'package:payuung_pribadi_clone/components/painter/dome_container_painter.dart';
import 'package:payuung_pribadi_clone/components/slide_panel.dart';
import 'package:payuung_pribadi_clone/features/home/home_view.dart';
import 'package:payuung_pribadi_clone/features/search/search_view.dart';
import 'package:payuung_pribadi_clone/utils/exit_app_handler.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  final PanelController panelController = PanelController();
  final List<Widget> pages = [
    const HomeView(),
    const SearchView(),
  ];

  late final TabController tabController;
  late final ValueNotifier<bool> isPanelOpenNotifier;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: pages.length, vsync: this);
    isPanelOpenNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    tabController.dispose();
    isPanelOpenNotifier.dispose();
    super.dispose();
  }

  Future<void> onWillPop() async {
    await ExitAppHandler.exit();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await onWillPop();
      },
      child: SlidePanel(
        controller: panelController,
        backdropEnabled: true,
        minHeight: 105,
        maxHeight: kDeviceLogicalHeight * 0.4,
        renderPanelSheet: false,
        onPanelOpened: () => isPanelOpenNotifier.value = true,
        onPanelClosed: () => isPanelOpenNotifier.value = false,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panel: _MenuPanel(
          panelController: panelController,
          tabController: tabController,
          isPanelOpenNotifier: isPanelOpenNotifier,
        ),
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
    );
  }
}

class _MenuPanel extends StatelessWidget {
  const _MenuPanel({
    required this.tabController,
    required this.panelController,
    required this.isPanelOpenNotifier,
  });

  final TabController tabController;
  final PanelController panelController;
  final ValueNotifier<bool> isPanelOpenNotifier;

  @override
  Widget build(BuildContext context) {
    const double domeWidth = 50;

    return CustomPaint(
      painter: DomeContainerPainter(domeWidth: domeWidth, shadow: kBoxShadow()),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                if (panelController.isPanelOpen) {
                  panelController.close();
                } else {
                  panelController.open();
                }
              },
              child: SizedBox(
                width: domeWidth,
                height: domeWidth * 0.85,
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: isPanelOpenNotifier,
                    builder: (_, val, __) => AnimatedRotation(
                      turns: val ? 0 : 0.5,
                      duration: const Duration(milliseconds: 100),
                      child: const Icon(
                        Icons.expand_more,
                        color: AppColors.blueGrey,
                        size: largeIconSize * 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 35),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.profile,
                            label: 'Beranda',
                            onTap: () {
                              tabController.index = 0;
                            },
                          ),
                        ),
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.search,
                            label: 'Cari',
                            onTap: () {
                              tabController.index = 1;
                            },
                          ),
                        ),
                        const Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.cart,
                            label: 'Keranjang',
                            onTap: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 45),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.transaction,
                            label: 'Daftar Transaksi',
                            onTap: null,
                          ),
                        ),
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.myVoucher,
                            label: 'Voucher Saya',
                            onTap: null,
                          ),
                        ),
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.address,
                            label: 'Alamat Pengiriman',
                            onTap: null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 45),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IconLabelButton(
                            iconAsset: LocalImage.friend,
                            label: 'Daftar Teman',
                            onTap: null,
                          ),
                        ),
                        Spacer(),
                        Spacer(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
