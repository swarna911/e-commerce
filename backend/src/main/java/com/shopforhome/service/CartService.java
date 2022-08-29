package com.shopforhome.service;

import java.util.Collection;

import com.shopforhome.entity.Cart;
import com.shopforhome.entity.ProductInOrder;
import com.shopforhome.entity.User;

public interface CartService {
    Cart getCart(User user);

    void mergeLocalCart(Collection<ProductInOrder> productInOrders, User user);

    void delete(String itemId, User user);

    void checkout(User user);
}
