import 'package:flutter/material.dart';

class HotelDescriptionPage extends StatefulWidget {
  const HotelDescriptionPage({super.key});

  @override
  State<HotelDescriptionPage> createState() => _HotelDescriptionPage();
}

class _HotelDescriptionPage extends State<HotelDescriptionPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                Image.network('https://s.net.vn/E9iH',
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/placeholder_image.png',
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )),
              ],
            ),
            // Details Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hotel Name',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Căn chỉnh từ trên cùng
                    children: [
                      Icon(Icons.location_on,
                          color: Color(0xFF60A5FA), size: 40),
                      SizedBox(width: 5),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Căn lề trái
                          children: [
                            Text(
                              'Khu Công nghệ cao XL Hà Nội, Hiệp Phú, Quận 9',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            Text(
                              'Hồ Chí Minh, Việt Nam',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Description with View More
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AnimatedCrossFade(
                      firstChild: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ornare mi ac massa tincidunt, vel congue turpis interdum. Sed a erat in purus tincidunt viverra. Fusce nec bibendum metus. Proin sed erat at ligula viverra sodales eget a nisi. Quisque tristique egestas lorem a dapibus.',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13),
                      ),
                      secondChild: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis ornare mi ac massa tincidunt, vel congue turpis interdum. Sed a erat in purus tincidunt viverra. Fusce nec bibendum metus. Proin sed erat at ligula viverra sodales eget a nisi. Quisque tristique egestas lorem a dapibus.',
                      ),
                      crossFadeState: _isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'View Less' : 'View More',
                      style: const TextStyle(
                        color: Color(0xFF60A5FA),
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.email,
                            color: Color(0xFF60A5FA),
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'email@example.com',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Color(0xFF60A5FA),
                            size: 25,
                          ),
                          SizedBox(width: 8),
                          Text(
                            '+123456789',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                // Phân phối khoảng cách đều
                children: [
                  // Price Section
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '\$100',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  // Ratings Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Ratings',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Reviewer Section with Overlapping Avatars
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Reviewers',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 90,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Stack(
                            alignment: Alignment.center,
                            children: List.generate(
                              4,
                              (index) => Positioned(
                                left: index * 16.0,
                                child: const CircleAvatar(
                                  radius: 15,
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar_male_image.png',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text('Service',style: TextStyle(color: Colors.black, fontSize: 15)),
                  ),
                ),
                const SizedBox(height: 15,),
                // Amenities Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Center(
                    // Đặt Wrap vào Center để các icon căn giữa
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 16,
                      alignment: WrapAlignment.center, // Icon căn giữa
                      children: [
                        amenityIcon(Icons.wifi, 'Wi-Fi'),
                        amenityIcon(Icons.local_cafe, 'Coffee'),
                        amenityIcon(Icons.pets, 'Pets'),
                        amenityIcon(Icons.wine_bar, 'Wine'),
                        amenityIcon(Icons.pool, 'Pool'),
                        amenityIcon(Icons.more_horiz, 'More'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35,),
            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF60A5FA),
                        minimumSize: const Size(double.infinity, 55),
                        // Chiều cao 30
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Book Now',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 55, // Chiều cao cho nút Bookmark
                    width: 55, // Độ rộng vừa phải
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        side: const BorderSide(color: Color(0xFF60A5FA)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: () {},
                      child:
                          const Icon(Icons.bookmark, color: Color(0xFF60A5FA)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amenityIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200, blurRadius: 4, spreadRadius: 1),
            ],
          ),
          child: Icon(icon, color: const Color(0xFF60A5FA)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
