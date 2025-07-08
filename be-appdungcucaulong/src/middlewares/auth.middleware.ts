import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import env from "../configs/env";

export {}; // Ensure this file is a module

declare global {
  namespace Express {
    interface Request {
      user?: { id: number; role: string };
    }
  }
}

export const verifyToken = (req: Request, res: Response, next: NextFunction): void => {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    res.status(401).json({ message: "Không có token." });
    return; // ✅ dừng tại đây
  }

  try {
    const decoded = jwt.verify(token, env.getJwtSecret()) as { id: number; role: string };
    req.user = decoded;
    next();
  } catch (error) {
    res.status(403).json({ message: "Token không hợp lệ." });
    return; // ✅ dừng tại đây
  }
};