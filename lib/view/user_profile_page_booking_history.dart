import 'package:flutter/material.dart';

class BookingHistoryPage extends StatefulWidget {

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử đặt phòng'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          BookingCard(
            hotelName: 'Hanoi Lotus hostel',
            address: '45, Chỗ Nào Đó, Phố Cổ, TP HCM, Việt Nam',
            bookingDate: '08/01/2021',
            checkinDate: '30/01/2021',
            totalAmount: '250,000 đ',
            status: 'Đã thanh toán',
            imageUrl: 'assets/images/start_page_img_1.png',
          ),
          BookingCard(
            hotelName: 'Fortuna Hotel Hanoi',
            address: '60, Hông Biết, Hà Nội, Việt Nam',
            bookingDate: '08/01/2021',
            checkinDate: '08/01/2021',
            totalAmount: '2,542,000 đ',
            status: 'Hết hạn thanh toán',
            imageUrl: 'assets/images/start_page_img_3.png',
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final String hotelName;
  final String address;
  final String bookingDate;
  final String checkinDate;
  final String totalAmount;
  final String status;
  final String imageUrl;

  const BookingCard({super.key,
    required this.hotelName,
    required this.address,
    required this.bookingDate,
    required this.checkinDate,
    required this.totalAmount,
    required this.status,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(imageUrl,
                      height: 100, width: 100, fit: BoxFit.cover),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hotelName,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(address),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                const Expanded(child: Text('Ngày đặt:')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(bookingDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Expanded(child: Text('Ngày check-in:')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(checkinDate),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Expanded(child: Text('Tổng tiền:')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(totalAmount),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Row(
              children: [
                const Expanded(child: Text('Trạng thái:')),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: status == 'Đã thanh toán'
                            ? Colors.green
                            : Colors.red,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        status,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  // Thêm hành động cho nút Chi tiết
                },

                child: const Text(
                  'Chi tiết',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
