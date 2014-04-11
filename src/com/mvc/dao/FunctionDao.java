package com.mvc.dao;


import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lw on 14-3-21.
 */
@Repository
public class FunctionDao extends PublicDao {


    public List getFunctions() {
        String sql = "SELECT FUNCTIONID,FUNCTIONNAME FROM FUNCTION";
        return getList(sql);
    }
}
