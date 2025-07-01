
-- TẠO TEST DATA CHO BadmintonShopDB

-- CATEGORY
INSERT INTO Category (Name_Category)
VALUES 
(N'Vợt cầu lông'), 
(N'Giày cầu lông'), 
(N'Quần áo thể thao'), 
(N'Balo'), 
(N'Phụ kiện');

-- MATERIAL
INSERT INTO Material (Name_Material)
VALUES 
(N'Carbon'), 
(N'Nhôm'), 
(N'Sợi tổng hợp'), 
(N'Vải Polyester'), 
(N'Nhựa ABS');

-- WARRANTY_POLICY
INSERT INTO Warranty_Policy (Content)
VALUES 
(N'Bảo hành 6 tháng'),
(N'Bảo hành 12 tháng'),
(N'Không bảo hành'),
(N'Bảo hành đổi trả trong 7 ngày');

-- SIZE
INSERT INTO Size (Name)
VALUES 
(N'S'), (N'M'), (N'L'), (N'XL'), (N'XXL'), (N'Free Size'), (N'39'), (N'40'), (N'41'), (N'42');

-- PROMOTION
INSERT INTO Promotion (Percent_Discount, Start_Date, End_Date, Code, NamePromotion)
VALUES 
(10, '2025-07-01', '2025-07-31', 'SUMMER10', N'Khuyến mãi mùa hè'),
(15, '2025-08-01', '2025-08-15', 'BACK2SCHOOL', N'Tựu trường 2025'),
(5, '2025-07-01', '2025-07-15', 'JULY5', N'Giảm nhẹ tháng 7'),
(20, '2025-09-01', '2025-09-10', 'SEPT20', N'Ưu đãi tháng 9');

-- CUSTOMER
INSERT INTO Customer (Username, Email, Phone, Address, Gender, Password, Avatar)
VALUES 
(N'khanhmy', 'khanhmy@example.com', '0901234567', N'Hà Nội', N'Nữ', 'hashed123', 'avatar1.jpg'),
(N'thanhdat', 'thanhdat@example.com', '0912345678', N'Hồ Chí Minh', N'Nam', 'hashed456', 'avatar2.jpg'),
(N'quanghuy', 'quanghuy@example.com', '0939876543', N'Đà Nẵng', N'Nam', '123456abc', 'avatar3.jpg'),
(N'lethu', 'lethu@example.com', '0987654321', N'Hải Phòng', N'Nữ', '789xyz', 'avatar4.jpg');

-- PRODUCT
INSERT INTO Product (ID_Category, Name, Price, Quantity, Description, Image, ID_Warranty, ID_Material)
VALUES 
(1, N'Vợt Yonex Astrox 99', 2500000, 10, N'Vợt tấn công chuyên nghiệp', 'astrox99.jpg', 1, 1),
(1, N'Vợt Lining Turbo X', 1800000, 15, N'Vợt nhẹ phù hợp cho phòng thủ', 'liningx.jpg', 2, 1),
(2, N'Giày Mizuno Wave', 1500000, 20, N'Giày êm, độ bám cao', 'mizuno.jpg', 1, 5),
(2, N'Giày Yonex SHB 65Z3', 1800000, 12, N'Giày thi đấu cao cấp', 'shb65z3.jpg', 1, 5),
(3, N'Áo cầu lông Lining', 350000, 30, N'Vải thấm hút mồ hôi tốt', 'lining-shirt.jpg', 3, 4),
(4, N'Balo cầu lông Victor', 650000, 8, N'Nhiều ngăn tiện lợi', 'victor-bag.jpg', 4, 5),
(5, N'Grip cầu lông', 50000, 100, N'Băng quấn cán tay cầm', 'grip.jpg', 3, 5);

-- CART
INSERT INTO Cart (ID_Customer)
VALUES 
(1), (2), (3);

-- CART ITEM
INSERT INTO CartItem (ID_Cart, ID_Product, ID_Size, Quantity)
VALUES 
(1, 1, 8, 1), 
(1, 3, 9, 2),
(2, 2, 8, 1),
(2, 5, 2, 3),
(3, 4, 10, 1);

-- ORDER
INSERT INTO [Order] (ID_Customer, Total, Status, ID_Sale, PaymentMethod, ShippingAddress)
VALUES 
(1, 2650000, N'Chờ xử lý', 1, N'COD', N'Hà Nội'),
(2, 2000000, N'Đã giao', 2, N'Momo', N'Hồ Chí Minh'),
(3, 1800000, N'Đang giao', NULL, N'Chuyển khoản', N'Đà Nẵng');

-- DETAIL ORDER
INSERT INTO Detail_Order (ID_Order, ID_Product, ID_Size, Quantity, Unit_Price)
VALUES 
(1, 1, 8, 1, 2500000),
(1, 5, 2, 1, 150000),
(2, 3, 9, 1, 1500000),
(3, 2, 8, 1, 1800000);

-- PAYMENT
INSERT INTO Payment (ID_Order, Amount, Status, TransactionID)
VALUES 
(1, 2650000, N'Pending', 'TXN001'),
(2, 2000000, N'Success', 'TXN002'),
(3, 1800000, N'Success', 'TXN003');

-- REVIEW
INSERT INTO Review (ID_Product, ID_Customer, Rating, Comment)
VALUES 
(1, 1, 5, N'Vợt rất tốt, đánh êm tay'),
(2, 2, 4, N'Phù hợp với người mới'),
(3, 3, 5, N'Giày êm và chắc chắn'),
(5, 4, 3, N'Áo mặc thoáng mát, nhưng form hơi nhỏ');

-- SLIDER
INSERT INTO Slider (Image_Url, Title, Description, Link, Position, Active)
VALUES 
('slider1.jpg', N'Khuyến mãi lớn', N'Giảm giá cực sốc', '/sale', 1, 1),
('slider2.jpg', N'Sản phẩm mới', N'Cập nhật vợt mới nhất', '/products', 2, 1),
('slider3.jpg', N'Ưu đãi combo', N'Mua giày tặng vớ', '/combo', 3, 1);
