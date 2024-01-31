import 'package:ecommerce_app/common/buttons/custom_rounded_button.dart';
import 'package:ecommerce_app/common/custom_theme.dart';
import 'package:ecommerce_app/common/textfield/custom_textfield.dart';
import 'package:ecommerce_app/features/checkout/ui/widgets/order_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutWidgets extends StatefulWidget {
  const CheckoutWidgets({super.key});

  @override
  State<CheckoutWidgets> createState() => _CheckoutWidgetsState();
}

class _CheckoutWidgetsState extends State<CheckoutWidgets> {
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.primaryColor,
        title: Text(
          "Checkout",
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  fieldName: "",
                  label: "Full Name",
                  hintText: "Full Name",
                ),
                CustomTextField(
                  fieldName: "",
                  label: "Phone Number",
                  hintText: "Phone Number",
                ),
                CustomTextField(
                  fieldName: "",
                  label: "City",
                  hintText: "City",
                ),
                CustomTextField(
                  fieldName: "",
                  label: "Address",
                  hintText: "Address",
                ),
                CustomRoundedButtom(
                  title: "Confirm Order",
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return OrderConfirmDialog();
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
