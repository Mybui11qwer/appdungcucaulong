import { Request, Response } from "express";
import { ProductService } from "../services/product.service";

export class ProductController {
  private productService: ProductService;

  constructor() {
    this.productService = new ProductService();

     this.getAll = this.getAll.bind(this);
     this.getDetail = this.getDetail.bind(this);
  }

  async getAll(req: Request, res: Response){
    try {
      const products = await this.productService.getAllProducts();
      res.status(200).json(products);
    } catch (error) {
      console.error("Get products error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  };

  async getDetail(req: Request, res: Response){
    try {
      const id = parseInt(req.params.id);
      if (isNaN(id)) return res.status(400).json({ message: "Invalid ID" });

      const product = await this.productService.getProductDetail(id);
      if (!product) return res.status(404).json({ message: "Product not found" });

      res.status(200).json(product);
    } catch (error) {
      console.error("Get product detail error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  };

  async create(req: Request, res: Response) {
    try {
      const { Name, Price, Quantity, Description, ID_Category, ID_Warranty, ID_Material } = req.body;
      const Image = req.file?.filename ?? ""; // tên file đã lưu trong public/images

      const product = await this.productService.createProduct({
        Name,
        Price: +Price,
        Quantity: +Quantity,
        Description,
        ID_Category: +ID_Category,
        ID_Warranty: +ID_Warranty,
        ID_Material: +ID_Material,
        Image,
      });

      res.status(201).json(product);
    } catch (error) {
      console.error("Create product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  };

  async update(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      if (isNaN(id)) return res.status(400).json({ message: "Invalid ID" });

      const { Name, Price, Quantity, Description, ID_Category, ID_Warranty, ID_Material } = req.body;
      const Image = req.file?.filename ?? undefined;

      const updated = await this.productService.updateProduct(id, {
        Name,
        Price: +Price,
        Quantity: +Quantity,
        Description,
        ID_Category: +ID_Category,
        ID_Warranty: +ID_Warranty,
        ID_Material: +ID_Material,
        ...(Image ? { Image } : {})
      });

      if (!updated) return res.status(404).json({ message: "Product not found" });

      res.status(200).json({ message: "Product updated" });
    } catch (error) {
      console.error("Update product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  };

  async delete(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      if (isNaN(id)) return res.status(400).json({ message: "Invalid ID" });

      const deleted = await this.productService.deleteProduct(id);
      if (!deleted) return res.status(404).json({ message: "Product not found" });

      res.status(200).json({ message: "Product deleted" });
    } catch (error) {
      console.error("Delete product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  };
}
