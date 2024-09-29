import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/local_image.dart';
import 'package:payuung_pribadi_clone/components/custom_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';
import 'package:payuung_pribadi_clone/components/icon_label_button.dart';
import 'package:payuung_pribadi_clone/features/profile/profile_view.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        useAccentTheme: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText.body(
              'Halo',
              color: AppColors.white,
            ),
            CustomText.title(
              'Septian Surya Andika',
              fontSize: titleLargeTextSize,
              color: AppColors.white,
            ),
          ],
        ),
        actions: [
          SvgPicture.asset(
            LocalImage.notification,
            color: AppColors.white,
            width: largeIconSize,
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () => goToPage(
              nextPage: const ProfileView(),
              routeName: ProfileView.routeName,
              context: context,
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.grey,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: CustomText.title('SSA'),
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: ColoredBox(
        color: AppColors.primary,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: const SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 15,
              bottom: 25,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _FinanceProduct(),
                _SelectedCategory(),
                _ExploreWellness(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FinanceProduct extends StatelessWidget {
  const _FinanceProduct();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText.title(
            'Produk Keuangan',
            fontSize: headlineSmallTextSize,
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.crowdfunding,
                  label: 'Urun',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Pembiayaan Porsi Haji',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Pemeriksaan Keuangan',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Asuransi Mobil',
                  onTap: null,
                ),
              ),
            ],
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Asuransi Properti',
                  onTap: null,
                ),
              ),
              Spacer(),
              Spacer(),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}

class _SelectedCategory extends StatelessWidget {
  const _SelectedCategory();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomText.title(
                  'Kategori Pilihan',
                  fontSize: headlineSmallTextSize,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CustomText.body('Wishlist'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.hobby,
                  label: 'Hobi',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Merchandise',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Gaya Hidup Sehat',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Konseling Rohani',
                  onTap: null,
                ),
              ),
            ],
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Pengembangan Diri',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Perencanaan Keuangan',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Konsultasi Medis',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Lihat Semua',
                  onTap: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExploreWellness extends StatelessWidget {
  const _ExploreWellness();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: CustomText.title(
                  'Explore Wellness',
                  fontSize: headlineSmallTextSize,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CustomText.body('Terpopuler'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Hobi',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Merchandise',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Gaya Hidup Sehat',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Konseling Rohani',
                  onTap: null,
                ),
              ),
            ],
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Pengembangan Diri',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Perencanaan Keuangan',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Konsultasi Medis',
                  onTap: null,
                ),
              ),
              Expanded(
                child: IconLabelButton(
                  iconAsset: LocalImage.question,
                  label: 'Lihat Semua',
                  onTap: null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
