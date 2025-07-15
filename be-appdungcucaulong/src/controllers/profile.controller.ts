// src/controllers/profile.controller.ts
import { Request, Response } from 'express';
import { getProfileService } from '../services/profile.service';

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
