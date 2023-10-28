package com.chillisrestaurant.app.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.chillisrestaurant.app.entities.FoodProduct;

public interface FoodProductRepository extends JpaRepository<FoodProduct, Long> {
}
