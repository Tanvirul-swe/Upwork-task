package com.cashful.deviceinformation.device;

public class DeviceData {
    private String key;
    private Object value;

    public DeviceData(String key, Object value) {
        this.key = key;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public Object getValue() {
        return value;
    }

    public void Object(String value) {
        this.value = value;
    }
}
