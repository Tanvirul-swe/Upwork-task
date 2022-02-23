package com.cashful.deviceinformation.datausages;

import android.Manifest;
import android.app.AppOpsManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.cashful.devicemetadata.datausages.DataUsagesData;
import com.cashful.devicemetadata.datausages.DataUsagesInformation;

public class DataUsagesActivity extends AppCompatActivity {

    private TextView tv_mobile_data_upload;
    private TextView tv_mobile_data_download;
    private TextView tv_wifi_data_upload;
    private TextView tv_wifi_data_download;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (checkUserStatePermission()) {
            startActivityForResult(new Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS), 1);

        } else {
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) != PackageManager.PERMISSION_GRANTED

            ) {
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_PHONE_STATE
                }, 2);
            } else getInternetUsage();
        }
    }

    private void getInternetUsage() {
        DataUsagesInformation dataUsagesInformation = new DataUsagesInformation(this);
        DataUsagesData dataUsagesData = dataUsagesInformation .getInternetUsage(1642694075000L);

        tv_mobile_data_upload.setText(dataUsagesData.getMobileDataUpload() / (1024f * 1024f) + " MB");
        tv_mobile_data_download.setText(dataUsagesData.getMobileDataDownload() / (1024f * 1024f) + " MB");

        tv_wifi_data_upload.setText(dataUsagesData.getWifiDataUpload() / (1024f * 1024f) + " MB");
        tv_wifi_data_download.setText(dataUsagesData.getWifiDataDownload() / (1024f * 1024f) + " MB");
    }


    @RequiresApi(api = Build.VERSION_CODES.KITKAT)
    private boolean checkUserStatePermission() {
        AppOpsManager appOps = (AppOpsManager)
                getSystemService(Context.APP_OPS_SERVICE);
        int mode = appOps.checkOpNoThrow("android:get_usage_stats",
                android.os.Process.myUid(), getPackageName());
        return mode != AppOpsManager.MODE_ALLOWED;
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
                getInternetUsage();
            }

        }
    }

}