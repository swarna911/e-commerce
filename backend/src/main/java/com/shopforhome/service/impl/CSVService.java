package com.shopforhome.service.impl;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.shopforhome.entity.ProductInfo;
import com.shopforhome.repository.ProductInfoRepository;
import com.shopforhome.vo.helper.CSVHelper;

@Service
public class CSVService {
	
	@Autowired
	ProductInfoRepository repository;
	
	public void save(MultipartFile file) {
	    try {
	      List<ProductInfo> tutorials = CSVHelper.csvToTutorials(file.getInputStream());
	      repository.saveAll(tutorials);
	    } catch (IOException e) {
	      throw new RuntimeException("fail to store csv data: " + e.getMessage());
	    }
	  }
	
	  public List<ProductInfo> getAllTutorials() {
	    return repository.findAll();
	  }

}
