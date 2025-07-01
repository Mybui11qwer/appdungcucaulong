-- Giảm tồn kho khi tạo chi tiết đơn hàng
CREATE TRIGGER trg_UpdateProductStock_AfterOrder
ON Detail_Order
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.Quantity = p.Quantity - i.Quantity
    FROM Product p
    JOIN inserted i ON p.ID_Product = i.ID_Product;
END;
GO

-- Khôi phục tồn kho khi xóa chi tiết đơn hàng
CREATE TRIGGER trg_RestoreStock_OnDeleteOrderDetail
ON Detail_Order
AFTER DELETE
AS
BEGIN
    UPDATE p
    SET p.Quantity = p.Quantity + d.Quantity
    FROM Product p
    JOIN deleted d ON p.ID_Product = d.ID_Product;
END;
GO

-- Kiểm tra tồn kho khi thêm vào giỏ hàng (chặn nếu vượt quá)
CREATE TRIGGER trg_CheckStock_OnCartInsert
ON CartItem
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN Product p ON i.ID_Product = p.ID_Product
        WHERE i.Quantity > p.Quantity
    )
    BEGIN
        RAISERROR ('Số lượng sản phẩm trong giỏ vượt quá tồn kho.', 16, 1);
        RETURN;
    END

    INSERT INTO CartItem (ID_Cart, ID_Product, ID_Size, Quantity)
    SELECT ID_Cart, ID_Product, ID_Size, Quantity
    FROM inserted;
END;
GO

-- Kiểm tra hạn khuyến mãi khi tạo đơn hàng
CREATE TRIGGER trg_ValidatePromotionDate
ON [Order]
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted o
        JOIN Promotion p ON o.ID_Sale = p.ID_Sale
        WHERE GETDATE() NOT BETWEEN p.Start_Date AND p.End_Date
    )
    BEGIN
        RAISERROR ('Mã khuyến mãi không còn hiệu lực.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Không cho tạo đơn hàng nếu không có chi tiết giỏ hàng
CREATE TRIGGER trg_PreventEmptyCartOrder
ON [Order]
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted i
        LEFT JOIN Cart c ON i.ID_Customer = c.ID_Customer
        LEFT JOIN CartItem ci ON ci.ID_Cart = c.ID_Cart
        GROUP BY c.ID_Cart
        HAVING COUNT(ci.ID_CartItem) = 0
    )
    BEGIN
        RAISERROR('Không thể đặt hàng khi giỏ hàng trống.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Xóa giỏ hàng khi đơn hàng đã tạo
CREATE TRIGGER trg_ClearCartAfterOrder
ON [Order]
AFTER INSERT
AS
BEGIN
    DELETE ci
    FROM CartItem ci
    JOIN Cart c ON ci.ID_Cart = c.ID_Cart
    JOIN inserted i ON i.ID_Customer = c.ID_Customer;
END;
GO

--Thêm sản phẩm có giá hoặc số lượng không hợp lệ
CREATE TRIGGER trg_ValidateProductInsert
ON Product
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE Price <= 0 OR Quantity < 0
    )
    BEGIN
        RAISERROR('Giá phải lớn hơn 0 và số lượng không được âm.', 16, 1);
        RETURN;
    END

    INSERT INTO Product (ID_Category, Name, Price, Quantity, Description, Image, ID_Warranty, ID_Material)
    SELECT ID_Category, Name, Price, Quantity, Description, Image, ID_Warranty, ID_Material
    FROM inserted;
END;
GO

-- Chặn xóa sản phẩm đã từng bán
CREATE TRIGGER trg_PreventDeleteSoldProduct
ON Product
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted d
        JOIN Detail_Order od ON d.ID_Product = od.ID_Product
    )
    BEGIN
        RAISERROR('Không thể xóa sản phẩm đã tồn tại trong đơn hàng.', 16, 1);
        RETURN;
    END

    DELETE FROM Product WHERE ID_Product IN (SELECT ID_Product FROM deleted);
END;
GO
