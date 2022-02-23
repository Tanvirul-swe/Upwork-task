package com.cashful.deviceinformation.sms;

import android.content.Context;
import android.content.res.Resources;
import android.util.TypedValue;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.cashful.devicemetadata.sms.SmsData;

import java.util.ArrayList;

public class SmsLogAdapter extends RecyclerView.Adapter<SmsLogAdapter.MyViewHolder> {
    private int px;
    Context context;
    ArrayList<SmsData> smsLogModelArrayList;

    public SmsLogAdapter(Context context, ArrayList<SmsData> smsLogModelArrayList) {
        this.context = context;
        this.smsLogModelArrayList = smsLogModelArrayList;
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
        SmsData currentLog = smsLogModelArrayList.get(position);
        try {
            holder.tv_address.setText(currentLog.getAddress().substring(0, 4) + "***** (hidden for demo)");
            holder.tv_message.setText(currentLog.getMessage().substring(0, 10) + "***** (hidden for demo)");
        } catch (StringIndexOutOfBoundsException e) {
            holder.tv_address.setText(currentLog.getAddress().substring(0, 2) + "***** (hidden for demo)");
            holder.tv_message.setText("***** (hidden for demo)");
        }
        holder.tv_read_state.setText(currentLog.getReadState());
        holder.tv_sms_time.setText(currentLog.getTime());
        holder.tv_folder_name.setText(currentLog.getFolderName());
    }

    @Override
    public int getItemCount() {
        return smsLogModelArrayList == null ? 0 : smsLogModelArrayList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        CardView cardView;
        TextView tv_address, tv_message, tv_read_state, tv_sms_time, tv_folder_name;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);

        }
    }
}