package com.cashful.deviceinformation.sms;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.cashful.devicemetadata.sms.SmsInformation;

import java.util.ArrayList;
import java.util.List;

public class SmsActivity extends AppCompatActivity {

    private RecyclerView rv_call_logs;
    private SmsLogAdapter smsLogAdapter;
    // Request code. It can be any number > 0.
    private static final int PERMISSIONS_REQUEST_CODE2 = 2;

    String[] appPermissions2 = {Manifest.permission.READ_SMS};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        initUi();
        if (CheckAndRequestPermission2()) {
            getCallData();
        }
    }

    public void getCallData() {
        SmsInformation smsInformation = new SmsInformation(this);
        smsLogAdapter = new SmsLogAdapter(this, smsInformation.getAllSms());
        rv_call_logs.setAdapter(smsLogAdapter);
    }

    private void initUi() {
        rv_call_logs.setHasFixedSize(true);
        rv_call_logs.setLayoutManager(new LinearLayoutManager(this));
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

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (PERMISSIONS_REQUEST_CODE2 == requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getCallData();
            } else {
                Toast.makeText(getApplicationContext(), "permission denied", Toast.LENGTH_SHORT).show();
            }
        }
    }
}