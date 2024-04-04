package vn.hcmuaf.fit.drillsell.controller;


import vn.hcmuaf.fit.drillsell.model.Products;
import vn.hcmuaf.fit.drillsell.dao.ProductDAO;

import java.util.ArrayList;
import java.util.List;

public class HomeController {



    public HomeController() {


    }

    public List<List<Products>> getAllProducts() {
        List<List<Products>> allHomeProds = new ArrayList<>(); //Load tất cả sản phẩm ở home
        allHomeProds.add(ProductDAO.getInstance().showProd());
        allHomeProds.add(ProductDAO.getInstance().showProd());
        allHomeProds.add(ProductDAO.getInstance().getAccessory());
        return allHomeProds;
    }



    public static void main(String[] args) {
        System.out.println(ProductDAO.getInstance().showProd()
        );

    }


}
