import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../injection_container.dart';
import '../../domain/entites/product.dart';
import '../bloc/bloc/product_bloc.dart';
import '../widget/card_class.dart';
import 'update_product_page.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  const ProductDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductBloc>(
      create: (_) => sl<ProductBloc>()..add(GetSingleProductEvent(productId)),
      child: _ProductDetailView(productId: productId),
    );
  }
}

class _ProductDetailView extends StatefulWidget {
  final String productId;
  const _ProductDetailView({required this.productId});

  @override
  State<_ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<_ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }

            if (state is DeleteSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product deleted successfully')),
              );
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/productList',
                (route) => false,
              );
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ErrorState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<ProductBloc>().add(
                        GetSingleProductEvent(widget.productId),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            if (state is LoadedSingleProductState) {
              final Product p = state.product;
              return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 266,
                              width: double.infinity,
                              child: Image.network(
                                p.imageUrl,
                                fit: BoxFit.cover,
                                height: 266,
                              ),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              margin: const EdgeInsets.all(24),
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.chevron_left),
                                color: const Color.fromRGBO(63, 81, 243, 1),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(28, 22, 0, 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Product',
                                    style: GoogleFonts.poppins(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: const Color.fromRGBO(
                                        170,
                                        170,
                                        170,
                                        1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 32),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Color.fromRGBO(255, 215, 0, 1),
                                        ),
                                        Text(
                                          '(4.0)',
                                          style: GoogleFonts.sora(
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16,
                                            color: const Color.fromRGBO(
                                              170,
                                              170,
                                              170,
                                              1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      p.name,
                                      style: GoogleFonts.poppins(
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 24,
                                        color: const Color.fromRGBO(
                                          2,
                                          62,
                                          62,
                                          1,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '\$${p.price}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        color: const Color.fromRGBO(
                                          62,
                                          62,
                                          62,
                                          1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 5),
                              SizedBox(
                                height: 60,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: const [
                                    CardClass(size: 39),
                                    CardClass(size: 40),
                                    CardClass(
                                      size: 41,
                                      color: Color.fromRGBO(68, 81, 243, 1),
                                    ),
                                    CardClass(size: 42),
                                    CardClass(size: 43),
                                    CardClass(size: 44),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                  right: 32,
                                ),
                                child: Text(
                                  p.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color.fromRGBO(
                                      102,
                                      102,
                                      102,
                                      1,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 40),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {
                                        // Show a confirmation dialog before deleting
                                        showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                            title: const Text('Delete Product'),
                                            content: const Text(
                                              'Are you sure you want to delete this product?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(
                                                  ctx,
                                                ).pop(), // cancel
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(
                                                    ctx,
                                                  ).pop(); // close dialog
                                                  // Trigger delete event
                                                  context
                                                      .read<ProductBloc>()
                                                      .add(
                                                        DeleteProductEvent(
                                                          widget.productId,
                                                        ),
                                                      );
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Colors.red,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 40,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'DELETE',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromRGBO(
                                            255,
                                            19,
                                            19,
                                            0.79,
                                          ),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => UpdateProductPage(
                                              productId: widget.productId,
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                          63,
                                          81,
                                          243,
                                          1,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 40,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'UPDATE',
                                        style: GoogleFonts.poppins(
                                          color: const Color.fromRGBO(
                                            255,
                                            255,
                                            255,
                                            0.79,
                                          ),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(
              child: Text('Pull to refresh', style: GoogleFonts.poppins()),
            );
          },
        ),
      ),
    );
  }
}
