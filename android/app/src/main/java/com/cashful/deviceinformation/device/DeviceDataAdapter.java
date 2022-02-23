package com.cashful.deviceinformation.device;

import android.content.Context;
import android.content.res.Resources;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;

public class DeviceDataAdapter extends RecyclerView.Adapter<DeviceDataAdapter.MyViewHolder> {
    private int px;
    Context context;
    ArrayList<DeviceData> callLogModelArrayList;

    public DeviceDataAdapter(Context context, ArrayList<DeviceData> callLogModelArrayList) {
        this.context = context;
        this.callLogModelArrayList = callLogModelArrayList;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        Resources r = parent.getResources();
        px = Math.round(TypedValue.applyDimension(
                TypedValue.COMPLEX_UNIT_DIP, 8, r.getDisplayMetrics()));
        View v = null;
        return new MyViewHolder(v);
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {
        DeviceData currentLog = callLogModelArrayList.get(position);
        holder.tv_key.setText(currentLog.getKey());
        holder.tv_value.setText(String.valueOf(currentLog.getValue()));
    }

    @Override
    public int getItemCount() {
        return callLogModelArrayList == null ? 0 : callLogModelArrayList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        CardView cardView;
        TextView tv_key, tv_value;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);

        }
    }
}