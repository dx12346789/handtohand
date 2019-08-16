package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.*;
import com.qst.grade.service.*;
import com.qst.grade.util.PinYinUtil;
import com.qst.grade.util.UUID;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.net.ssl.SSLSocket;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class GoodsAction {
    private String gid;
    private int count;
    private Goods goods;
    private Category category;
    private Comment comment;
    private User user;
    private Address address;
    private Favorite favorite;
    private final GoodsService goodsService;
    private CategoryService categoryService;
    private CommentService commentService;
    private UserService userService;
    private AddressService addressService;
    private FavoriteService favoriteService;
    private List<Category> categoryList;
    private List<File> upload;
    private List<String> uploadFileName;
    private List<Comment> commentList;
    private List<User> userList;

    @Autowired
    public GoodsAction(GoodsService goodsService, CategoryService categoryService,
                       CommentService commentService, UserService userService, AddressService addressService, FavoriteService favoriteService) {
        this.categoryService = categoryService;
        this.goodsService = goodsService;
        this.commentService = commentService;
        this.userService = userService;
        this.addressService = addressService;
        this.favoriteService = favoriteService;
    }

    public String findGoodsByGid() {
        Map session = ActionContext.getContext().getSession();
        User user1 = (User) session.get("loginUser");
        goods = goodsService.findGoodsByGid(gid);

        category = categoryService.findCategoryByCid(goods.getCid());
        commentList = commentService.findByGid(goods.getGid());
        count = commentService.count(goods.getGid());
        System.err.println("count=" + count);
        user = userService.findByuId(goods.getUid());
//        address = addressService.findByUid(goods.getUid());
        userList = userService.findAll();
        if (user1 != null) {
            favorite = favoriteService.findByGidUid(goods.getGid(), user1.getUid());
            goodsService.judgeHit(gid, user1);
        }
        for (int i = 0; i < commentList.size(); i++) {
            Comment comment = commentList.get(i);
            for (int j = 0; j < userList.size(); j++) {
                User u = userList.get(j);
                if (comment.getAnonymous() == 1 && (comment.getCommentator()).equals(u.getUid())) {
                    StringBuilder str = new StringBuilder(16);
                    String name = u.getNickname();
                    str.append(name.charAt(0));
                    str.append("***");
                    str.append(name.charAt(name.length() - 1));
                    u.setNickname(str.toString());
                }
            }
        }
        return "togoods";
    }

    public String toIssue() {
        categoryList = new ArrayList<Category>();
        categoryList = categoryService.findAllCategory();
        System.out.println(categoryList);
        return "success";
    }

    /**
     * 查找出商品所有信息
     *
     * @return
     */
    public String addGoods() throws IOException {
        System.out.println("商品名称：" + goods.getName());
        System.out.println("商品详情：" + goods.getDetail());
        System.out.println("商品个数：" + goods.getCount());
        System.out.println("商品价格：" + goods.getPrice());
        //图片处理
        String path = ServletActionContext.getServletContext().getRealPath("/upload");
        System.out.println("path:" + path);

        File file = new File(path);
        if (!file.exists()) {
            file.mkdir();
        }

        String img = "";
        for (int i = 0; i < uploadFileName.size(); i++) {

            String file2 = new File(file, uploadFileName.get(i)).toString();
            System.out.println("上传的图片名：" + uploadFileName.get(i));
            System.out.println("路径：" + file2);
            file2 = file2.substring(file2.lastIndexOf("."));
            String path1 = new Date(System.currentTimeMillis()).getTime() + file2;
            FileUtils.copyFile(upload.get(i), new File(file,path1));
            file.delete();
            System.out.println("存入数据库路径：" + path1);
            img += "upload/" + path1 + ",";
        }
        goods.setImgPath(img);
        System.out.println("商品图片：" + goods.getImgPath());

        System.out.println("商品类型：" + goods.getCid());
        goods.setStatus(0);
        String gid = "G" + UUID.getUUID(32);
        goods.setGid(gid);
        System.out.println("商品id：" + goods.getGid());

        String name = goods.getName();
        String acronym = PinYinUtil.getAcronym(name);
        goods.setAcronym(acronym);
        System.out.println("商品首字母：" + goods.getAcronym());

        String fullPinyin = PinYinUtil.getFullPinYinWithoutNumber(name);
        goods.setFullpinyin(fullPinyin);
        System.out.println("商品全拼音：" + goods.getFullpinyin());
        User user1 = (User) ActionContext.getContext().getSession().get("loginUser");
        goods.setUid(user1.getUid());
        goods.setHit(0);
        //添加入数据库
        String id = goodsService.addGoods(goods);
        if (id == null) {
            return "error";
        } else {
            return "success";
        }

    }

    public String getGid() {
        return gid;
    }

    public void setGid(String gid) {
        this.gid = gid;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public List<Category> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<Category> categoryList) {
        this.categoryList = categoryList;
    }

    public List<Comment> getCommentList() {
        return commentList;
    }

    public void setCommentList(List<Comment> commentList) {
        this.commentList = commentList;
    }

    public List<User> getUserList() {
        return userList;
    }

    public void setUserList(List<User> userList) {
        this.userList = userList;
    }

    public List<File> getUpload() {
        return upload;
    }

    public void setUpload(List<File> upload) {
        this.upload = upload;
    }

    public List<String> getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(List<String> uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public Favorite getFavorite() {
        return favorite;
    }

    public void setFavorite(Favorite favorite) {
        this.favorite = favorite;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }
}
