import 'package:booknest_app/view/all_hotels_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController checkInController = TextEditingController();
  final TextEditingController checkOutController = TextEditingController();
  String? selectedGuests;
  bool isSearchResultVisible = false;

  bool validateInputs() {
    if (locationController.text.isEmpty ||
        checkInController.text.isEmpty ||
        checkOutController.text.isEmpty ||
        selectedGuests == null) {
      return false;
    }

    DateTime now = DateTime.now();
    DateTime checkInDate =
        DateFormat('dd/MM/yyyy').parse(checkInController.text);
    DateTime checkOutDate =
        DateFormat('dd/MM/yyyy').parse(checkOutController.text);

    if (checkInDate.isBefore(now) || checkOutDate.isBefore(checkInDate)) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              isSearchResultVisible
                  ? buildSearchResultCard()
                  : buildInputForm(),
              const SizedBox(height: 16),
              _buildSearchButtons(),
              const SizedBox(height: 24),
              _buildSectionHeader("Top Hotels", () {}),
              const SizedBox(height: 10),
              _buildHorizontalListView(),
              const SizedBox(height: 24),
              _buildSectionHeader("Featured Hotels", () {}),
              const SizedBox(height: 10),
              _buildVerticalListView(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Trang Chủ"),
      backgroundColor: const Color(0xFF60A5FA),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildSearchButtons() {
    return Row(
      children: [
        if (isSearchResultVisible == false)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (validateInputs()) {
                  setState(() {
                    isSearchResultVisible = true;
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          "Vui lòng nhập đầy đủ thông tin và kiểm tra ngày hợp lệ!"),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF60A5FA),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Tìm kiếm",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        const SizedBox(width: 8),
        if (isSearchResultVisible == false)
          GestureDetector(
            onTap: () {
              // setState(() {
              //   isSearchResultVisible = false;
              // });
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF60A5FA),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(Icons.location_on, color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget buildInputForm() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          _buildTextField(
            controller: locationController,
            icon: Icons.location_on,
            hintText: "Địa điểm",
          ),
          Divider(color: Colors.grey.shade300),
          _buildDateField(
            controller: checkInController,
            hintText: "Ngày nhận phòng",
          ),
          Divider(color: Colors.grey.shade300),
          _buildDateField(
            controller: checkOutController,
            hintText: "Ngày trả phòng",
          ),
          Divider(color: Colors.grey.shade300),
          _buildDropdownField(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon, color: const Color(0xFF60A5FA)),
        hintText: hintText,
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        icon: const Icon(Icons.date_range, color: Color(0xFF60A5FA)),
        hintText: hintText,
        border: InputBorder.none,
      ),
      onTap: () async {
        DateTime? date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (date != null) {
          controller.text = DateFormat('dd/MM/yyyy').format(date);
        }
      },
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        icon: Icon(Icons.people, color: Color(0xFF60A5FA)),
        border: InputBorder.none,
      ),
      hint: const Text("Khách"),
      value: selectedGuests,
      items: ["1 người", "2 người", "3 người", "4 người"]
          .map((guest) => DropdownMenuItem(
                value: guest,
                child: Text(guest),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedGuests = value;
        });
      },
    );
  }

  Widget buildSearchResultCard() {
    return SizedBox(
      width: 400.0,
      child: Card(
        color: const Color(0xFF69C1FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recent Searches",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.share_location_rounded,
                    size: 65,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      locationController.text,
                      style: const TextStyle(color: Colors.white),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            "${checkInController.text} - ${checkOutController.text}",
                            style: const TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.group,
                          size: 20,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "$selectedGuests",
                          style: const TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSearchResultVisible = false;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to AllHotelsPage on tap
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AllHotelsPage()),
            );
          },
          child: const Text(
            'View All',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalListView() {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 250,
            margin: const EdgeInsets.only(right: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                          "https://images.pexels.com/photos/29643684/exels-photo-29643684/free-photo-of-elegant-hotel-imperial-architecture-in-mexico.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                          width: double.infinity,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                                'assets/images/placeholder_image.png',
                                height: 120,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tên khách sạn ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$100/đêm',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            SizedBox(width: 4),
                            Text('4.5'),
                          ],
                        ),
                      ],
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

  Widget _buildVerticalListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      'https://images.pexels.com/photos/12770803/exels-photo-12770803.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/images/placeholder_image.png',
                            height: 120,
                            width: 100,
                          )),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tên Khách Sạn ${index + 1}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            '\$100/đêm',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text('4.5'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        '143 Đường Số 265, Hiệp Phú, Quận 9, Hồ Chí Minh, Việt Nam',
                        style: TextStyle(color: Colors.black),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
