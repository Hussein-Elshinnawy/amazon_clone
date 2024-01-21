import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../common/widget/custom_textfield.dart';
import '../../../constants/variables.dart';
import '../../search/screens/search_screen.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totaAmount;
  const AddressScreen({super.key, required this.totaAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuilidngController = TextEditingController();
  final TextEditingController areaBuilidngController = TextEditingController();
  final TextEditingController pinBuilidngController = TextEditingController();
  final TextEditingController cityBuilidngController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressToBeUsed="";
  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuilidngController.dispose();
    areaBuilidngController.dispose();
    pinBuilidngController.dispose();
    cityBuilidngController.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    paymentItems.add(PaymentItem(amount: widget.totaAmount, label: 'total amout', status: PaymentItemStatus.final_price,));
  }

  void onApplePayResult(result) {
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totaAmount.toString()));
  }
  void googlePayResult(result) {
    if(Provider.of<UserProvider>(context, listen: false).user.address.isEmpty){
      addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(context: context, address: addressToBeUsed, totalSum: double.parse(widget.totaAmount.toString()));
  }
  void payPressed(String addressFromProvider){
    addressToBeUsed="";

    bool isForm = flatBuilidngController.text.isNotEmpty || areaBuilidngController.text.isNotEmpty || cityBuilidngController.text.isNotEmpty || pinBuilidngController.text.isNotEmpty;
    if(isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
        '${flatBuilidngController.text}, ${areaBuilidngController
            .text}, ${cityBuilidngController.text}, ${pinBuilidngController
            .text}';
      } else {
        throw Exception('please enter all the fields');
      }
    }else if(addressFromProvider.isNotEmpty) {
      addressToBeUsed=addressFromProvider;
    }else{
      showSnackBar(context, 'error in address');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), //default height
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: Variables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Or',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuilidngController,
                      hintText: 'Flat, House no, Building',
                    ),
                    CustomTextField(
                      controller: areaBuilidngController,
                      hintText: 'Area, Street',
                    ),
                    CustomTextField(
                      controller: pinBuilidngController,
                      hintText: 'Pincode',
                    ),
                    CustomTextField(
                      controller: cityBuilidngController,
                      hintText: 'Town/City',
                    ),
                  ],
                ),
              ),
              ApplePayButton(
                onPressed:()=> payPressed(address),
                width: double.infinity,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                onPaymentResult: onApplePayResult,
                paymentItems: paymentItems,
                paymentConfigurationAsset: 'applepay.json',
              ),
              SizedBox(height: 10,),
              GooglePayButton(
                onPressed: ()=> payPressed(address),
                width: double.infinity,
                type: GooglePayButtonType.buy,
                onPaymentResult: googlePayResult,
                paymentItems: paymentItems,
                margin: EdgeInsets.only(top: 15),
                loadingIndicator: const Center(child: CircularProgressIndicator(),),
                paymentConfigurationAsset: 'gpay.json',
              )
            ],
          ),
        ),
      ),
    );
  }
}
