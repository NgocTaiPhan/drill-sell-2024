package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.db.DbConnector;

import java.util.List;

public class ProducerDAO {
    private static ProducerDAO instance;

    public ProducerDAO() {
    }

    public static ProducerDAO getInstance() {
        if (instance == null) {
            instance = new ProducerDAO();
        }
        return instance;
    }

    public List<String> getAllProducers() {
        return DbConnector.me().get().withHandle(handle ->
                handle.createQuery("SELECT DISTINCT nameProducer FROM products")
                        .mapTo(String.class)
                        .list());
    }
}
