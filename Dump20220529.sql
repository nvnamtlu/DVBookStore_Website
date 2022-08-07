-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: vbook
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` bigint NOT NULL AUTO_INCREMENT,
  `author_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
INSERT INTO `authors` VALUES (9,'Chưa xác định'),(10,'Trang Anh'),(11,'Lê Văn Tuấn'),(12,'Lại Đắc Hợp'),(13,'Phan Khắc Nghệ'),(14,'Phạm Huy Hoàng'),(15,'Nguyễn Văn Thành'),(16,'Cảnh Thiên'),(17,'Rosie Nguyễn'),(18,'Minh Niệm'),(19,'Hannah Fry'),(20,'Robert Cecil Martin');
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` bigint NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (6,'Ngoại Ngữ'),(7,'Công Nghệ'),(8,'Phát Triển Bản Thân'),(9,'Ôn Thi THPT');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `favorite_id` bigint NOT NULL AUTO_INCREMENT,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`favorite_id`),
  KEY `FK6sgu5npe8ug4o42bf9j71x20c` (`product_id`),
  KEY `FK1uphh0glinnprjknyl68k1hw1` (`user_id`),
  CONSTRAINT `FK1uphh0glinnprjknyl68k1hw1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FK6sgu5npe8ug4o42bf9j71x20c` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES (19,51,2);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_details`
--

DROP TABLE IF EXISTS `order_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_details` (
  `order_detail_id` bigint NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `quantity` int NOT NULL,
  `order_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`order_detail_id`),
  KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`),
  CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_details`
--

LOCK TABLES `order_details` WRITE;
/*!40000 ALTER TABLE `order_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `order_date` date DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `status` int NOT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FKel9kyl84ego2otj2accfd8mr7` (`user_id`),
  CONSTRAINT `FKel9kyl84ego2otj2accfd8mr7` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` bigint NOT NULL AUTO_INCREMENT,
  `description` varchar(1000) DEFAULT NULL,
  `discount` int NOT NULL,
  `entered_date` date DEFAULT NULL,
  `favorite` bit(1) NOT NULL,
  `price` double NOT NULL,
  `product_image` varchar(255) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `author_id` bigint DEFAULT NULL,
  `category_id` bigint DEFAULT NULL,
  `publisher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FKy2kver9ldog29n3mi9b12w64` (`author_id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  KEY `FKrqe0lw2hftd2rbg6umgy1bcrl` (`publisher_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  CONSTRAINT `FKrqe0lw2hftd2rbg6umgy1bcrl` FOREIGN KEY (`publisher_id`) REFERENCES `publishs` (`publisher_id`),
  CONSTRAINT `FKy2kver9ldog29n3mi9b12w64` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (48,'Đầy đủ nhất với 30 CHUYÊN ĐỀ NGỮ PHÁP Trong Tiếng Anh của cô Trang Anh - Dày 606 trang gần 7.000 bài tập  - SỐ LƯỢNG BÀI NHIỀU NHẤT - TỔNG ÔN TẬP ngữ pháp tiếng anh - CHẮC CHẮN CÓ trong đề thi - Lý thuyết được đơn giản hoá, trình bày MINDMAP dễ hiểu và siêu dễ nhớ - Mức độ bài tập đi từ CỰC DỄ đến KHÔNG THỂ KHÓ HƠN.',31,'2022-05-17',_binary '\0',250,'tongonnguphap.jpg','Tổng  Ôn Ngữ Pháp Tiếng Anh',9,10,9,7),(49,'Học ngữ pháp từ con số 0 - Hiểu tiếng anh theo cách đơn giản nhất - Đầy đủ 4 kỹ năng: Nghe, Nói, Đọc, Viết - Học giao tiếp theo chuyên đề ngữ pháp - Bài tập luyện tập hướng tới từng kỹ năng.',14,'2022-05-17',_binary '\0',120,'tienganhchonguoimoi.jpg','Tiếng Anh Cho Người Mới Bắt Đầu',10,10,9,7),(50,'Sách ôn thi THPT Quốc gia luyện đề trắc nghiệm môn Toán 2022 MỚI NHẤT - Thầy Lê Văn Tuấn LIVESTREAM chữa chi tiết đề minh họa - 100% đề thi có lời giải chi tiết - Số lượng lên tới 50 đề minh họa luyện tập, bám sát với ma trận đề thi chính thức của Bộ Giáo dục.',46,'2022-05-17',_binary '\0',200,'50detoan.jpg','50 Đề Thi THPT QG Môn Toán',15,11,9,7),(51,'Essential words for TOEIC (Tái bản lần thứ 6) là cuốn sách giúp người học xây dựng vốn từ vựng, tập trung vào 600 từ vựng Anh - Mỹ thường xuất hiện trong kỳ thi TOEIC. Từ vựng và cách dùng từ là những gì mà quyển sách này hướng đến để giúp bạn chuẩn bị tốt cho kỳ thi TOEIC (Kỳ thi Trắc nghiệm tiếng Anh trong giao tiếp quốc tế).',27,'2022-05-18',_binary '',238,'toeic1.jpg','Barron\'s Essential Words For The Toeic',15,9,6,8),(52,'Very Easy TOEIC 1 phù hợp với người học muốn đạt trình độ A1-A2 (250 – 400 điểm).',31,'2022-05-18',_binary '\0',228,'toeic2.jpg','Very Easy Toeic 1 - Introduction',10,9,6,8),(53,'Bộ sách học từ vựng cấp độ N5 ~ N1 dành cho Kỳ thi Năng lực Nhật ngữ. Bộ sách gồm 5 cuốn: N1, N2, N3, N4, N5, tập hợp các từ vựng xuất hiện thường xuyên trong các kỳ thi Năng lực Nhật ngữ. Các từ vựng này được chia theo từng chủ đề, đi kèm các câu ví dụ. Đặc biệt bộ sách có kèm theo bản dịch Anh - Trung - Việt, rất tiện cho các bạn tự học ở nhà.',21,'2022-05-18',_binary '\0',72,'japann5.jpg','1000 Từ Vựng Cần Thiết Cho Kỳ Thi N5',4,9,6,9),(54,'Bộ sách học từ vựng cấp độ N5 ~ N1 dành cho Kỳ thi Năng lực Nhật ngữ. Bộ sách gồm 5 cuốn: N1, N2, N3, N4, N5, tập hợp các từ vựng xuất hiện thường xuyên trong các kỳ thi Năng lực Nhật ngữ. Các từ vựng này được chia theo từng chủ đề, đi kèm các câu ví dụ. Đặc biệt bộ sách có kèm theo bản dịch Anh - Trung - Việt, rất tiện cho các bạn tự học ở nhà.',37,'2022-05-18',_binary '\0',110,'japann3.jpg','2000 Từ Vựng Cần Thiết Cho Kỳ Thi N3',5,9,6,9),(55,'mỗi đề đều gồm 50 câu hỏi được phân bố theo các mức độ từ nhận biết, thông hiểu, VD, VDC. Với các câu hỏi ở mức độ thông hiểu, tác giả gài gắm nhiều câu bẫy, dễ mắc sai lầm, đòi hỏi các em phải nắm chắc lí thuyết mới có thể chọn đúng. Với các câu hỏi ở mức độ VD, VDC, tác giả đã cố gắng sáng tạo thêm để các em chủ động xử lí bài tập từ nhiều hướng khác nhau. Các câu hỏi trong mỗi đề được sắp xếp có ý đồ nhất định: thứ tự của câu tương ứng ở các đề tương ứng với một đơn vị kiến thức trong ma trận đề thi. Vì vậy, các em có thể luyện đề theo chiều dọc, cũng có thể tổng ôn tập, hệ thống hoá từng đơn vị kiến thức theo chiều ngang.',15,'2022-05-18',_binary '\0',120,'50dely.jpg','50 Đề Thi THPT QG Môn Lý',10,12,9,10),(56,'Bộ đề minh họa môn Sinh: Sách ID 50 đề thi trắc nghiệm do chính tay thầy Phan Khắc Nghệ chọn lọc và biên soạn. Thầy Phan Khắc Nghệ là giáo viên luyện thi THPT QG hàng đầu môn sinh trên cả nước, bề dày kiến thức sâu rộng và là tác giả của nhiều đầu sách tham khảo và nâng cao bộ môn Sinh học, nên chất lượng tài liệu và bộ đề phát hành luôn được đảm bảo và đi theo ĐÚNG HƯỚNG NHẤT tại mỗi thời điểm phát hành.',25,'2022-05-18',_binary '\0',139,'50desinh.jpg','50 Đề Thi THPT QG Môn Sinh',10,13,9,10),(57,'Cho tới thời điểm hiện tại, IT vẫn đang là một ngành hot và là sự lựa chọn của rất nhiều các bạn học sinh, sinh viên. Tuy nhiên, cho đến nay, những nguồn tài nguyên học tập trong ngành còn quá ít. Ngoài những tài liệu học tập của trường học thì những tài liệu khác chủ yếu vẫn là các thông tin trên internet hoặc từ những kinh nghiệm của những người đi trước. Để bạn đọc có cái nhìn chân thực và rõ nét hơn về ngành IT, thông qua cuốn sách này, tác giả Phạm Huy Hoàng đã tóm tắt và chia sẻ lại những câu chuyện, bài học kinh nghiệm đã gặp, đã đúc rút được để bạn đọc tham khảo và tìm ra những điểm tương đồng với những gì mình gặp trong khi học tập và làm việc để từ đó rút ra được bài học cho riêng mình.',0,'2022-05-19',_binary '\0',150,'toidicodedao.jpg','Hello Các Bạn Mình Là Tôi Đi Code Dạo',20,14,7,11),(58,'Quyển sách này gồm 22 bài học từ Tư duy LTHĐT(Đa hình, kế thừ) đến các đối tượng #JavaCore (String, Array, File), lập trình giao diện Swing.',13,'2022-05-19',_binary '\0',250,'javaoop.jpg','Lập trình hướng đối tượng JAVA core',10,15,7,6),(59,'Thanh xuân là khoảng thời gian đẹp đẽ nhất trong đời, cũng là những năm tháng then chốt có thể quyết định tương lai của một người. Nếu bạn lựa chọn an nhàn trong 10 năm, tương lai sẽ buộc bạn phải vất vả trong 50 năm để bù đắp lại. Nếu bạn bươn chải vất vả trong 10 năm, thứ mà bạn chắc chắn có được là 50 năm hạnh phúc. Điều quý giá nhất không phải là tiền mà là tiền bạc. Thế nên, bạn à, đừng lựa chọn an nhàn khi còn trẻ.',23,'2022-05-19',_binary '\0',99,'canhthien.jpg','Đừng Lựa Chọn An Nhàn Khi Còn Trẻ',15,16,8,12),(60,'Hãy đọc sách, nếu bạn đọc sách một cách bền bỉ, sẽ đến lúc bạn bị thôi thúc không ngừng bởi ý muốn viết nên cuốn sách của riêng mình. Nếu tôi còn ở tuổi đôi mươi, hẳn là tôi sẽ đọc Tuổi trẻ đáng giá bao nhiêu? nhiều hơn một lần.',13,'2022-05-19',_binary '\0',90,'rosienguyen.jpg','Tuổi Trẻ Đáng Giá Bao Nhiêu',15,17,8,13),(61,'Là tác phẩm đầu tay của nhà sư Minh Niệm, người sáng lập dòng thiền hiểu biết (Understanding Meditation), kết hợp giữa tư tưởng Phật giáo Đại thừa và Thiền nguyên thủy Vipassana, nhưng Hiểu Về Trái Tim không phải tác phẩm thuyết giáo về Phật pháp. Cuốn sách rất “đời” với những ưu tư của một người tu nhìn về cõi thế. Ở đó, có hạnh phúc, có đau khổ, có tình yêu, có cô đơn, có tuyệt vọng, có lười biếng, có yếu đuối, có buông xả… Nhưng, tất cả những hỉ nộ ái ố ấy đều được khoác lên tấm áo mới, một tấm áo tinh khiết và xuyên suốt, khiến người đọc khi nhìn vào, đều thấy mọi sự như nhẹ nhàng hơn…',13,'2022-05-23',_binary '\0',138,'hieubietvetraitim.jpg','Hiểu Về Trái Tim',10,18,8,8),(62,'Cuốn sách này khám phá những mảng mênh mông nơi các thuật toán đang len lỏi vào nhiều khía cạnh của đời sống xã hội, chính trị, kinh tế của con người. Thuật toán được cảnh sát sử dụng để quyết định xem nên bắt ai. Thuật toán được các tòa án sử dụng để đưa ra phán quyết. Thuật toán được các bác sĩ dùng để bác bỏ chẩn đoán của chính họ. Thuật toán cân đo đong đếm biểu cảm của con người. Thuật toán có sức mạnh phá hoại ngầm với các hệ thống nhà nước dân chủ',35,'2022-05-23',_binary '\0',150,'helloworld.jpg','Hello World- Làm Người Trong Kỷ Nguyên Máy Móc',10,19,7,14),(63,'Cuốn sách được chia thành ba phần lớn. Phần đầu tiên mô tả các nguyên tắc, mô hình và cách thực hành viết mã sạch. Phần thứ hai gồm nhiều tình huống điển hình với mức độ phức tạp gia tang không ngừng. Mỗi tình huống là một bài tập giúp làm sạch mã, chuyển đổi mã có nhiều vấn đề thành mã có ít vấn đề hơn. Và phần cuối là tuyển tập rất nhiều những dấu hiệu của mã có vấn đề, những tìm tòi, suy nghiệm từ thực tiễn được đúc rút qua cách tình huống điển hình.',15,'2022-05-23',_binary '\0',362,'cleancode.jpg','Clean Code – Con Đường Trở Thành Lập Trình Viên Giỏi',10,20,7,14);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publishs`
--

DROP TABLE IF EXISTS `publishs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publishs` (
  `publisher_id` bigint NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publishs`
--

LOCK TABLES `publishs` WRITE;
/*!40000 ALTER TABLE `publishs` DISABLE KEYS */;
INSERT INTO `publishs` VALUES (6,'Chưa xác định'),(7,'ĐHQG Hà Nội'),(8,'First News - Trí Việt'),(9,'NXB Trẻ'),(10,'NXB Hồng Đức'),(11,'NXB Thanh Niên'),(12,'NXB Thế Giới'),(13,'NXB Hội Nhà Văn'),(14,'NXB Dân Chí');
/*!40000 ALTER TABLE `publishs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_USER');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `register_date` date DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `UKob8kqyqqgmefl0aco34akdtpe` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user.png','nvnamtlu@gmail.com','Admin','$2a$10$KjN4PPhXKyhxreQfTcf...c5eiesN3U1Qz6agmCKwZ4Xg68iUIv/e','2022-03-05',_binary ''),(2,'user.png','helloworldtlu@gmail.com','User1','$2a$10$RZSf86I7BSA2k6uC97KNcu//cfA.q2uHbCICdBxvIMvBEsio9o..O','2022-03-13',_binary '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  KEY `FKt4v0rrweyk393bdgt107vdx0x` (`role_id`),
  KEY `FKgd3iendaoyh04b95ykqise6qh` (`user_id`),
  CONSTRAINT `FKgd3iendaoyh04b95ykqise6qh` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `FKt4v0rrweyk393bdgt107vdx0x` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'vbook'
--

--
-- Dumping routines for database 'vbook'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-29 19:42:48
