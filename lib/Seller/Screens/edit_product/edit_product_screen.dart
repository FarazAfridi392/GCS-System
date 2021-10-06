import 'package:e_shop/Seller/Screens/edit_product/provider_models/product_details.dart';
import 'package:e_shop/app_properties.dart';
import 'package:e_shop/models/product.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';

class EditProductScreen extends StatelessWidget {
  final Product productToEdit;

  const EditProductScreen({Key key, this.productToEdit}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (context) => ProductDetails(),
      
      child: Scaffold(
        appBar: AppBar(title: Text("Add Product"),backgroundColor: kYellow,),
        body: Body(
          productToEdit: productToEdit,
        ),
      ),
    );
  }
}
