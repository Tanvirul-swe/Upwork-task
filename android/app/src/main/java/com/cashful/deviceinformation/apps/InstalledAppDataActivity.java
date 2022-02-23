package com.cashful.deviceinformation.apps;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.cashful.devicemetadata.apps.AppData;
import com.cashful.devicemetadata.apps.InstalledAppInformation;

import java.util.ArrayList;

public class InstalledAppDataActivity extends AppCompatActivity {

    private RecyclerView rv_installed_apps_data;
    private InstalledAppsDataAdapter installedAppsDataAdapter;
    private ArrayList<AppData> installedAppData = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        initUi();

        InstalledAppInformation installedAppInformation = new InstalledAppInformation(this);
        installedAppData = installedAppInformation.getInstalledApps();

        installedAppsDataAdapter = new InstalledAppsDataAdapter(this, installedAppData);
        rv_installed_apps_data.setAdapter(installedAppsDataAdapter);
    }

    private void initUi() {
        rv_installed_apps_data.setHasFixedSize(true);
        rv_installed_apps_data.setLayoutManager(new LinearLayoutManager(this));
    }
}