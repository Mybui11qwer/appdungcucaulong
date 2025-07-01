import Database from "./db";

const db = new Database();

(async () => {
    try {
        await db.connect(); // kết nối DB

        const pool = db.getPool(); // lấy pool
        const result = await pool.request().query("SELECT * FROM Product");

        console.log("📦 Dữ liệu trong bảng Product:");
        console.table(result.recordset); // In ra dạng bảng đẹp

        await db.close(); // đóng kết nối nếu cần
    } catch (err) {
        console.error("❌ Lỗi truy vấn:", err);
    }
})();
