package com.shopforhome.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shopforhome.entity.Discount;

public interface DiscountRepository extends JpaRepository<Discount, String> {

}
