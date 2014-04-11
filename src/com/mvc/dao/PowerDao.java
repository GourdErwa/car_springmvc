package com.mvc.dao;

import com.bean.Power;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by lw on 14-3-21.
 */
@Repository
public class PowerDao extends PublicDao {
    /**
     * 修改某个用户功能权限
     *
     * @param powers,userName
     * @return
     */
    public void updateUserPower(Power[] powers, String userName) {

        String sql = "DELETE FROM POWER WHERE USERNAME=?";
        Object[] objects = {userName};
        getUpdateForObjects(sql, objects);

        int temp = powers.length;

        String[] sqls = new String[temp];
        Power power;
        sql = "INSERT INTO POWER(USERNAME,FUNCTIONID) VALUES ('" + userName + "',";
        for (int i = 0; i < temp; i++) {
            power = powers[i];
            sqls[i] = sql + "'" + power.getFunctionId()
                    + "'";
        }

        getUpdateBatch(sqls);
    }

    /**
     * 查询某个功能用户权限
     *
     * @param userName
     * @return
     */
    public List getPowersForUser(String userName) {

        String sql = "SELECT  P.FUNCTIONID AS FUNCTIONID FROM POWER P LEFT JOIN FUNCTION F ON P.FUNCTION=F.FUNTION WHERE P.USERNAME=?";
        Object[] objects = {userName};
        return getListForObjects(sql, objects);
    }

}
