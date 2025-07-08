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
}
