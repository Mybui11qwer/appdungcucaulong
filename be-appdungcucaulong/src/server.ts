import express from "express";
import swaggerUi from "swagger-ui-express";
import swaggerSpec from "./configs/swagger";
import productRoutes from "./routes/product.route";
import loginRoutes from "./routes/login.route"
import TYPES from "./configs/types";
import Database from "./configs/db"; 

const app = express();
const db = new Database();

(async () => {
    try {
        await db.connect(); // 🔥 Gọi kết nối tại đây
        // Nếu không lỗi => đã kết nối OK
    } catch (err) {
        console.error("❌ Kết nối database thất bại:", err);
    }
})();

app.use(express.json());

// Route Swagger
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.get("/", (req, res) => {
  res.send("🎉 API Cầu Lông đang chạy!");
});

// Các routes khác
app.use("/api/products", productRoutes);
app.use("/api", loginRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Server is running on http://localhost:${PORT}`);
    console.log(`📚 Swagger docs: http://localhost:${PORT}/api-docs`);
});