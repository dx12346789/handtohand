package com.qst.grade.util;

import com.qst.grade.po.Point;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.Node;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;
import org.springframework.stereotype.Component;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class PointUtil {
    private String filePath = this.getClass().getClassLoader().getResource("").getPath();
    //private String filePath = "E://MyDocument/QST/myworkpaces/Transaction/src/main/java/";
    private String path = "points.xml";

    /*@Test
    public void test() throws DocumentException, IOException {
        Point point = new Point("0","200","20");
        addPoint(point);
    }*/

    /**
     * 商家积分增加
     * @param number
     * @return
     * @throws DocumentException
     * @throws IOException
     */
    private boolean addBusiness(String number) throws DocumentException, IOException {
        Document document = getDocument();
        Element element = document.getRootElement();
        element.addElement("business").addText(number);
        //<business>10</business>
        writerXML(document, path);
        return true;
    }

    /**
     * 删除商家积分规则
     * @return
     */
    private boolean delBusiness() {
        return true;
    }

    /**
     * 查找商家积分规则
     * @return
     */
    public String findBusiness() throws DocumentException {
        Document document = getDocument();
        Node node = document.selectSingleNode("//business");
        String number = node.getText();
        System.out.println(number);
        return number;
    }

    /**
     * 修改商家积分规则
     * @return
     */
    public boolean updateBusiness(String number) throws DocumentException, IOException {
        Document document = getDocument();
        Node node = document.selectSingleNode("//business");
        node.setText(number);
        writerXML(document,path);
        return true;
    }


    /**
     * 增加用户积分规则
     *
     * @param point
     * @return
     * @throws DocumentException
     * @throws IOException
     */
    public String addPoint(Point point) throws DocumentException, IOException {
        Document document = getDocument();
        Element root = document.getRootElement();
        List<Element> elements = root.elements("point");
        int id = 0;
        if(elements != null && elements.size() > 0){
            System.out.println("规则读取");
            id = Integer.parseInt(elements.get(elements.size() - 1).valueOf("@id"));
        }
        id += 1;
        System.out.println("规则id" + id);
        Element newElment = root.addElement("point").addAttribute("id", Integer.toString(id));
        newElment.addElement("low").addText(point.getLow());
        newElment.addElement("high").addText(point.getHigh());
        newElment.addElement("number").addText(point.getNumber());
        writerXML(document, path);
        return Integer.toString(id);
    }

    /**
     * 删除用户积分规则
     *
     * @param id
     * @return
     * @throws DocumentException
     * @throws IOException
     */
    public boolean delPoint(String id) throws DocumentException, IOException {
        Document document = getDocument();
        Node node = document.selectSingleNode("//point[@id='" + id + "']");
        Element element = (Element) node;
        element.detach();
        writerXML(document, path);
        return true;
    }

    /**
     * 查找用户所有积分规则
     *
     * @return
     * @throws DocumentException
     */
    public List<Point> findAll() throws DocumentException {
        List<Point> points = new ArrayList<Point>();
        Document document = getDocument();
        List<Node> nodes = document.selectNodes("//point");
        for (Node node : nodes) {
            points.add(nodeToPoint(node));
        }
        return points;
    }

    /**
     * 通过id查找用户规则
     *
     * @param id
     * @return
     * @throws DocumentException
     */
    public Point findById(String id) throws DocumentException {
        Document document = getDocument();
        Node node = document.selectSingleNode("//point[@id='" + id + "']");
        return nodeToPoint(node);
    }

    /**
     * 更新用户积分规则
     *
     * @param point
     * @return
     * @throws DocumentException
     * @throws IOException
     */
    public boolean updatePoint(Point point) throws DocumentException, IOException {
        Document document = getDocument();

        Node node = document.selectSingleNode("//point[@id='" + point.getId() + "']");
        node.selectSingleNode("low").setText(point.getLow());
        node.selectSingleNode("high").setText(point.getHigh());
        node.selectSingleNode("number").setText(point.getNumber());
        writerXML(document, path);
        return true;
    }

    /**
     * 将节点转换为point
     *
     * @param node
     * @return
     */
    private Point nodeToPoint(Node node) {
        Point point = new Point();
        point.setId(node.valueOf("@id"));
        point.setLow(node.selectSingleNode("low").getText());
        point.setHigh(node.selectSingleNode("high").getText());
        point.setNumber(node.selectSingleNode("number").getText());
        System.out.println(point);
        return point;
    }

    /**
     * 获取document
     *
     * @return
     * @throws DocumentException
     */
    private Document getDocument() throws DocumentException {
        String xmlFilePath = filePath + path;
        SAXReader reader = new SAXReader();
        Document doc = reader.read(new File(xmlFilePath));
        return doc;
    }

    /**
     * 写入xml文件
     *
     * @param doc
     * @param xmlFilePath
     * @return
     * @throws IOException
     */

    public boolean writerXML(Document doc, String xmlFilePath) throws IOException {
        XMLWriter writer;
        writer = new XMLWriter(new FileWriter(filePath + xmlFilePath));
        writer.write(doc);
        writer.close();
        return true;
    }

}
