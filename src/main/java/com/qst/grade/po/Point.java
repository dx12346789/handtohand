package com.qst.grade.po;

public class Point {
    private String id;
    private String low;
    private String high;
    private String number;

    public Point(String low, String high, String number) {
        this.low = low;
        this.high = high;
        this.number = number;
    }

    public Point() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLow() {
        return low;
    }

    public void setLow(String low) {
        this.low = low;
    }

    public String getHigh() {
        return high;
    }

    public void setHigh(String high) {
        this.high = high;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "Point{" +
                "id='" + id + '\'' +
                ", low='" + low + '\'' +
                ", high='" + high + '\'' +
                ", number='" + number + '\'' +
                '}';
    }
}
