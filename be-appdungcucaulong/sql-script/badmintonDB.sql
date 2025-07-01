-- TẠO DATABASE
CREATE DATABASE BadmintonShopDB;
GO

USE BadmintonShopDB;
GO

-- DANH MỤC SẢN PHẨM
CREATE TABLE Category (
    ID_Category INT PRIMARY KEY IDENTITY(1,1),
    Name_Category NVARCHAR(100) NOT NULL
);

-- CHẤT LIỆU
CREATE TABLE Material (
    ID_Material INT PRIMARY KEY IDENTITY(1,1),
    Name_Material NVARCHAR(100) NOT NULL
);

-- CHÍNH SÁCH BẢO HÀNH
CREATE TABLE Warranty_Policy (
    ID_Warranty INT PRIMARY KEY IDENTITY(1,1),
    Content NVARCHAR(MAX) NOT NULL
);

-- KÍCH CỠ
CREATE TABLE Size (
    ID_Size INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

-- KHUYẾN MÃI
CREATE TABLE Promotion (
    ID_Sale INT PRIMARY KEY IDENTITY(1,1),
    Percent_Discount INT NOT NULL CHECK (Percent_Discount BETWEEN 0 AND 100),
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Code NVARCHAR(50) NOT NULL,
    NamePromotion NVARCHAR(100) NOT NULL
);

-- KHÁCH HÀNG
CREATE TABLE Customer (
    ID_Customer INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Phone NVARCHAR(15),
    Address NVARCHAR(255),
    Gender NVARCHAR(10) CHECK (Gender IN ('Nam', 'Nữ', 'Khác')),
    Password NVARCHAR(255) NOT NULL,
    Avatar NVARCHAR(255),
    Role NVARCHAR(20) NOT NULL DEFAULT 'Customer'
);

-- SẢN PHẨM
CREATE TABLE Product (
    ID_Product INT PRIMARY KEY IDENTITY(1,1),
    ID_Category INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18, 2) NOT NULL CHECK (Price >= 0),
    Quantity INT NOT NULL CHECK (Quantity >= 0),
    Description NVARCHAR(MAX),
    Image NVARCHAR(255),
    ID_Warranty INT,
    ID_Material INT,

    FOREIGN KEY (ID_Category) REFERENCES Category(ID_Category),
    FOREIGN KEY (ID_Warranty) REFERENCES Warranty_Policy(ID_Warranty),
    FOREIGN KEY (ID_Material) REFERENCES Material(ID_Material)
);

-- GIỎ HÀNG
CREATE TABLE Cart (
    ID_Cart INT PRIMARY KEY IDENTITY(1,1),
    ID_Customer INT NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer)
);

-- CHI TIẾT GIỎ HÀNG
CREATE TABLE CartItem (
    ID_CartItem INT PRIMARY KEY IDENTITY(1,1),
    ID_Cart INT NOT NULL,
    ID_Product INT NOT NULL,
    ID_Size INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),

    FOREIGN KEY (ID_Cart) REFERENCES Cart(ID_Cart),
    FOREIGN KEY (ID_Product) REFERENCES Product(ID_Product),
    FOREIGN KEY (ID_Size) REFERENCES Size(ID_Size)
);

-- ĐƠN HÀNG
CREATE TABLE [Order] (
    ID_Order INT PRIMARY KEY IDENTITY(1,1),
    ID_Customer INT NOT NULL,
    Order_Date DATETIME DEFAULT GETDATE(),
    Total DECIMAL(18, 2) NOT NULL CHECK (Total >= 0),
    Status NVARCHAR(20) NOT NULL DEFAULT N'Chờ xử lý',
    ID_Sale INT,
    PaymentMethod NVARCHAR(50) NOT NULL,
    ShippingAddress NVARCHAR(255) NOT NULL,

    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer),
    FOREIGN KEY (ID_Sale) REFERENCES Promotion(ID_Sale)
);

-- CHI TIẾT ĐƠN HÀNG
CREATE TABLE Detail_Order (
    ID_Detail_Order INT PRIMARY KEY IDENTITY(1,1),
    ID_Order INT NOT NULL,
    ID_Product INT NOT NULL,
    ID_Size INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Unit_Price DECIMAL(18, 2) NOT NULL CHECK (Unit_Price >= 0),

    FOREIGN KEY (ID_Order) REFERENCES [Order](ID_Order),
    FOREIGN KEY (ID_Product) REFERENCES Product(ID_Product),
    FOREIGN KEY (ID_Size) REFERENCES Size(ID_Size)
);

-- THANH TOÁN
CREATE TABLE Payment (
    ID_Payment INT PRIMARY KEY IDENTITY(1,1),
    ID_Order INT NOT NULL,
    Amount DECIMAL(18,2) NOT NULL CHECK (Amount >= 0),
    PaymentDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(20) NOT NULL CHECK (Status IN ('Success', 'Failed', 'Pending')),
    TransactionID NVARCHAR(100),

    FOREIGN KEY (ID_Order) REFERENCES [Order](ID_Order)
);

-- ĐÁNH GIÁ SẢN PHẨM
CREATE TABLE Review (
    ID_Review INT PRIMARY KEY IDENTITY(1,1),
    ID_Product INT NOT NULL,
    ID_Customer INT NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (ID_Product) REFERENCES Product(ID_Product),
    FOREIGN KEY (ID_Customer) REFERENCES Customer(ID_Customer)
);

-- SLIDER (BANNER TRANG CHỦ)
CREATE TABLE Slider (
    ID_Slider INT PRIMARY KEY IDENTITY(1,1),
    Image_Url NVARCHAR(255) NOT NULL,
    Title NVARCHAR(100),
    Description NVARCHAR(255),
    Link NVARCHAR(255),
    Position INT DEFAULT 1,
    Active BIT DEFAULT 1
);
