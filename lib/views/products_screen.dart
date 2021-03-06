import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_routes.dart';

import '../widgets/app_drawer.dart';
import '../widgets/product_item.dart';

import '../providers/products.dart';

class ProductScreen extends StatelessWidget {

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<Products>(context, listen: false).loadProducts();
  }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_FORM,
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(products[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
