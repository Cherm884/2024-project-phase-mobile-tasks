import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc/product_bloc.dart';
import '../widget/form_style.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  File? _pickedImageFile;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        _pickedImageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductBloc>(),
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product added successfully')),
            );

            Future.microtask(() {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/productList',
                (route) => false,
              );
            });
          } else if (state is ErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is LoadingState) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'Add Product',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(62, 62, 62, 1),
                ),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color.fromRGBO(63, 81, 243, 1),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Upload Image
                    GestureDetector(
                      onTap: _pickImage,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          height: 190,
                          width: double.infinity,
                          color: const Color.fromRGBO(243, 243, 243, 1),
                          child: _pickedImageFile == null
                              ? Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.image, size: 50),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Upload Image',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
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
                                )
                              : Image.file(
                                  _pickedImageFile!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    TextPart(label: 'Name', control: _nameController),
                    const SizedBox(height: 8),
                    TextPart(
                      label: 'Price',
                      control: _priceController,
                      suffixText: '\$',
                    ),
                    const SizedBox(height: 8),
                    TextPart(
                      label: 'Description',
                      control: _descriptionController,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        final name = _nameController.text.trim();
                        final desc = _descriptionController.text.trim();
                        final priceText = _priceController.text.trim();

                        if (name.isEmpty ||
                            desc.isEmpty ||
                            priceText.isEmpty ||
                            _pickedImageFile == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Please fill all fields and select an image',
                              ),
                            ),
                          );
                          return;
                        }

                        context.read<ProductBloc>().add(
                          CreateProductEvent(
                            name: name,
                            description: desc,
                            price: double.parse(priceText),
                            imagePath: _pickedImageFile!.path,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(63, 81, 243, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'ADD',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        _nameController.clear();
                        _priceController.clear();
                        _descriptionController.clear();
                        setState(() {
                          _pickedImageFile = null;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'DELETE',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color.fromRGBO(255, 19, 19, 0.79),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

