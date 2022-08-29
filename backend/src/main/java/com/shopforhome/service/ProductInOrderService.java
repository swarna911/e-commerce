package com.shopforhome.service;

import com.shopforhome.entity.ProductInOrder;
import com.shopforhome.entity.User;


public interface ProductInOrderService {
    void update(String itemId, Integer quantity, User user);
    ProductInOrder findOne(String itemId, User user);
}
