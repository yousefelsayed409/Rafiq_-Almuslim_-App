import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart';
import 'package:quranapp/core/utils/app_color.dart';
import 'package:quranapp/core/widgets/widgets.dart';
import 'package:quranapp/featuers/home/presentation/manger/quran_cubit/app_cubit.dart';
import 'package:quranapp/featuers/home/presentation/view/surrah_view.dart';

class QuranKaremView extends StatelessWidget {
  const QuranKaremView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    if (surahNameFromSharedPref != null) {
      Future.delayed(
        const Duration(milliseconds: 150),
        () => AwesomeDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          context: context,
          dialogType: DialogType.noHeader,
          animType: AnimType.scale,
          title: 'هل تود الانتقال الي العلامة؟',
          btnOkOnPress: () {
            navigateTo(
              context,
              SurahScreen(
                surahNumber: surahNumFromSharedPref,
              ),
            );
          },
          btnOkText: 'نعم',
          customHeader: Icon(
            Icons.bookmark,
            color: defaultColor,
            size: 50,
          ),
          btnOkColor: defaultColor,
          btnCancelOnPress: () {},
          btnCancelText: 'لا',
          btnCancelColor: Colors.red,
        ).show(),
      );
    }

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                // expandedHeight: 20.0,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    "رَفِيقِي",
                    style:  GoogleFonts.poppins(
                color: const Color(0xff18392B), fontWeight: FontWeight.bold),
                  ),
                  centerTitle: true,
                  
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    
                    decoration: BoxDecoration(
                      color:const Color(0xff18392B) ,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: IconButton(
                      icon:  const Icon(Icons.arrow_back,color: Colors.white,),
                      onPressed: () {
                        if (cubit.isPlaying) {
                          cubit.togglePlay();
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ), 
                actions: [

                  Padding(
                    padding:  const EdgeInsets.only(right:  8),
                    child: SvgPicture.asset('assets/image/Vector33.svg',color: const Color(0xff18392B),),
                  )
                ],
              ),
              SliverList(
  delegate: SliverChildBuilderDelegate(
    (context, index) {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              cubit.quranSoundActive = true;
              if (cubit.surahName != getSurahNameArabic(index + 1)) {
                FileInfo? cacheIsEmpty =
                    await DefaultCacheManager().getFileFromCache(
                        "$quranSoundUrl${index + 1}.mp3");
                if (cacheIsEmpty == null) {
                  cubit.isCached = false;
                  if (internetConnection) {
                    cubit.setUrlQuranSoundSrcOnline(
                        urlSrc: "$quranSoundUrl${index + 1}.mp3");
                  }
                } else {
                  cubit.isCached = true;
                  DefaultCacheManager()
                      .getFileFromCache("$quranSoundUrl${index + 1}.mp3")
                      .then((value) {
                    cubit.setUrlQuranSoundSrcOffline(
                        urlSrc: value!.file.path);
                  });
                }
                cubit.setSurahInfo(
                    index + 1, getSurahNameArabic(index + 1));

                if (cubit.isPlaying) {
                  cubit.togglePlay();
                }
              }

              navigateTo(
                  context, SurahScreen(surahNumber: index + 1));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/image/nomor-surah.svg',
                        color: const Color(0xff588B76),
                      ),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Center(
                          child: Text(
                            ('${index + 1}'),
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    getSurahNameArabic(index + 1) == 'اللهب'
                        ? 'المسد'
                        : getSurahNameArabic(index + 1),
                    style: GoogleFonts.amiri(
                      color: const Color(0xff18392B),
                      fontSize: 28,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      defaultText(text: "اّياتها", fontsize: 18),
                      const SizedBox(height: 2.5),
                      defaultText(
                        text: '${getVerseCount(index + 1)}',
                        fontsize: 18,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      defaultText(
                        text: getPlaceOfRevelation(index + 1) ==
                                "Makkah"
                            ? "مكية"
                            : "مدنية",
                        fontsize: 18,
                      ),
                      const SizedBox(height: 2),
                      getPlaceOfRevelation(index + 1) == "Makkah"
                          ? const Image(
                              image: AssetImage(
                                  'assets/images/kaba.png'),
                              width: 9.5,
                            )
                          : const Image(
                              image: AssetImage(
                                  'assets/images/MasjidElnabwy.png'),
                              width: 9.5,
                            ),
                    ],
                  ),
                  SizedBox(width: 5.w),
                ],
              ),
            ),
          ),
          const Divider(
            endIndent:16.0 ,
            indent: 16.0,
            color: Colors.grey,
            thickness: 1, 
            height: 10, 
          ),
        ],
      );
    },
    childCount: 114,
  ),
),

            ],
          ),
        );
      },
    );
  }
}
