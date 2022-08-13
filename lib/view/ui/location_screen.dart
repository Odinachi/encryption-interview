import 'package:apex/data/local/mock_country_list.dart';
import 'package:apex/models/country.dart';
import 'package:apex/res/colors.dart';
import 'package:apex/res/constants.dart';
import 'package:apex/view/resuable_widgets/button.dart';
import 'package:apex/view/resuable_widgets/social_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/assets.dart';
import '../../res/strings.dart';
import '../resuable_widgets/click_widget.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  CountryModel? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apexAppBar(onTap: () {
        Navigator.pop(context);
      }),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: screenHeight(1, context),
          width: screenWidth(1, context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(.03, context),
              ),
              Text(
                AppStrings.countryOfRes,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appDarkColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: screenHeight(.01, context),
              ),
              Text(
                AppStrings.selectAllCountry,
                style: AppAssets.appTextStyle.copyWith(
                  color: AppColors.appHintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: screenHeight(.03, context),
              ),
              InkWell(
                onTap: () async {
                  var v = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext ctx) => Container(
                      height: screenHeight(.75, context),
                      padding:
                          const EdgeInsets.only(left: 20.0, right: 20, top: 30),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: const _CountriesModal(),
                    ),
                  );

                  setState(() {
                    _selectedCountry = v;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColors.appFillColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            _selectedCountry?.emoji ?? "",
                            style: AppAssets.appTextStyle.copyWith(
                              color: AppColors.appDarkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              _selectedCountry?.name ?? "Pick A country",
                              style: AppAssets.appTextStyle.copyWith(
                                color: AppColors.appDarkColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              AppButton(
                enabled: _selectedCountry != null,
                text: AppStrings.continueText,
                onPress: () {
                  Navigator.pushNamed(context, AppRouteStrings.pinScreen);
                },
              ),
              SizedBox(
                height: screenHeight(.03, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CountriesModal extends StatefulWidget {
  const _CountriesModal({Key? key}) : super(key: key);

  @override
  State<_CountriesModal> createState() => _CountriesModalState();
}

class _CountriesModalState extends State<_CountriesModal> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchNode = FocusNode();

  List<CountryModel> _countries = [];
  List<CountryModel> _countryList = [];
  CountryModel? _selected;

  @override
  void initState() {
    super.initState();
    _countries = List.from(countries.map((e) => CountryModel.fromJson(e)));
    _countryList.addAll(_countries);
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected(CountryModel c) {
      return c.name?.toLowerCase() == _selected?.name?.toLowerCase();
    }

    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  onChanged: (v) {
                    filterSearchResults(v);
                  },
                  controller: _searchController,
                  focusNode: _searchNode,
                  cursorColor: AppColors.appDarkColor,
                  style: AppAssets.appTextStyle.copyWith(
                    color: AppColors.appDarkColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: .5,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppAssets.searchIcon,
                      ),
                    ),
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    fillColor: AppColors.appFillColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ClickWidget(
                onTap: () {
                  _searchController.clear();
                  _searchNode.unfocus();
                  setState(() {});
                },
                child: Text(
                  AppStrings.cancel,
                  style: AppAssets.appTextStyle.copyWith(
                    color: AppColors.appDarkColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _countryList.length,
              itemBuilder: (context, i) {
                var p = _countryList[i];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected(p)
                        ? AppColors.appFillColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClickWidget(
                    onTap: () {
                      _selected = p;
                      setState(() {});
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pop(context, p);
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "${p.emoji}",
                          style: AppAssets.appTextStyle.copyWith(
                            color: AppColors.appDarkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          p.code ?? '',
                          style: AppAssets.appTextStyle.copyWith(
                            color: AppColors.appDarkColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            p.name ?? '',
                            style: AppAssets.appTextStyle.copyWith(
                              color: AppColors.appDarkColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (isSelected(p))
                          const Icon(
                            Icons.check,
                            color: AppColors.appOrangeColor,
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<CountryModel> dummySearchList = [];
    dummySearchList.addAll(_countries);
    if (query.isNotEmpty) {
      List<CountryModel> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.name!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        _countryList.clear();
        _countryList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _countryList.clear();
        _countryList.addAll(_countries);
      });
    }
  }
}
