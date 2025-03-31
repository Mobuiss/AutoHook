.class public Lsg/vantagepoint/uncrackable1/MainActivity;
.super Landroid/app/Activity;


# direct methods
.method public constructor <init>()V
    .registers 1

    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    return-void
.end method

.method private a(Ljava/lang/String;)V
    .registers 5

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    const-string p1, "This is unacceptable. The app is now going to exit."

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    const-string p1, "OK"

    new-instance v1, Lsg/vantagepoint/uncrackable1/MainActivity$1;

    invoke-direct {v1, p0}, Lsg/vantagepoint/uncrackable1/MainActivity$1;-><init>(Lsg/vantagepoint/uncrackable1/MainActivity;)V

    const/4 v2, -0x3

    invoke-virtual {v0, v2, p1, v1}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    const/4 p1, 0x0

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setCancelable(Z)V

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method


# virtual methods
.method protected onCreate(Landroid/os/Bundle;)V
    .registers 3

    invoke-static {}, Lsg/vantagepoint/a/c;->a()Z

    move-result v0

    if-nez v0, :cond_12

    invoke-static {}, Lsg/vantagepoint/a/c;->b()Z

    move-result v0

    if-nez v0, :cond_12

    invoke-static {}, Lsg/vantagepoint/a/c;->c()Z

    move-result v0

    if-eqz v0, :cond_17

    :cond_12
    const-string v0, "Root detected!"

    invoke-direct {p0, v0}, Lsg/vantagepoint/uncrackable1/MainActivity;->a(Ljava/lang/String;)V

    :cond_17
    invoke-virtual {p0}, Lsg/vantagepoint/uncrackable1/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    invoke-static {v0}, Lsg/vantagepoint/a/b;->a(Landroid/content/Context;)Z

    move-result v0

    if-eqz v0, :cond_26

    const-string v0, "App is debuggable!"

    invoke-direct {p0, v0}, Lsg/vantagepoint/uncrackable1/MainActivity;->a(Ljava/lang/String;)V

    :cond_26
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    const/high16 p1, 0x7f030000

    invoke-virtual {p0, p1}, Lsg/vantagepoint/uncrackable1/MainActivity;->setContentView(I)V

    return-void
.end method

.method public verify(Landroid/view/View;)V
    .registers 5

    const p1, 0x7f020001

    invoke-virtual {p0, p1}, Lsg/vantagepoint/uncrackable1/MainActivity;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/EditText;

    invoke-virtual {p1}, Landroid/widget/EditText;->getText()Landroid/text/Editable;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v0

    invoke-static {p1}, Lsg/vantagepoint/uncrackable1/a;->a(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2b

    const-string p1, "Success!"

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    const-string p1, "This is the correct secret."

    :goto_27
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setMessage(Ljava/lang/CharSequence;)V

    goto :goto_33

    :cond_2b
    const-string p1, "Nope..."

    invoke-virtual {v0, p1}, Landroid/app/AlertDialog;->setTitle(Ljava/lang/CharSequence;)V

    const-string p1, "That\'s not it. Try again."

    goto :goto_27

    :goto_33
    const/4 p1, -0x3

    const-string v1, "OK"

    new-instance v2, Lsg/vantagepoint/uncrackable1/MainActivity$2;

    invoke-direct {v2, p0}, Lsg/vantagepoint/uncrackable1/MainActivity$2;-><init>(Lsg/vantagepoint/uncrackable1/MainActivity;)V

    invoke-virtual {v0, p1, v1, v2}, Landroid/app/AlertDialog;->setButton(ILjava/lang/CharSequence;Landroid/content/DialogInterface$OnClickListener;)V

    invoke-virtual {v0}, Landroid/app/AlertDialog;->show()V

    return-void
.end method
