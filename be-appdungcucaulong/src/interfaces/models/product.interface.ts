export interface Product {
  ID_Product: number;
  Name: string;
  Price: number;
  Quantity: number;
  Description?: string;
  Image?: string;
  ID_Category: number;
  CategoryName?: string;
  MaterialName?: string;
  WarrantyContent?: string;
}