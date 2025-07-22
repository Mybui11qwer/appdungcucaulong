-- Tạo login ở cấp server
CREATE LOGIN adminBMT WITH PASSWORD = 'appcaulong123!';

-----------------------------------------------------
-- Chọn database muốn cấp quyền 
USE BadmintonShopDB;

-- Tạo user trong database đó, gắn với login ở trên
CREATE USER adminBMT FOR LOGIN adminBMT;

-- Cấp quyền cho user (toàn quyền)
ALTER ROLE db_owner ADD MEMBER adminBMT;