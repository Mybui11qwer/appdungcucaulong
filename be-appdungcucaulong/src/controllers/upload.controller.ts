import { Request, Response } from 'express';

export const uploadImage = (req: Request, res: Response, next: Function): void => {
  if (!req.file) {
    res.status(400).json({ message: 'No file uploaded' });
    return;
  }

  const imageUrl = `${req.protocol}://${req.get('host')}/public/images/${req.file.filename}`;

  res.status(200).json({
    message: 'Upload thành công',
    imageUrl,
  });
};

