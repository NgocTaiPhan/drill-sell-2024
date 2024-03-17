package vn.hcmuaf.fit.drillsell.controller;


import vn.hcmuaf.fit.drillsell.bean.Products;
import vn.hcmuaf.fit.drillsell.service.ProductService;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class HomeController {



    public HomeController() {


    }

    public List<List<Products>> getAllProducts() {
        List<List<Products>> allHomeProds = new ArrayList<>(); //Load tất cả sản phẩm ở home
        allHomeProds.add(ProductService.getInstance().showProd());
        allHomeProds.add(ProductService.getInstance().showProd());
        allHomeProds.add(ProductService.getInstance().getAccessory());
        return allHomeProds;
    }

    public String getFormattedUnitPrice(Products product) {
        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));
        return currencyFormat.format(product.getUnitPrice() * 1000);
    }

    public static void main(String[] args) {
        System.out.println(ProductService.getInstance().showProd()
        );

    }


}
