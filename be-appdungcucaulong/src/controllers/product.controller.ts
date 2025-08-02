import { Request, Response } from "express";
import { ProductService } from "../services/product.service";
import { Product } from "../interfaces/models/product.model";

export class ProductController {
  private productService: ProductService;

  constructor() {
    this.productService = new ProductService();

     this.getAll = this.getAll.bind(this);
     this.getDetail = this.getDetail.bind(this);
    this.create = this.create.bind(this);
    this.update = this.update.bind(this);
    this.delete = this.delete.bind(this);
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
      const product: Product = req.body;
      await this.productService.createProduct(product);
      res.status(201).json({ message: "Product created successfully" });
    } catch (error) {
      console.error("Create product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  }

  async update(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      if (isNaN(id)) return res.status(400).json({ message: "Invalid ID" });

      const product: Product = req.body;
      await this.productService.updateProduct(id, product);
      res.status(200).json({ message: "Product updated successfully" });
    } catch (error) {
      console.error("Update product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  }

  async delete(req: Request, res: Response) {
    try {
      const id = parseInt(req.params.id);
      if (isNaN(id)) return res.status(400).json({ message: "Invalid ID" });

      await this.productService.deleteProduct(id);
      res.status(200).json({ message: "Product deleted successfully" });
    } catch (error) {
      console.error("Delete product error:", error);
      res.status(500).json({ message: "Server Error" });
    }
  }
}
