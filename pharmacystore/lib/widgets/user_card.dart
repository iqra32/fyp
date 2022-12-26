import 'package:flutter/material.dart';
import 'package:pharmacystore/utils/app_colors.dart';
import 'package:pharmacystore/view/models/user_model.dart';

class UserCard extends StatelessWidget {
  final Users user;
  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.appWhiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.appGreyColor.withOpacity(0.10),
              offset: Offset(1, 1),
              blurRadius: 5.0,
              spreadRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 15.0,
        ),
        margin: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: AppColors.appBlackColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        user.role,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
