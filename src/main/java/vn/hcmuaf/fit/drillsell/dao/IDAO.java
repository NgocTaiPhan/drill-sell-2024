package vn.hcmuaf.fit.drillsell.dao;

import java.util.List;

public interface IDAO<T> {

public int insert( T t );
public int update( T t );
public int delete( T t );


}
