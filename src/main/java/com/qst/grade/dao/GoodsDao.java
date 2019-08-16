package com.qst.grade.dao;

import com.qst.grade.po.Goods;

import javax.persistence.criteria.CriteriaBuilder;
import java.util.List;

public interface GoodsDao {

    /**
     * 添加商品
     * **/
    public String addGoods(Goods goods);
    /**
     * 按Gid查找商品
     */


    public Goods findGoodsByGid(String gid);

    /**
     *
     * @param 类型Id
     * @return 返回是否有该类型的商品记录（goods|null）
     */
    public List<Goods> findBytypeid(String typeid);

    /**
     * 通过商品id修改商品数量
     * @param gid gid
     * @param count 库存数量
     * @return 修改个数
     */
    Integer updateCountByGid(String gid, int count);


    /**
     * 通过uid查找商品
     */
    public List<Goods>  findGoodsByUid(String uid, Integer pageCode,int pageSize);

    /**
     * 通过gid改变商品的状态
     */
    public Integer makeGoodsStatusToRemoveShelf(String gid);

    public Integer makeGoodsStatusToOnShelf(String gid);

    public Integer makeGoodsStatusToDelete(String gid);
    int count(String uid);

    /**
     * 使gid对应goods的点击量+1
     * @param gid 商品id
     */
    void addGoodsHit(String gid);

    public void updateMyGoods(Goods goods);

    public int countOnOrDownShelfGoodsNum(String uid,int status);

    Integer getTotalCount();

    List<Goods> findAllByPageAndOffset(Integer page, Integer offset);

}
