// src/controllers/profile.controller.ts
import { Request, Response } from 'express';
import { getAllCustomersService, getProfileService } from '../services/profile.service';

export const getProfileController = async (req: Request, res: Response): Promise<void> => {
  try {
    const userId = req.user?.id;
    if (!userId) {
      res.status(401).json({ message: 'Unauthorized' });
      return;
    }

    const customer = await getProfileService(userId);
    res.status(200).json({ data: customer });
  } catch (error) {
    res.status(500).json({ message: 'Internal Server Error' });
  }
};


export const getAllCustomersController = async (_req: Request, res: Response) => {
  try {
    const users = await getAllCustomersService();
    res.json({ data: users });
  } catch (err) {
    res.status(500).json({ message: 'Lỗi khi lấy danh sách người dùng', error: err });
  }
};