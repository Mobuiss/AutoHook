package sg.vantagepoint.a;

import android.content.Context;

/* loaded from: C:\Users\31541\Desktop\CS\software\download\UnCrackable-Level1\out.dex */
public class b {
    public static boolean a(Context context) {
        return (context.getApplicationContext().getApplicationInfo().flags & 2) != 0;
    }
}