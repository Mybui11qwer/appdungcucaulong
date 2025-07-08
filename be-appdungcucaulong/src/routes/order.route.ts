import { Router } from 'express';
import { OrderController } from '../controllers/order.controller';

const router = Router();

router.post('/', OrderController.create);
router.get('/customer/:customerId', OrderController.getByCustomer);
router.get('/:orderId', OrderController.getDetail);

export default router;
