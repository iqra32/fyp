import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharmacystore/model/disease_medicine_model.dart';
import 'package:pharmacystore/model/search_filter_model.dart';
import 'package:pharmacystore/utils/app_colors.dart';
import 'package:pharmacystore/utils/data.dart';
import 'package:pharmacystore/widgets/disease_card.dart';
import 'package:pharmacystore/widgets/medicine_card.dart';
import 'package:pharmacystore/widgets/search_filter_item_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  SearchFilterModel selectedFilter = Data().searchFilters[0];
  List<DiseaseAndMedicines> searchedListing = [];
  bool _isSearchApplied = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 280.0,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/search_header.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            "Explore and get effective\nresults immediately",
                            style: TextStyle(
                              color: AppColors.appBlackColor,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Backed with highly skilled doctors and pharmacists, we aim to provide you quick and reliable medicines to cure.",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 35.0),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.appWhiteColor,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            blurRadius: 8.0,
                            spreadRadius: 8.0,
                            offset: const Offset(1, 0),
                          ),
                        ],
                        border: Border.all(
                          width: 0.25,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.text,
                        autocorrect: false,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          isDense: true,
                          labelText: "Search for diseases | medicines",
                          labelStyle: const TextStyle(
                            fontSize: 15.0,
                            color: AppColors.appBlackColor,
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 30.0,
                                child: VerticalDivider(
                                  thickness: 1,
                                  color: AppColors.appGreyColor,
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              InkWell(
                                onTap: () => _searchListing(),
                                child: Icon(
                                  Icons.search,
                                  size: 22.0,
                                  color: Colors.grey.withOpacity(0.90),
                                ),
                              ),
                              _isSearchApplied
                                  ? const SizedBox(width: 5.0)
                                  : const SizedBox.shrink(),
                              _isSearchApplied
                                  ? InkWell(
                                      onTap: () => _clearSearchListing(),
                                      child: Icon(
                                        Icons.close,
                                        size: 22.0,
                                        color: Colors.grey.withOpacity(0.90),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        style: const TextStyle(
                          color: AppColors.appBlackColor,
                          fontSize: 18.0,
                          // fontFamily: "DINNextLTPro_Medium",
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 10.0,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.0,
                    child: ListView.builder(
                      itemCount: Data().searchFilters.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        SearchFilterModel _searchFilterItem =
                            Data().searchFilters[index];
                        return SearchFilterItemCard(
                          onPressed: () => _toggleFilter(_searchFilterItem),
                          isSelected:
                              selectedFilter.key == _searchFilterItem.key,
                          isFirstItem: index == 0,
                          searchFilter: _searchFilterItem,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: getItemLength(),
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      DiseaseAndMedicines _diseaseAndMedicine =
                          getSelectedFilterList()[index];
                      return _diseaseAndMedicine.isDisease
                          ? DiseaseCard(
                              title: _diseaseAndMedicine.title,
                              description: _diseaseAndMedicine.description,
                            )
                          : _diseaseAndMedicine.isMedicine
                              ? MedicineCard(
                                  title: _diseaseAndMedicine.title,
                                  description: _diseaseAndMedicine.description,
                                  image: _diseaseAndMedicine.imageurl!,
                                )
                              : const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DiseaseAndMedicines> getSelectedFilterList({
    int? selectedListingType,
  }) {
    selectedListingType ??= getSelectedFilterType();

    List<DiseaseAndMedicines> dataList =
        _isSearchApplied ? searchedListing : [];
    List<DiseaseAndMedicines> listing = [];
    if (selectedListingType == Data().allListing) {
      listing = dataList;
    } else if (selectedListingType == Data().isMedicine) {
      listing =
          dataList.where((element) => element.isMedicine == true).toList();
    } else if (selectedListingType == Data().isDisease) {
      listing = dataList.where((element) => element.isDisease == true).toList();
    }
    return listing;
  }

  int getSelectedFilterType() {
    int type = Data().allListing;
    if (selectedFilter.key == Data.ALL) {
      type = Data().allListing;
    } else if (selectedFilter.key == Data.MEDICINES) {
      type = Data().isMedicine;
    } else if (selectedFilter.key == Data.DISEASES) {
      type = Data().isDisease;
    } else if (selectedFilter.key == Data.DOCTORS) {
      type = Data().isDoctor;
    }
    return type;
  }

  int getItemLength() {
    List<DiseaseAndMedicines> list =
        _searchController.text.isEmpty ? [] : searchedListing;
    int _length = list.length;

    if (selectedFilter.key != Data.ALL) {
      _length = 0;
      bool isMedicine = selectedFilter.key == Data.MEDICINES,
          isDisease = selectedFilter.key == Data.DISEASES;
      for (DiseaseAndMedicines value in list) {
        if (value.isMedicine && isMedicine) {
          _length++;
        } else if (value.isDisease && isDisease) {
          _length++;
        }
      }
    }
    return _length;
  }

  void _toggleFilter(SearchFilterModel searchFilterItem) {
    selectedFilter = searchFilterItem;
    setState(() {});
  }

  void _searchListing() {
    String searchText = _searchController.text.trim();

    // remove previous search results if present any
    searchedListing.clear();

    print("searching");
    FirebaseFirestore.instance
        .collection("medicines")
        .where('description', isGreaterThanOrEqualTo: searchText)
        .where('description', isLessThan: '${searchText}z')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        searchedListing.add(element.data() as DiseaseAndMedicines);
      });
    });

    print(searchedListing.length);

    // for (var value in Data().listing) {
    //   if (value.tags.contains(searchText)) {
    //     searchedListing.add(value);
    //   }
    // }
    _isSearchApplied = true;
    setState(() {});
  }

  void _clearSearchListing() {
    _isSearchApplied = false;
    _searchController.clear();
    searchedListing.clear();
    setState(() {});
  }
}
