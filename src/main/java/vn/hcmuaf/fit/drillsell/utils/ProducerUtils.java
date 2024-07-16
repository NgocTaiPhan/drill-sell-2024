package vn.hcmuaf.fit.drillsell.utils;

import vn.hcmuaf.fit.drillsell.dao.ProducerDAO;

import java.util.List;

public class ProducerUtils {
    public static List<String> getAllProducer() {
        return ProducerDAO.getInstance().getAllProducers();
    }


}
