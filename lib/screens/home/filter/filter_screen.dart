import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/filter_search_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/app_skill_controller_state.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/screens/home/filter/widget/filter_range.dart';
import 'package:neat_nest/screens/home/filter/widget/filter_rating.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/extension.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

import '../../../utilities/app_data.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_bar_holder.dart';
import '../../../widget/app_text.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  late FilterSearchController _filterSearchController;

  List<Country> countries = [];
  List<State> states = [];

  Country? countryPicked;
  State? statesPicked;

  int? ratingIndex;

  String? countrySelected;
  String? stateSelected;
  String? categorySelected;

  @override
  void initState() {
    super.initState();

    _filterSearchController = FilterSearchController();

    _loadCountries();
    _loadCategory();
  }

  Future<void> _loadCountries() async {
    final countryList = await getAllCountries();

    if (!mounted) return;

    setState(() {
      countries = countryList;
    });
  }

  Future<void> _loadCategory() async {
    await ref.read(appSkillControllerStateProvider.notifier).getSkills();
  }

  Future<void> _loadState(String countryCode) async {
    final stateList = await getStatesOfCountry(countryCode);

    if (!mounted) return;

    setState(() {
      states = stateList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filterData = ref.read(filterStateProvider.notifier);

    // Categories are stored and maintained by Riverpod.
    final categories = ref.watch(appSkillControllerStateProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarHolder(
        title: 'Filter',
        function: () {
          AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ht,

              // COUNTRY
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.ht,
                  primaryText(text: "Country"),
                  5.ht,
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButton<Country>(
                      hint: secondaryText(text: "select country"),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isExpanded: true,
                      value: countryPicked,
                      underline: const SizedBox(),
                      items: countries.map((country) {
                        return DropdownMenuItem<Country>(
                          value: country,
                          child: secondaryText(text: country.name),
                        );
                      }).toList(),
                      onChanged: (Country? value) {
                        if (value != null) {
                          setState(() {
                            countryPicked = value;
                            statesPicked = null;
                            states = [];
                          });

                          _loadState(value.isoCode);

                          filterData.setCountry(value.name);
                        }
                      },
                    ),
                  ),
                ],
              ),

              10.ht,

              // STATE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  primaryText(text: "State"),
                  5.ht,
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 10.w,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: DropdownButton<State>(
                      hint: secondaryText(text: "select state"),
                      icon: const Icon(Icons.keyboard_arrow_down_outlined),
                      isExpanded: true,
                      value: statesPicked,
                      underline: const SizedBox(),
                      items: states.map((state) {
                        return DropdownMenuItem<State>(
                          value: state,
                          child: secondaryText(text: state.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            statesPicked = value;
                          });

                          filterData.setUserState(value.name);
                        }
                      },
                    ),
                  ),
                ],
              ),

              20.ht,

              // CATEGORY
              primaryText(text: "Category"),
              10.ht,

              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: DropdownButton<String>(
                  hint: secondaryText(text: "Select a category"),
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  value: categorySelected,
                  underline: const SizedBox(),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: secondaryText(text: category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        categorySelected = value;
                      });

                      filterData.setCategory(value);
                    }
                  },
                ),
              ),

              20.ht,

              // PRICE RANGE
              primaryText(text: "Price Range"),
              5.ht,

              FilterRange(ref: ref),

              10.ht,

              // RATINGS
              primaryText(text: "Ratings"),
              10.ht,

              SizedBox(
                height: 50.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final ratingClicked = ratingIndex == index;
                    final ratingText = AppData.ratingTextRange[index];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          ratingIndex = index;
                        });

                        final ranges = ratingText.split(" ");

                        if (ranges.length > 1) {
                          filterData.setMinRating(double.parse(ranges[0]));

                          filterData.setMaxRating(double.parse(ranges[2]));

                          print("min ${ranges[0]} and Max ${ranges[2]}");
                        } else {
                          filterData.setMaxRating(double.parse(ranges[0]));

                          print("the max ranges is ${ranges[0]}");
                        }
                      },
                      child: FilterRating(
                        index: index,
                        ratingClicked: ratingClicked,
                        text: ratingText,
                      ),
                    );
                  },
                ),
              ),

              20.ht,

              // BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppButton(
                    text: "Reset",
                    fontSize: 16.sp,
                    bckColor: AppColors.primaryColor.withValues(alpha: .1),
                    textColor: Colors.black,
                    verticalHeight: 12.h,
                    function: () {
                      setState(() {
                        countryPicked = null;
                        statesPicked = null;
                        categorySelected = null;
                        ratingIndex = null;
                        states = [];
                      });

                      filterData.reset();
                    },
                  ),
                  AppButton(
                    text: "Apply",
                    fontSize: 16.sp,
                    bckColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    verticalHeight: 12.h,
                    function: () async {
                      AppNavigatorHelper.push(context, AppRoute.filterResult);

                      await _filterSearchController.submit(context, ref);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
