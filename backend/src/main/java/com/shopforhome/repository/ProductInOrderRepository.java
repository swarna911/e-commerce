package com.shopforhome.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopforhome.entity.ProductInOrder;


public interface ProductInOrderRepository extends JpaRepository<ProductInOrder, Long> {

}
