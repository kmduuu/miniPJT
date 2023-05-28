package com.model2.mvc.web.product;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Autowired
	@Qualifier("prodServiceImpl")
	private ProductService productService;
	
	public ProductRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET)
	public Product getProduct(@PathVariable int prodNo) throws Exception {
		
		System.out.println("/product/json/getProduct");
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping( value="json/listProduct" )
	public Map listProduct(@RequestBody Search search) throws Exception{
		
		Map<String, Object> map = productService.getProductList(search);
		
		return map;
	}
	
	@RequestMapping(value = "json/getProdListAutoComplete/{searchCondition}", method = RequestMethod.POST)
	public List getUserListAutoComplete(@PathVariable String searchCondition) throws Exception{
		
		System.out.println("/user/json/getProdListAutoComplete : POST\n");
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		List<String> list = productService.getAllProdList(search);
		return list;
	}
}