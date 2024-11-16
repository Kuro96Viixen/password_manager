package com.viixenapps.passwordmanager

import android.os.Build
import android.view.WindowManager
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            // Allow screenshots when the activity is focused
            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
        } else {
            // Prevent screenshots when the activity is not focused
            window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE)
            // Request the system to hide the activity's content from the recents screen
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                this.setRecentsScreenshotEnabled(false)
            }
        }
    }
}
