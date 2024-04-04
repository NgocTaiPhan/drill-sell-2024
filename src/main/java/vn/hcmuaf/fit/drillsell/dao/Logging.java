package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.IModel;

public class Logging {
    public static void update(IModel model) {
        System.out.println();
    }

    public static void insert(IModel model) {
        System.out.println("{'action': 'insert', 'model':'before': ' "+ model.getBeforeData()+"','after': '"+model.getAfterData()+ "'}");
    }

    public static void delete(IModel model) {
        System.out.println();
    }


}
