import swaggerJsdoc from "swagger-jsdoc";

const swaggerOptions = {
    definition: {
        openapi: "3.0.0",
        info: {
            title: "Badminton Shop API",
            version: "1.0.0",
            description: "API cho hệ thống bán dụng cụ cầu lông",
        },
        servers: [
            {
                url: "http://localhost:3000/api",
            }
        ],
        components: {
            schemas: {
                Product: {
                    type: "object",
                    properties: {
                        ID_Product: { type: "integer", example: 1 },
                        Name: { type: "string", example: "Vợt Yonex Astrox 100ZZ" },
                        Price: { type: "number", format: "float", example: 2500000 },
                        Quantity: { type: "integer", example: 100 },
                        Description: { type: "string", example: "Vợt cao cấp cho tuyển thủ" },
                        Image: { type: "string", example: "product1.jpg" },
                        CategoryName: { type: "string", example: "Vợt cầu lông" },
                        MaterialName: { type: "string", example: "Carbon Fiber" },
                        WarrantyContent: { type: "string", example: "Bảo hành 12 tháng" }
                    }
                },
                Customer: {
                    type: "object",
                    properties: {
                        ID_Customer: { type: "integer", example: 1 },
                        Username: { type: "string", example: "khanhmy123" },
                        Email: { type: "string", example: "my@gmail.com" },
                        Phone: { type: "string", example: "0987654321" },
                        Address: { type: "string", example: "Hà Nội, Việt Nam" },
                        Gender: { type: "string", example: "Nữ" },
                        Avatar: { type: "string", example: "avatar.jpg" },
                        Role: { type: "string", example: "Customer" }
                    }
                },
                CartItem: {
                    type: "object",
                    properties: {
                        ID_CartItem: { type: "integer", example: 1 },
                        ID_Product: { type: "integer", example: 1 },
                        ID_Size: { type: "integer", example: 2 },
                        Quantity: { type: "integer", example: 2 }
                    }
                },
                Order: {
                    type: "object",
                    properties: {
                        ID_Order: { type: "integer", example: 1001 },
                        ID_Customer: { type: "integer", example: 1 },
                        Order_Date: { type: "string", format: "date-time", example: "2025-07-01T10:30:00Z" },
                        Total: { type: "number", example: 5000000 },
                        Status: { type: "string", example: "Paid" },
                        PaymentMethod: { type: "string", example: "Bank Transfer" },
                        ShippingAddress: { type: "string", example: "123 Cầu Giấy, Hà Nội" }
                    }
                },
                Review: {
                    type: "object",
                    properties: {
                        ID_Review: { type: "integer", example: 1 },
                        ID_Product: { type: "integer", example: 1 },
                        ID_Customer: { type: "integer", example: 1 },
                        Rating: { type: "integer", example: 5 },
                        Comment: { type: "string", example: "Sản phẩm rất tốt!" },
                        CreatedAt: { type: "string", format: "date-time", example: "2025-07-01T08:00:00Z" }
                    }
                }
            },
            securitySchemes: {
                bearerAuth: {
                    type: "http",
                    scheme: "bearer",
                    bearerFormat: "JWT",
                    description: "Nhập token JWT (Bearer + token)"
                }
            }
        },
        security: [
            {
                bearerAuth: []
            }
        ]
    },
    apis: ["./src/routes/*.ts"], // quét tất cả routes có comment swagger
};

const swaggerSpec = swaggerJsdoc(swaggerOptions);

export default swaggerSpec;
