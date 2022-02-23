package com.cashful.deviceinformation;



import android.Manifest;
import android.app.AppOpsManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.provider.Settings;
import android.view.View;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.cashful.deviceinformation.apps.InstalledAppDataActivity;
import com.cashful.deviceinformation.call.CallActivity;
import com.cashful.deviceinformation.datausages.DataUsagesActivity;
import com.cashful.deviceinformation.device.DeviceDataActivity;
import com.cashful.deviceinformation.location.LocationActivity;
import com.cashful.deviceinformation.sms.SmsActivity;
import com.cashful.devicemetadata.apps.AppData;
import com.cashful.devicemetadata.apps.InstalledAppInformation;
import com.cashful.devicemetadata.call.CallData;
import com.cashful.devicemetadata.call.CallInformation;
import com.cashful.devicemetadata.datausages.DataUsagesData;
import com.cashful.devicemetadata.datausages.DataUsagesInformation;
import com.cashful.devicemetadata.device.BatteryInformation;
import com.cashful.devicemetadata.device.CameraInformation;
import com.cashful.devicemetadata.device.ClientData;
import com.cashful.devicemetadata.device.DeviceInformation;
import com.cashful.devicemetadata.device.DisplayInformation;
import com.cashful.devicemetadata.device.MemoryInformation;
import com.cashful.devicemetadata.device.SystemInformation;
import com.cashful.devicemetadata.location.LocationInformation;
import com.cashful.devicemetadata.sms.SmsData;
import com.cashful.devicemetadata.sms.SmsInformation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.cashful.deviceinformation/userdata";
    private static final int PERMISSIONS_REQUEST_CODE = 2;
    private static final int PERMISSIONS_REQUEST_CODE1 = 3;

    private static final int PERMISSIONS_REQUEST_CODE2 = 2;

    String[] appPermissions2 = {Manifest.permission.READ_SMS};

    String[] appPermissions = {
            Manifest.permission.READ_CALL_LOG,
            Manifest.permission.PROCESS_OUTGOING_CALLS,
            Manifest.permission.READ_PHONE_STATE
    };

    String[] appPermissions1 = {
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION
    };
    public boolean CheckAndRequestPermission() {
        //checking which permissions are granted
        List<String> listPermissionNeeded = new ArrayList<>();
        for (String item : appPermissions) {
            if (ContextCompat.checkSelfPermission(this, item) != PackageManager.PERMISSION_GRANTED)
                listPermissionNeeded.add(item);
        }

        //Ask for non-granted permissions
        if (!listPermissionNeeded.isEmpty()) {
            ActivityCompat.requestPermissions(this, listPermissionNeeded.toArray(new String[listPermissionNeeded.size()]),
                    PERMISSIONS_REQUEST_CODE);
            return false;
        }
        //App has all permissions. Proceed ahead
        return true;
    }

    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    private boolean checkUserStatePermission() {
        AppOpsManager appOps = (AppOpsManager)
                getSystemService(Context.APP_OPS_SERVICE);
        int mode = appOps.checkOpNoThrow("android:get_usage_stats",
                android.os.Process.myUid(), getPackageName());
        return mode != AppOpsManager.MODE_ALLOWED;
    }

    public boolean CheckAndRequestPermission1() {
        //checking which permissions are granted
        List<String> listPermissionNeeded = new ArrayList<>();
        for (String item : appPermissions1) {
            if (ContextCompat.checkSelfPermission(this, item) != PackageManager.PERMISSION_GRANTED)
                listPermissionNeeded.add(item);
        }

        //Ask for non-granted permissions
        if (!listPermissionNeeded.isEmpty()) {
            ActivityCompat.requestPermissions(this, listPermissionNeeded.toArray(new String[listPermissionNeeded.size()]),
                    PERMISSIONS_REQUEST_CODE1);
            return false;
        }
        //App has all permissions. Proceed ahead
        return true;
    }

    public boolean CheckAndRequestPermission2() {
        //checking which permissions are granted
        List<String> listPermissionNeeded = new ArrayList<>();
        for (String item : appPermissions2) {
            if (ContextCompat.checkSelfPermission(this, item) != PackageManager.PERMISSION_GRANTED)
                listPermissionNeeded.add(item);
        }

        //Ask for non-granted permissions
        if (!listPermissionNeeded.isEmpty()) {
            ActivityCompat.requestPermissions(this, listPermissionNeeded.toArray(new String[listPermissionNeeded.size()]),
                    PERMISSIONS_REQUEST_CODE2);
            return false;
        }
        //App has all permissions. Proceed ahead
        return true;
    }

    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1) {
            if (checkUserStatePermission()) {
                Toast.makeText(this, "permission denied", Toast.LENGTH_SHORT).show();
                finish();
            } else {
                getDataUsageData();
            }

        }
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

    public  ArrayList<HashMap>  getCallData() {
        CallInformation callInformation = null;

        ArrayList<HashMap> arrayMap = new ArrayList();
        if (CheckAndRequestPermission()) {
            callInformation = new CallInformation(this);
            ArrayList<CallData> result = callInformation.getAllCalls();
            for(int i=0;i<result.size();i++) {
                HashMap map = new HashMap();
                map.put("date",result.get(i).getCallDate());
                map.put("time",result.get(i).getCallTime());
                map.put("duration",result.get(i).getCallDuration());
                map.put("type",result.get(i).getCallType());
                map.put("contact_name",result.get(i).getContactName());
                map.put("address",result.get(i).getAddress());
                arrayMap.add(map);
            }

        }
        return  arrayMap;

    }
    public  ArrayList<HashMap>  getDataUsageData() {
        ArrayList<HashMap> result = new ArrayList<>();
        if (checkUserStatePermission()) {
            startActivityForResult(new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS), 1);

        } else {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_PHONE_STATE
                }, 2);
            }
            else {
                DataUsagesInformation dataUsagesInformation = new DataUsagesInformation(this);
                DataUsagesData dataUsagesData = dataUsagesInformation.getInternetUsage(1642694075000L);

                HashMap downWifi = new HashMap();
                downWifi.put("'downWifi'", dataUsagesData.getWifiDataDownload() / (1024f * 1024f) + " MB");
                downWifi.put("'upWifi'", dataUsagesData.getWifiDataUpload() / (1024f * 1024f) + " MB");
                downWifi.put("'downMobi'", dataUsagesData.getMobileDataDownload() / (1024f * 1024f) + " MB");
                downWifi.put("'upMobi'", dataUsagesData.getMobileDataUpload() / (1024f * 1024f) + " MB");
                result.add(downWifi);
                return result;
            }
        }
        return result;
    }
    public  ArrayList<HashMap>  getAppInstalls() {
        ArrayList<AppData> installedAppData;
        InstalledAppInformation installedAppInformation = new InstalledAppInformation(this);
        installedAppData = installedAppInformation.getInstalledApps();
        ArrayList<HashMap> arrayMap = new ArrayList();
        for(int i=0;i<installedAppData.size();i++) {
            HashMap map = new HashMap();
            map.put("appName",installedAppData.get(i).getAppName());
            map.put("packageName",installedAppData.get(i).getPackageName());
            map.put("version",installedAppData.get(i).getVersion());
            arrayMap.add(map);
        }
        return  arrayMap;
    }
    public  ArrayList<HashMap>  getDevice() {
        HashMap deviceDataArrayList = new HashMap();
        ArrayList<HashMap> result = new ArrayList<>();
        ClientData clientData = getDeviceInfo(this);

        deviceDataArrayList.put("Device ID: ", clientData.getDeviceId());
        deviceDataArrayList.put("Device Name: ", clientData.getDeviceName());
        deviceDataArrayList.put("Device Type: ", clientData.getDeviceType());
        deviceDataArrayList.put("Device Brand Name: ", clientData.getDeviceBrandName());
        deviceDataArrayList.put("Device Board Name: ", clientData.getDeviceBoardName());
        deviceDataArrayList.put("Device Display Version: ", clientData.getDeviceDisplayVersion());
        deviceDataArrayList.put("Device Manufacturer Name: ", clientData.getDeviceManufacturerName());
        deviceDataArrayList.put("Device Device Is Rooted: ", clientData.isDeviceIsRooted());
        deviceDataArrayList.put("Device Has NFC: ", clientData.isDeviceHasNfc());
        deviceDataArrayList.put("Device Is Enabled Nfc: ", clientData.isDeviceIsEnabledNfc());

        deviceDataArrayList.put("Display Height: ", clientData.getDisplayHeight());
        deviceDataArrayList.put("Display Weight: ", clientData.getDisplayWeight());
        deviceDataArrayList.put("Display Orientation: ", clientData.getDisplayOrientation());
        deviceDataArrayList.put("Display Rotation: ", clientData.getDisplayRotation());
        deviceDataArrayList.put("Display Physical Size: ", clientData.getDisplayPhysicalSize());

        deviceDataArrayList.put("Battery Capacity", clientData.getBatteryCapacity());
        deviceDataArrayList.put("Battery Voltage", clientData.getBatteryVoltage());
        deviceDataArrayList.put("Battery Percentage", clientData.getBatteryPercentage());
        deviceDataArrayList.put("Battery Health", clientData.getBatteryHealth());
        deviceDataArrayList.put("Battery Is Available", clientData.isBatteryIsAvailable());
        deviceDataArrayList.put("Battery Is Charging", clientData.isBatteryIsCharging());

        deviceDataArrayList.put("System Api Level", clientData.getSystemApiLevel());
        deviceDataArrayList.put("System Language", clientData.getSystemLanguage());
        deviceDataArrayList.put("System Language Tag", clientData.getSystemLanguageTag());
        deviceDataArrayList.put("System Display Language", clientData.getSystemDisplayLanguage());
        deviceDataArrayList.put("System Display Country", clientData.getSystemDisplayCountry());

        deviceDataArrayList.put("Memory Total RAM", clientData.getMemoryTotalRAM());
        deviceDataArrayList.put("Memory Used RAM", clientData.getMemoryUsedRAM());
        deviceDataArrayList.put("Memory Available RAM", clientData.getMemoryAvailableRAM());

        deviceDataArrayList.put("Camera Is Available", clientData.isCameraIsAvailable());
        deviceDataArrayList.put("Camera Is Flash Available", clientData.isCameraIsFlashAvailable());
        deviceDataArrayList.put("Camera Number Of Cameras", clientData.getCameraNumberOfCameras());
        result.add(deviceDataArrayList);
        return result;
    }
    private ArrayList<HashMap>  getLocationData() {
        ArrayList<HashMap> result = null;
        if (CheckAndRequestPermission1()) {
            LocationInformation locationInformation = null;

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                locationInformation = new LocationInformation(this);
                HashMap deviceDataArrayList = new HashMap();
                deviceDataArrayList.put("lat",locationInformation.getLocation().getLatitude());
                deviceDataArrayList.put("long",locationInformation.getLocation().getLongitude());
                result = new ArrayList<>();
                result.add(deviceDataArrayList);
                return  result;
            }
        }

        return  result;
    }
    public  ArrayList<HashMap> getSMS() {
        ArrayList<HashMap> arrayMap = new ArrayList();
        if (CheckAndRequestPermission2()) {
            SmsInformation smsInformation = new SmsInformation(this);
            ArrayList<SmsData> sms = smsInformation.getAllSms();

            for(int i=0;i<sms.size();i++) {
                HashMap map = new HashMap();
                map.put("address",sms.get(i).getAddress());
                map.put("time",sms.get(i).getTime());
                map.put("folderName",sms.get(i).getFolderName());
                map.put("id",sms.get(i).getId());
                map.put("message",sms.get(i).getMessage());
                map.put("readState",sms.get(i).getReadState());
                arrayMap.add(map);
            }
        }


        return  arrayMap;

    }
    

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (PERMISSIONS_REQUEST_CODE == requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getCallData();
            } else {
                Toast.makeText(getApplicationContext(), "Permission Denied", Toast.LENGTH_SHORT).show();
            }
        }
        if (PERMISSIONS_REQUEST_CODE1 == requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getLocationData();
            } else {
                Toast.makeText(getApplicationContext(), "Permission Denied", Toast.LENGTH_SHORT).show();
            }
        }
        if (PERMISSIONS_REQUEST_CODE2 == requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getCallData();
            } else {
                Toast.makeText(getApplicationContext(), "Permission Denied", Toast.LENGTH_SHORT).show();
            }
        }
    }

        @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
                GeneratedPluginRegistrant.registerWith(flutterEngine);
                new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                        .setMethodCallHandler((call, result) -> {
                            if (call.method.equals("getCallLog")) {
                                if (CheckAndRequestPermission()) {
                                    result.success(getCallData());
                                }
                            }
                            else if (call.method.equals("appInstall")) {
                                result.success(getAppInstalls());
                            }
                            else if (call.method.equals("dataUsage")) {
                                if (checkUserStatePermission()) {
                                    startActivityForResult(new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS), 1);

                                } else {
                                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED

                                    ) {
                                        ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_PHONE_STATE
                                        }, 2);
                                    } else {
                                        result.success(getDataUsageData());
                                    };
                                }
                            }
                            else if (call.method.equals("device")) {
                                result.success(getDevice());
                            }
                            else if (call.method.equals("location")) {
                                result.success(getLocationData());
                            }
                            else if (call.method.equals("sms")) {
                                result.success(getSMS());
                            }
                        }); }


    public void getCallLogs() {
            //CallActivity callActivity = new CallActivity();
            startActivity(new Intent(this, CallActivity.class));
            //callActivity.getCallData();
    }

    public void getSmsLogs(View view) {
        startActivity(new Intent(this, SmsActivity.class));
    }

    public void getDeviceData(View view) {
        startActivity(new Intent(this, DeviceDataActivity.class));
    }

    public void getLastLocation(View view) {
        startActivity(new Intent(this, LocationActivity.class));
    }

    public void getInstalledAppData(View view) {
        startActivity(new Intent(this, InstalledAppDataActivity.class));
    }

    public void getDataUsagesWeekly(View view) {
        startActivity(new Intent(this, DataUsagesActivity.class));
    }
}