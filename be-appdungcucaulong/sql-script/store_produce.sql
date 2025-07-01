-- Thêm sản phẩm
CREATE PROCEDURE sp_AddProduct
    @ID_Category INT,
    @Name NVARCHAR(100),
    @Price DECIMAL(18,2),
    @Quantity INT,
    @Description NVARCHAR(MAX),
    @Image NVARCHAR(255),
    @ID_Warranty INT,
    @ID_Material INT
AS
BEGIN
    INSERT INTO Product(ID_Category, Name, Price, Quantity, Description, Image, ID_Warranty, ID_Material)
    VALUES (@ID_Category, @Name, @Price, @Quantity, @Description, @Image, @ID_Warranty, @ID_Material)
END
GO

-- Cập nhật số lượng tồn kho
CREATE PROCEDURE sp_UpdateProductStock
    @ID_Product INT,
    @Quantity INT
AS
BEGIN
    UPDATE Product
    SET Quantity = @Quantity
    WHERE ID_Product = @ID_Product
END
GO

-- Lấy danh sách sản phẩm
CREATE PROCEDURE sp_GetAllProducts
AS
BEGIN
    SELECT p.*, c.Name_Category, m.Name_Material, w.Content AS WarrantyContent
    FROM Product p
    LEFT JOIN Category c ON p.ID_Category = c.ID_Category
    LEFT JOIN Material m ON p.ID_Material = m.ID_Material
    LEFT JOIN Warranty_Policy w ON p.ID_Warranty = w.ID_Warranty
END
GO

-- Đăng ký khách hàng mới
CREATE PROCEDURE sp_RegisterCustomer
    @Username NVARCHAR(50),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(15),
    @Address NVARCHAR(255),
    @Gender NVARCHAR(10),
    @Password NVARCHAR(255),
    @Avatar NVARCHAR(255) = NULL
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Customer WHERE Email = @Email)
    BEGIN
        RAISERROR('Email đã được đăng ký', 16, 1)
        RETURN
    END

    INSERT INTO Customer(Username, Email, Phone, Address, Gender, Password, Avatar)
    VALUES (@Username, @Email, @Phone, @Address, @Gender, @Password, @Avatar)
END
GO

-- Thêm sản phẩm vào giỏ hàng
CREATE PROCEDURE sp_AddToCart
    @ID_Customer INT,
    @ID_Product INT,
    @ID_Size INT,
    @Quantity INT
AS
BEGIN
    DECLARE @ID_Cart INT

    SELECT @ID_Cart = ID_Cart FROM Cart WHERE ID_Customer = @ID_Customer

    IF @ID_Cart IS NULL
    BEGIN
        INSERT INTO Cart(ID_Customer) VALUES (@ID_Customer)
        SET @ID_Cart = SCOPE_IDENTITY()
    END

    INSERT INTO CartItem(ID_Cart, ID_Product, ID_Size, Quantity)
    VALUES (@ID_Cart, @ID_Product, @ID_Size, @Quantity)
END
GO

-- Lấy danh sách sản phẩm trong giỏ hàng
CREATE PROCEDURE sp_GetCartItems
    @ID_Customer INT
AS
BEGIN
    SELECT ci.*, p.Name, p.Image, p.Price, s.Name AS Size
    FROM CartItem ci
    JOIN Cart c ON ci.ID_Cart = c.ID_Cart
    JOIN Product p ON ci.ID_Product = p.ID_Product
    JOIN Size s ON ci.ID_Size = s.ID_Size
    WHERE c.ID_Customer = @ID_Customer
END
GO

-- Tạo đơn hàng mới
CREATE PROCEDURE sp_CreateOrder
    @ID_Customer INT,
    @ID_Sale INT = NULL,
    @PaymentMethod NVARCHAR(50),
    @ShippingAddress NVARCHAR(255),
    @Total DECIMAL(18,2),
    @ID_Order INT OUTPUT
AS
BEGIN
    INSERT INTO [Order] (ID_Customer, Order_Date, Total, Status, ID_Sale, PaymentMethod, ShippingAddress)
    VALUES (@ID_Customer, GETDATE(), @Total, 'Pending', @ID_Sale, @PaymentMethod, @ShippingAddress)

    SET @ID_Order = SCOPE_IDENTITY()
END
GO

-- Lấy chi tiết đơn hàng
CREATE PROCEDURE sp_GetOrderDetail
    @ID_Order INT
AS
BEGIN
    SELECT o.ID_Order, o.Order_Date, o.Total, o.Status,
           c.Username, p.Name, d.Quantity, d.Unit_Price, s.Name AS Size
    FROM [Order] o
    JOIN Customer c ON o.ID_Customer = c.ID_Customer
    JOIN Detail_Order d ON o.ID_Order = d.ID_Order
    JOIN Product p ON d.ID_Product = p.ID_Product
    JOIN Size s ON d.ID_Size = s.ID_Size
    WHERE o.ID_Order = @ID_Order
END
GO

-- Thanh toán đơn hàng
CREATE PROCEDURE sp_MakePayment
    @ID_Order INT,
    @Amount DECIMAL(18,2),
    @TransactionID NVARCHAR(100)
AS
BEGIN
    INSERT INTO Payment (ID_Order, Amount, PaymentDate, Status, TransactionID)
    VALUES (@ID_Order, @Amount, GETDATE(), 'Success', @TransactionID)

    UPDATE [Order]
    SET Status = 'Paid'
    WHERE ID_Order = @ID_Order
END
GO

-- Kiểm tra mã khuyến mãi hợp lệ
CREATE PROCEDURE sp_ValidatePromotionCode
    @Code NVARCHAR(50)
AS
BEGIN
    SELECT * FROM Promotion
    WHERE Code = @Code AND GETDATE() BETWEEN Start_Date AND End_Date
END
GO

-- Thêm đánh giá sản phẩm
CREATE PROCEDURE sp_AddReview
    @ID_Product INT,
    @ID_Customer INT,
    @Rating INT,
    @Comment NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO Review(ID_Product, ID_Customer, Rating, Comment)
    VALUES (@ID_Product, @ID_Customer, @Rating, @Comment)
END
GO

-- Lấy danh sách đánh giá sản phẩm
CREATE PROCEDURE sp_GetProductReviews
    @ID_Product INT
AS
BEGIN
    SELECT r.*, c.Username, c.Avatar
    FROM Review r
    JOIN Customer c ON r.ID_Customer = c.ID_Customer
    WHERE r.ID_Product = @ID_Product
    ORDER BY r.CreatedAt DESC
END
GO
