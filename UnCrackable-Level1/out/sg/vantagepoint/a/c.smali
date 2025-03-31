.class public Lsg/vantagepoint/a/c;
.super Ljava/lang/Object;


# direct methods
.method public static a()Z
    .registers 7

    const-string v0, "PATH"

    invoke-static {v0}, Ljava/lang/System;->getenv(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, ":"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_f
    if-ge v3, v1, :cond_25

    aget-object v4, v0, v3

    new-instance v5, Ljava/io/File;

    const-string v6, "su"

    invoke-direct {v5, v4, v6}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_22

    const/4 v0, 0x1

    return v0

    :cond_22
    add-int/lit8 v3, v3, 0x1

    goto :goto_f

    :cond_25
    return v2
.end method

.method public static b()Z
    .registers 2

    sget-object v0, Landroid/os/Build;->TAGS:Ljava/lang/String;

    if-eqz v0, :cond_e

    const-string v1, "test-keys"

    invoke-virtual {v0, v1}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_e

    const/4 v0, 0x1

    return v0

    :cond_e
    const/4 v0, 0x0

    return v0
.end method

.method public static c()Z
    .registers 7

    const-string v0, "/system/app/Superuser.apk"

    const-string v1, "/system/xbin/daemonsu"

    const-string v2, "/system/etc/init.d/99SuperSUDaemon"

    const-string v3, "/system/bin/.ext/.su"

    const-string v4, "/system/etc/.has_su_daemon"

    const-string v5, "/system/etc/.installed_su_daemon"

    const-string v6, "/dev/com.koushikdutta.superuser.daemon/"

    filled-new-array/range {v0 .. v6}, [Ljava/lang/String;

    move-result-object v0

    array-length v1, v0

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_15
    if-ge v3, v1, :cond_29

    aget-object v4, v0, v3

    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_26

    const/4 v0, 0x1

    return v0

    :cond_26
    add-int/lit8 v3, v3, 0x1

    goto :goto_15

    :cond_29
    return v2
.end method
