import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partypal/constants/asset_paths.dart';
import 'package:partypal/services/auth_service.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatefulWidget {
  final VoidCallback? onSignedIn;

  const GoogleSignInButton({
    this.onSignedIn,
    super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool signingIn = false;
  @override
  Widget build(BuildContext context) {
    return signingIn
    ? const SizedBox.square(
        dimension: 40,
        child: CircularProgressIndicator(),
      )
    : GestureDetector(
        onTap: () async {
          setState(() { signingIn = true; });
          await Provider.of<AuthService>(context, listen: false).googleSignIn().then((signedIn) async {
            if (signedIn) {
              widget.onSignedIn?.call();
            }
          });
          setState(() { signingIn = false; });
        },
        child: SizedBox(
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline
              ),
              borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox.square(
                    dimension: 18,
                    child: SvgPicture.asset(AssetPaths.googleIcon)
                  ),
                  8.horizontalSpace,
                  Text(
                    'sign in with google',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}