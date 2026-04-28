import 'package:flutter/material.dart';

class PoweredByHalooid extends StatelessWidget {
  final Color? textColor;
  final Color? logoColor;
  final double paddingBottom;

  const PoweredByHalooid({
    super.key,
    this.textColor = Colors.black54,
    this.logoColor = Colors.black,
    this.paddingBottom = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Powered by',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Image.asset(
            'assets/images/halooid-logo.png',
            height: 16,
            color: logoColor,
            colorBlendMode: logoColor != null ? BlendMode.srcIn : null,
          ),
        ],
      ),
    );
  }
}
