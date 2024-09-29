import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payuung_pribadi_clone/commons/colors.dart';
import 'package:payuung_pribadi_clone/commons/constants.dart';
import 'package:payuung_pribadi_clone/commons/local_image.dart';
import 'package:payuung_pribadi_clone/components/custom_appbar.dart';
import 'package:payuung_pribadi_clone/components/custom_list_tile.dart';
import 'package:payuung_pribadi_clone/components/custom_text.dart';
import 'package:payuung_pribadi_clone/features/personal_information/personal_information_view.dart';
import 'package:payuung_pribadi_clone/utils/page_navigator.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const String routeName = 'profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGrey,
      appBar: CustomAppBar(
        title: CustomText.title('Profil'),
        backgroundColor: AppColors.lightGrey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 35),
        child: Column(
          children: [
            const _ProfileAvatar(),
            const SizedBox(height: 25),
            CustomListTile(
              color: AppColors.white,
              border: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: 'Informasi Pribadi',
              titleFontSize: titleSmallTextSize,
              titleBold: false,
              useDefaultTrail: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              leading: Container(
                height: largeIconSize * 1.6,
                width: largeIconSize * 1.6,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(LocalImage.profile),
              ),
              onTap: () => goToPage(
                nextPage: const PersonalInformationView(),
                routeName: PersonalInformationView.routeName,
                context: context,
              ),
            ),
            const SizedBox(height: 20),
            CustomListTile(
              color: AppColors.white,
              border: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              title: 'Syarat & Ketentuan',
              titleFontSize: titleSmallTextSize,
              titleBold: false,
              useDefaultTrail: false,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              leading: Container(
                height: largeIconSize * 1.6,
                width: largeIconSize * 1.6,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SvgPicture.asset(LocalImage.placeholder),
              ),
              onTap: null,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: AppColors.grey,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText.title('SSA'),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.title(
                'Septian Surya Andika',
                fontSize: headlineSmallTextSize,
              ),
              CustomText.body('Masuk dengan Google'),
            ],
          ),
        ),
      ],
    );
  }
}
