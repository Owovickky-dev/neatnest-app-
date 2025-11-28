import 'package:country_state_city/country_state_city.dart';
import 'package:flutter/material.dart' hide State;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/controller/filter_search_controller.dart';
import 'package:neat_nest/screens/home/filter/notifier/filter_state.dart';
import 'package:neat_nest/screens/home/filter/widget/filter_range.dart';
import 'package:neat_nest/screens/home/filter/widget/filter_rating.dart';
import 'package:neat_nest/utilities/app_button.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../utilities/app_data.dart';
import '../../../utilities/constant/colors.dart';
import '../../../widget/app_text.dart';
import '../../history/utilities/app_bar_icon.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  List<String> categories = [
    "Cleaning",
    "Plumbing",
    "Electrical",
    "Carpentry",
    "Painting",
    "Gardening",
    "Moving",
    "Assembly",
    "Repair",
    "Other",
  ];

  late FilterSearchController _filterSearchController;

  List<Country> countries = [];
  List<State> states = [];

  Country? countryPicked;
  State? statesPicked;
  String? isPrimaryPicked;

  @override
  void initState() {
    super.initState();
    _filterSearchController = FilterSearchController();
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    List<Country> countryList = await getAllCountries();
    setState(() {
      countries = countryList;
    });
  }

  Future<void> _loadState(String countryCode) async {
    List<State> stateList = await getStatesOfCountry(countryCode);
    setState(() {
      states = stateList;
    });
  }

  int? ratingIndex;

  String? countrySelected;
  String? stateSelected;
  String? categorySelected;

  @override
  Widget build(BuildContext context) {
    final filterData = ref.read(filterStateProvider.notifier);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: primaryText(text: 'Filter'),
        leading: AppBarIcon(
          icons: Icons.arrow_back,
          function: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.ht,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  secondaryText(
                    text: "Please kindly note Country and state must be picked",
                    color: Colors.red,
                  ),
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
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      isExpanded: true,
                      value: countryPicked,
                      underline: SizedBox(),
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
                            _loadState(value.isoCode);
                          });
                          filterData.setCountry(value.name);
                        }
                      },
                    ),
                  ),
                ],
              ),
              10.ht,
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
                      icon: Icon(Icons.keyboard_arrow_down_outlined),
                      isExpanded: true,
                      value: statesPicked,
                      underline: SizedBox(),
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
                  icon: Icon(Icons.keyboard_arrow_down_outlined),
                  isExpanded: true,
                  value: categorySelected,
                  underline: SizedBox(),
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: secondaryText(text: category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      categorySelected = value;
                    });
                    filterData.setCategory(value.toString());
                  },
                ),
              ),
              20.ht,
              primaryText(text: "Price Range"),
              5.ht,
              FilterRange(ref: ref),
              10.ht,
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
                        List<String> ranges = ratingText.split(" ");
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
                        ratingIndex = -1;
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
                    function: () {
                      _filterSearchController.submit(context, ref);
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
