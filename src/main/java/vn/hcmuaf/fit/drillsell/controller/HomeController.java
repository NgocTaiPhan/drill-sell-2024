package vn.hcmuaf.fit.drillsell.controller;


import vn.hcmuaf.fit.drillsell.dao.ProductDAO;
import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.utils.ProductUtils;

import java.util.ArrayList;
import java.util.List;

public class HomeController {



    public HomeController() {


    }

    public List<List<Products>> getAllProducts() {
        List<List<Products>> allHomeProds = new ArrayList<>(); //Load tất cả sản phẩm ở home
        allHomeProds.add(ProductUtils.getAllProducts());
        allHomeProds.add(ProductUtils.getAllProducts());
        allHomeProds.add(ProductUtils.getAccessory());
        return allHomeProds;
    }



    public static void main(String[] args) {
        System.out.println(ProductUtils.getAllProducts()
        );

    }


}
