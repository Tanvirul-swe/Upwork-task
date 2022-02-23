package com.cashful.deviceinformation.location;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.cashful.devicemetadata.location.LocationInformation;

import java.util.ArrayList;
import java.util.List;

public class LocationActivity extends AppCompatActivity {
    private TextView tv_location_latitude, tv_location_longitude;

    String[] appPermissions1 = {
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION
    };

    private static final int PERMISSIONS_REQUEST_CODE1 = 3;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);


        if (CheckAndRequestPermission1()) {
            getLocationData();
        }
    }

    private void getLocationData() {
        // LOCATION INFORMATION
        LocationInformation locationInformation = null;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            locationInformation = new LocationInformation(this);
            if (locationInformation.getLocation() != null) {
                tv_location_latitude.setText(String.valueOf(locationInformation.getLocation().getLatitude() - 1));
                tv_location_longitude.setText(String.valueOf(locationInformation.getLocation().getLongitude() - 3));
            }
        }
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

    @RequiresApi(api = Build.VERSION_CODES.M)
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (PERMISSIONS_REQUEST_CODE1 == requestCode) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                getLocationData();
            } else {
                Toast.makeText(getApplicationContext(), " Denied", Toast.LENGTH_SHORT).show();
            }
        }
    }
}