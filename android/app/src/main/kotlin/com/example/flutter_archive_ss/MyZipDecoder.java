package com.example.flutter_archive_ss;

import androidx.annotation.NonNull;

import net.lingala.zip4j.ZipFile;
import net.lingala.zip4j.exception.ZipException;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;


public class MyZipDecoder extends FlutterActivity {

    private static MethodChannel methodChannel;

    ObservableInteger obsInt = new ObservableInteger();

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), "my_zip_decoder");

        methodChannel.setMethodCallHandler(((call, result) -> {
            if ("unzip".equals(call.method)) {
                Log.d("MyZipDecoder", "Starting...");
                String zipPath = call.argument("zipPath");
                String extractPath = call.argument("extractPath");

                if (zipPath != null){
                    ZipFile zipFile = new ZipFile(zipPath);
                    zipFile.setRunInThread(true);

                    try {
                        assert extractPath != null;
                        zipFile.extractAll(extractPath);
                    } catch (ZipException e) {
                        e.printStackTrace();
                    }
                }
                result.success(true);

            } else {
                result.notImplemented();
            }
        }));
    }

    public interface OnIntegerChangeListener
    {
        public void onIntegerChanged(int newValue);
    }

    public static class ObservableInteger
    {
        private OnIntegerChangeListener listener;

        private int value;

        public void setOnIntegerChangeListener(OnIntegerChangeListener listener)
        {
            this.listener = listener;
            value = -1;
        }

        public int get()
        {
            return value;
        }

        public void set(int value)
        {
            this.value = value;

            if(listener != null)
            {
                listener.onIntegerChanged(value);
            }
        }
    }
}


