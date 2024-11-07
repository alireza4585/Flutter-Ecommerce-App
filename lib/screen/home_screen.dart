import 'package:flutter/material.dart';
import 'package:flutter_shopping_app_with_api/constants/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_bloc.dart';
import 'package:flutter_shopping_app_with_api/data/bloc/home_bloc/home_state.dart';
import 'package:flutter_shopping_app_with_api/data/model/banner.dart';
import 'package:flutter_shopping_app_with_api/data/repository/banner_repository.dart';
import 'package:flutter_shopping_app_with_api/gitit/gitit.dart';
import 'package:flutter_shopping_app_with_api/util/cach_image.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _control_page = PageController();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeRequestSuccessState) {
              return CustomScrollView(
                slivers: [
                  Appbar(),
                  Search_widget(),
                  state.bannerList.fold(
                    (left) {
                      return SliverToBoxAdapter(
                        child: Text(left),
                      );
                    },
                    (right) {
                      return Banner(right);
                    },
                  ),
                  bestselling(),
                  bestselling_widget(),
                ],
              );
            }
            return Center(child: Text('d'));
          },
        ),
      ),
    );
  }

  Widget bestselling_widget() {
    return SliverPadding(
      padding: EdgeInsets.only(right: 15.w, left: 15.w, bottom: 20.h),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(3, 1),
                    blurRadius: 10.r,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 110.h),
                    child: SizedBox(
                      height: 150.h,
                      width: 200.w,
                      child: Image.asset('images/image.png'),
                    ),
                  ),
                  Positioned(
                    top: 160.h,
                    left: 20.w,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 200.h,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(11.r),
                            ),
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: 25.w,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 4,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 270,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
      ),
    );
  }

  SliverToBoxAdapter bestselling() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Text(
          'Bestselling',
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter Banner(List<Banner_model> banner) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            child: PageView(
              controller: _control_page,
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(banner.length, (index) {
                  return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          child: CacheImage(
                            imageUrl: banner[index].thumbnail,
                            banner: true,
                            radius: 10,
                          )));
                })
              ],
            ),
          ),
          SmoothPageIndicator(
            controller: _control_page,
            count: 3,
            effect: WormEffect(
              dotHeight: 11.h,
              dotWidth: 11.w,
              activeDotColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter Search_widget() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 15.w),
                    Icon(Icons.search, size: 25.w),
                    SizedBox(width: 15.w),
                    Text(
                      'Search your shoes',
                      style: TextStyle(color: Colors.grey.shade500),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 2,
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.white,
                ),
                child: Icon(Icons.filter_alt, size: 25.w),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter Appbar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset('images/nikee.png'),
              ),
            ),
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset('images/person.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
