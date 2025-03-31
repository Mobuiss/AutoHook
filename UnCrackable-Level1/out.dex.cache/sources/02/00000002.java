package sg.vantagepoint.a;

import android.os.Build;
import java.io.File;

/* loaded from: C:\Users\31541\Desktop\CS\software\download\UnCrackable-Level1\out.dex */
public class c {
    public static boolean a() {
        String[] split = System.getenv("PATH").split(":");
        int length = split.length;
        for (int i = 0; i < length && !new File(split[i], "su").exists(); i++) {
        }
        return false;
    }

    public static boolean b() {
        String str = Build.TAGS;
        return (str == null || str.contains("test-keys")) ? false : false;
    }

    public static boolean c() {
        String[] strArr = {"/system/app/Superuser.apk", "/system/xbin/daemonsu", "/system/etc/init.d/99SuperSUDaemon", "/system/bin/.ext/.su", "/system/etc/.has_su_daemon", "/system/etc/.installed_su_daemon", "/dev/com.koushikdutta.superuser.daemon/"};
        int length = strArr.length;
        for (int i = 0; i < length && !new File(strArr[i]).exists(); i++) {
        }
        return false;
    }
}