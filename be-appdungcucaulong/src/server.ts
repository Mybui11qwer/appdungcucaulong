import express from "express";
import swaggerUi from "swagger-ui-express";
import swaggerSpec from "./configs/swagger";
import loginRoutes from "./routes/login.route";
import Database from "./configs/db";
import productRoute from "./routes/product.route";
import cartRoute from "./routes/cart.route";
import orderRoute from "./routes/order.route";
import uploadRoutes from "./routes/upload.route"
import path from 'path';
import profileRoute from "./routes/profile.route";

const app = express();
const db = new Database();

app.use(express.json());

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use('/api/public', express.static(path.join(__dirname, '../public')));

app.get("/", (req, res) => {
  res.send("🎉 API Cầu Lông đang chạy!");
});

app.use("/api", loginRoutes);
app.use("/api/products", productRoute);
app.use("/api/cart", cartRoute);
app.use('/api/order', orderRoute);
app.use('/api/public', uploadRoutes);
app.use('/api/user', profileRoute);


const PORT = process.env.PORT || 3000;

Database.getInstance()
  .then(() => {
    app.listen(PORT, () => {
      console.log(`🚀 Server is running at http://localhost:${PORT}`);
      console.log(`📚 Swagger docs at http://localhost:${PORT}/api-docs`);
    });
  })
  .catch((err: any) => {
    console.error("❌ Lỗi kết nối DB:", err);
  });
