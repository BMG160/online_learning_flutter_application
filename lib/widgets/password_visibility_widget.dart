import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bloc/staff_registration_page_bloc.dart';

class PasswordVisibilityWidget extends StatelessWidget {
  final bool visibility;
  const PasswordVisibilityWidget({super.key, required this.visibility});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: (){
          context.read<StaffRegistrationPageBloc>().changePasswordVisibility();
        },
        icon: Icon(visibility ? Icons.visibility : Icons.visibility_off)
    );
  }
}
