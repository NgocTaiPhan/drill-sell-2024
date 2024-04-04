package vn.hcmuaf.fit.drillsell.dao;

import vn.hcmuaf.fit.drillsell.model.IModel;

public abstract class AbsDAO<T extends IModel> implements IDAO<T> {
    @Override
    public int insert(T t) {
        Logging.insert(t);
        return 0;
    }

    @Override
    public int update(T t) {
        return 0;
    }

    @Override
    public int delete(T t) {
        return 0;
    }
}
