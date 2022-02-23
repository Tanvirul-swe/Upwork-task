package com.cashful.deviceinformation.device;

import android.content.Context;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.cashful.devicemetadata.device.BatteryInformation;
import com.cashful.devicemetadata.device.CameraInformation;
import com.cashful.devicemetadata.device.ClientData;
import com.cashful.devicemetadata.device.DeviceInformation;
import com.cashful.devicemetadata.device.DisplayInformation;
import com.cashful.devicemetadata.device.MemoryInformation;
import com.cashful.devicemetadata.device.SystemInformation;

import java.util.ArrayList;

public class DeviceDataActivity extends AppCompatActivity {

    private RecyclerView rv_device_data_logs;
    private DeviceDataAdapter deviceDataAdapter;
    private ArrayList<DeviceData> deviceDataArrayList = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        initUi();

        ClientData clientData = getDeviceInfo(this);

        deviceDataArrayList.add(new DeviceData("Device ID: ", clientData.getDeviceId()));
        deviceDataArrayList.add(new DeviceData("Device Name: ", clientData.getDeviceName()));
        deviceDataArrayList.add(new DeviceData("Device Type: ", clientData.getDeviceType()));
        deviceDataArrayList.add(new DeviceData("Device Brand Name: ", clientData.getDeviceBrandName()));
        deviceDataArrayList.add(new DeviceData("Device Board Name: ", clientData.getDeviceBoardName()));
        deviceDataArrayList.add(new DeviceData("Device Display Version: ", clientData.getDeviceDisplayVersion()));
        deviceDataArrayList.add(new DeviceData("Device Manufacturer Name: ", clientData.getDeviceManufacturerName()));
        deviceDataArrayList.add(new DeviceData("Device Device Is Rooted: ", clientData.isDeviceIsRooted()));
        deviceDataArrayList.add(new DeviceData("Device Has NFC: ", clientData.isDeviceHasNfc()));
        deviceDataArrayList.add(new DeviceData("Device Is Enabled Nfc: ", clientData.isDeviceIsEnabledNfc()));

        deviceDataArrayList.add(new DeviceData("Display Height: ", clientData.getDisplayHeight()));
        deviceDataArrayList.add(new DeviceData("Display Weight: ", clientData.getDisplayWeight()));
        deviceDataArrayList.add(new DeviceData("Display Orientation: ", clientData.getDisplayOrientation()));
        deviceDataArrayList.add(new DeviceData("Display Rotation: ", clientData.getDisplayRotation()));
        deviceDataArrayList.add(new DeviceData("Display Physical Size: ", clientData.getDisplayPhysicalSize()));

        deviceDataArrayList.add(new DeviceData("Battery Capacity", clientData.getBatteryCapacity()));
        deviceDataArrayList.add(new DeviceData("Battery Voltage", clientData.getBatteryVoltage()));
        deviceDataArrayList.add(new DeviceData("Battery Percentage", clientData.getBatteryPercentage()));
        deviceDataArrayList.add(new DeviceData("Battery Health", clientData.getBatteryHealth()));
        deviceDataArrayList.add(new DeviceData("Battery Is Available", clientData.isBatteryIsAvailable()));
        deviceDataArrayList.add(new DeviceData("Battery Is Charging", clientData.isBatteryIsCharging()));

        deviceDataArrayList.add(new DeviceData("System Api Level", clientData.getSystemApiLevel()));
        deviceDataArrayList.add(new DeviceData("System Language", clientData.getSystemLanguage()));
        deviceDataArrayList.add(new DeviceData("System Language Tag", clientData.getSystemLanguageTag()));
        deviceDataArrayList.add(new DeviceData("System Display Language", clientData.getSystemDisplayLanguage()));
        deviceDataArrayList.add(new DeviceData("System Display Country", clientData.getSystemDisplayCountry()));

        deviceDataArrayList.add(new DeviceData("Memory Total RAM", clientData.getMemoryTotalRAM()));
        deviceDataArrayList.add(new DeviceData("Memory Used RAM", clientData.getMemoryUsedRAM()));
        deviceDataArrayList.add(new DeviceData("Memory Available RAM", clientData.getMemoryAvailableRAM()));

        deviceDataArrayList.add(new DeviceData("Camera Is Available", clientData.isCameraIsAvailable()));
        deviceDataArrayList.add(new DeviceData("Camera Is Flash Available", clientData.isCameraIsFlashAvailable()));
        deviceDataArrayList.add(new DeviceData("Camera Number Of Cameras", clientData.getCameraNumberOfCameras()));


        deviceDataAdapter = new DeviceDataAdapter(this, deviceDataArrayList);
        rv_device_data_logs.setAdapter(deviceDataAdapter);
    }

    public static ClientData getDeviceInfo(Context context) {
        ClientData clientData = new ClientData();

        try {
            // DEVICE GENERAL INFORMATION
            DeviceInformation deviceInformation = new DeviceInformation(context);
            clientData.setDeviceId(deviceInformation.getDeviceId());
            clientData.setDeviceName(deviceInformation.getDeviceName());
            clientData.setDeviceType(deviceInformation.getDeviceType());
            clientData.setDeviceIsRooted(deviceInformation.isRooted());
            clientData.setDeviceManufacturerName(deviceInformation.getManafacturerName());
            clientData.setDeviceBoardName(deviceInformation.getBoardName());
            clientData.setDeviceBrandName(deviceInformation.getBrandName());
            clientData.setDeviceDisplayVersion(deviceInformation.getDisplayVersion());
            clientData.setDeviceModelName(deviceInformation.getModelName());
            clientData.setDeviceHasNfc(deviceInformation.hasNfc());
            clientData.setDeviceIsEnabledNfc(deviceInformation.enabledNfc());

            // DISPLAY INFORMATION
            DisplayInformation displayInformation = new DisplayInformation(context);
            clientData.setDisplayHeight(displayInformation.getDisplayHeight());
            clientData.setDisplayWeight(displayInformation.getDisplayWidth());
            clientData.setDisplayPhysicalSize(displayInformation.getPhysicalSize());
            clientData.setDisplayRotation(displayInformation.getRotation());
            clientData.setDisplayOrientation(displayInformation.getOrientation());

            // BATTERY INFORMATION
            BatteryInformation batteryInformation = new BatteryInformation(context);
            clientData.setBatteryHealth(batteryInformation.getHealth());
            clientData.setBatteryCapacity(batteryInformation.getBatteryCapacity());
            clientData.setBatteryIsAvailable(batteryInformation.isBatteryAvailable());
            clientData.setBatteryIsCharging(batteryInformation.isCharging());
            clientData.setBatteryVoltage(batteryInformation.getBatteryVoltage());
            clientData.setBatteryPercentage(batteryInformation.getPercentage());

            // SYSTEM INFORMATION
            SystemInformation systemInformation = new SystemInformation(context);
            clientData.setSystemApiLevel(systemInformation.getApiLevel());
            clientData.setSystemDisplayCountry(systemInformation.getDisplayCountry());
            clientData.setSystemLanguage(systemInformation.getLanguage());
            clientData.setSystemLanguageTag(systemInformation.getLanguageTag());
            clientData.setSystemDisplayLanguage(systemInformation.getDisplayLanguage());

            // MEMORY INFORMATION
            MemoryInformation memoryInformation = new MemoryInformation(context);
            clientData.setMemoryTotalRAM(memoryInformation.getTotalRam());
            clientData.setMemoryAvailableRAM(memoryInformation.getAvailableRam());
            clientData.setMemoryUsedRAM(memoryInformation.getUsedRam());

            // CAMERA INFORMATION
            CameraInformation cameraInformation = new CameraInformation(context);
            clientData.setCameraIsAvailable(cameraInformation.isCameraAvailable());
            clientData.setCameraIsFlashAvailable(cameraInformation.isFlashAvailable());
            clientData.setCameraNumberOfCameras(cameraInformation.getNumberOfCameras());

            // LOCATION INFORMATION
        /*LocationInformation locationInformation = null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            locationInformation = new LocationInformation(context);
            if (locationInformation.getLocation() != null) {
                deviceData.setLocationLatitude(locationInformation.getLocation().getLongitude());
                deviceData.setLocationLatitude(locationInformation.getLocation().getLatitude());
            }
        }*/
        } catch (IllegalStateException | NullPointerException | IndexOutOfBoundsException e) {
            e.printStackTrace();
        }

        return clientData;
    }

    private void initUi() {
        rv_device_data_logs.setHasFixedSize(true);
        rv_device_data_logs.setLayoutManager(new LinearLayoutManager(this));
    }

}