import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductDetailView extends StatefulWidget {
  final Product product;

  const ProductDetailView({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  String selectedColor = 'Beige';
  String selectedSize = 'XL';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          StatefulBuilder(
            builder: (context, setState) {
              bool isFavorite = false;
              return IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  // Add to favorites logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('One product added to favorites')),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.product.imageUrl,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.white : Colors.grey,
                  shape: BoxShape.circle,
                ),
              )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.checkroom, color: Colors.white),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Image.asset('assets/Group 59.png'),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '₹${widget.product.price}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.white, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text('COLOR:', style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: selectedColor,
                      dropdownColor: Colors.black,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: <String>['Black', 'Blue', 'White', 'Beige', 'Brown', 'Grey', 'Creme']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedColor = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Colors.white,
                  thickness: 1,
                  width: 20,
                ),
                Row(
                  children: [
                    const Text('SIZE:', style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: selectedSize,
                      dropdownColor: Colors.black,
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: <String>['XS', 'S', 'M', 'L', 'XL', 'XXL']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSize = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: Colors.white, thickness: 1),
            const SizedBox(height: 20),
            Text(
              'Flowy midi skirt with asymmetric silhouette without slit',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add to cart logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('One product added to cart')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Add to Cart', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 