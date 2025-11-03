import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neat_nest/utilities/constant/extension.dart';

import '../../../../../widget/app_text.dart';

class VerificationStartScreen extends StatelessWidget {
  const VerificationStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        5.ht,
        SizedBox(
          height: 300.h,
          width: 300.w,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl:
                "https://thumbs.dreamstime.com/b/identity-verification-security-blue-tones-user-profile-protection-checkmark-person-s-profile-verified-secure-380184097.jpg",
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator.adaptive()),
            errorWidget: (context, url, error) =>
                Icon(Icons.person, color: Colors.grey, size: 30),
          ),
        ),
        20.ht,
        primaryText(text: "Verify Your Identity"),
        10.ht,
        secondaryText(
          text:
              "As a part of the KYC (Know your customer) process, we request all our customers to verify their identity. "
              "This helps us ensure the safety and authenticity of all professionals workers on our platform. "
              "Please provide a valid government-issued ID, Utility Bills and a clear profile photo to complete verification.",
          textAlign: TextAlign.justify,
        ),
        100.ht,
      ],
    );
  }
}
