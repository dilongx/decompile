.class Lcom/tencent/stat/common/c;
.super Ljava/lang/Object;


# instance fields
.field a:Ljava/lang/String;

.field b:Ljava/lang/String;

.field c:Landroid/util/DisplayMetrics;

.field d:I

.field e:Ljava/lang/String;

.field f:Ljava/lang/String;

.field g:Ljava/lang/String;

.field h:Ljava/lang/String;

.field i:Ljava/lang/String;

.field j:Ljava/lang/String;

.field k:Ljava/lang/String;

.field l:I

.field m:Ljava/lang/String;

.field n:Ljava/lang/String;

.field o:Ljava/lang/String;

.field p:Landroid/content/Context;

.field private q:Ljava/lang/String;

.field private r:Ljava/lang/String;

.field private s:Ljava/lang/String;

.field private t:Ljava/lang/String;

.field private u:Ljava/lang/String;


# direct methods
.method private constructor <init>(Landroid/content/Context;)V
    .locals 2

    const/4 v1, 0x0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "2.1.0"

    iput-object v0, p0, Lcom/tencent/stat/common/c;->b:Ljava/lang/String;

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    iput v0, p0, Lcom/tencent/stat/common/c;->d:I

    sget-object v0, Landroid/os/Build;->MODEL:Ljava/lang/String;

    iput-object v0, p0, Lcom/tencent/stat/common/c;->e:Ljava/lang/String;

    sget-object v0, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    iput-object v0, p0, Lcom/tencent/stat/common/c;->f:Ljava/lang/String;

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/Locale;->getLanguage()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->g:Ljava/lang/String;

    const/4 v0, 0x0

    iput v0, p0, Lcom/tencent/stat/common/c;->l:I

    iput-object v1, p0, Lcom/tencent/stat/common/c;->n:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->o:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->q:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->r:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    iput-object v1, p0, Lcom/tencent/stat/common/c;->u:Ljava/lang/String;

    invoke-virtual {p1}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getDisplayMetrics(Landroid/content/Context;)Landroid/util/DisplayMetrics;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getCurAppVersion(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->a:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/StatConfig;->getInstallChannel(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->h:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getSimOperator(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->i:Ljava/lang/String;

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v0

    invoke-virtual {v0}, Ljava/util/TimeZone;->getID()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->j:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->hasRootAccess(Landroid/content/Context;)I

    move-result v0

    iput v0, p0, Lcom/tencent/stat/common/c;->l:I

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getExternalStorageInfo(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->k:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-virtual {v0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->n:Ljava/lang/String;

    iget v0, p0, Lcom/tencent/stat/common/c;->d:I

    const/16 v1, 0xe

    if-lt v0, v1, :cond_0

    :cond_0
    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getCpuInfo(Landroid/content/Context;)Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->r:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getSystemMemory(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    invoke-static {}, Lcom/tencent/stat/common/StatCommonHelper;->getRomMemory()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getLauncherPackageName(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->o:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getCurAppSHA1Signature(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->u:Ljava/lang/String;

    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->getDeviceIMSI(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/tencent/stat/common/c;->m:Ljava/lang/String;

    return-void
.end method

.method synthetic constructor <init>(Landroid/content/Context;Lcom/tencent/stat/common/b;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/tencent/stat/common/c;-><init>(Landroid/content/Context;)V

    return-void
.end method


# virtual methods
.method a(Lorg/json/JSONObject;Ljava/lang/Thread;)V
    .locals 5
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    const/4 v4, 0x2

    const/4 v3, 0x0

    if-nez p2, :cond_4

    iget-object v0, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    if-eqz v0, :cond_0

    const-string v0, "sr"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    iget v2, v2, Landroid/util/DisplayMetrics;->widthPixels:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "*"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    iget v2, v2, Landroid/util/DisplayMetrics;->heightPixels:I

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v0, "dpi"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v2, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    iget v2, v2, Landroid/util/DisplayMetrics;->xdpi:F

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "*"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/tencent/stat/common/c;->c:Landroid/util/DisplayMetrics;

    iget v2, v2, Landroid/util/DisplayMetrics;->ydpi:F

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(F)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/NetworkManager;->getInstance(Landroid/content/Context;)Lcom/tencent/stat/NetworkManager;

    move-result-object v0

    invoke-virtual {v0}, Lcom/tencent/stat/NetworkManager;->isWifi()Z

    move-result v0

    if-eqz v0, :cond_1

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "bs"

    iget-object v2, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v2}, Lcom/tencent/stat/common/Util;->getWiFiBBSID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v1, "ss"

    iget-object v2, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v2}, Lcom/tencent/stat/common/Util;->getWiFiSSID(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v0, v1, v2}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONObject;->length()I

    move-result v1

    if-lez v1, :cond_1

    const-string v1, "wf"

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    :cond_1
    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    const/16 v1, 0xa

    invoke-static {v0, v1}, Lcom/tencent/stat/common/Util;->getWifiTopN(Landroid/content/Context;I)Lorg/json/JSONArray;

    move-result-object v0

    if-eqz v0, :cond_2

    invoke-virtual {v0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_2

    const-string v1, "wflist"

    invoke-virtual {v0}, Lorg/json/JSONArray;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {p1, v1, v0}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    :cond_2
    const-string v0, "sen"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->q:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    :goto_0
    const-string v0, "pcn"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v1}, Lcom/tencent/stat/common/StatCommonHelper;->a(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "osn"

    sget-object v1, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "av"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->a:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ch"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->h:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "mf"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->f:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "sv"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->b:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "osd"

    sget-object v1, Landroid/os/Build;->DISPLAY:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "prod"

    sget-object v1, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "tags"

    sget-object v1, Landroid/os/Build;->TAGS:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "id"

    sget-object v1, Landroid/os/Build;->ID:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "fng"

    sget-object v1, Landroid/os/Build;->FINGERPRINT:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "lch"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->o:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ov"

    iget v1, p0, Lcom/tencent/stat/common/c;->d:I

    invoke-static {v1}, Ljava/lang/Integer;->toString(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "os"

    const/4 v1, 0x1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v0, "op"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->i:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "lg"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->g:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "md"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->e:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "tz"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->j:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    iget v0, p0, Lcom/tencent/stat/common/c;->l:I

    if-eqz v0, :cond_3

    const-string v0, "jb"

    iget v1, p0, Lcom/tencent/stat/common/c;->l:I

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    :cond_3
    const-string v0, "sd"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->k:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "apn"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->n:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "cpu"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->r:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "abi"

    sget-object v1, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "abi2"

    sget-object v1, Landroid/os/Build;->CPU_ABI2:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "ram"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "rom"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "im"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->m:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "asg"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->u:Ljava/lang/String;

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    return-void

    :cond_4
    const-string v0, "thn"

    invoke-virtual {p2}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "qq"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v1}, Lcom/tencent/stat/StatConfig;->getQQ(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    const-string v0, "cui"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v1}, Lcom/tencent/stat/StatConfig;->getCustomUserId(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    iget-object v0, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->isStringValid(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    iget-object v0, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v0, v0

    if-ne v0, v4, :cond_5

    const-string v0, "fram"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->s:Ljava/lang/String;

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    aget-object v1, v1, v3

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    :cond_5
    iget-object v0, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    invoke-static {v0}, Lcom/tencent/stat/common/StatCommonHelper;->isStringValid(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    iget-object v0, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    const-string v1, "/"

    invoke-virtual {v0, v1}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    array-length v0, v0

    if-ne v0, v4, :cond_6

    const-string v0, "from"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->t:Ljava/lang/String;

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    aget-object v1, v1, v3

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    :cond_6
    iget-object v0, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v0}, Lcom/tencent/stat/ba;->a(Landroid/content/Context;)Lcom/tencent/stat/ba;

    move-result-object v0

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-virtual {v0, v1}, Lcom/tencent/stat/ba;->b(Landroid/content/Context;)Lcom/tencent/stat/common/DeviceInfo;

    move-result-object v0

    if-eqz v0, :cond_7

    const-string v0, "ui"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v1}, Lcom/tencent/stat/ba;->a(Landroid/content/Context;)Lcom/tencent/stat/ba;

    move-result-object v1

    iget-object v2, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-virtual {v1, v2}, Lcom/tencent/stat/ba;->b(Landroid/content/Context;)Lcom/tencent/stat/common/DeviceInfo;

    move-result-object v1

    invoke-virtual {v1}, Lcom/tencent/stat/common/DeviceInfo;->getImei()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v0, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_7
    const-string v0, "mid"

    iget-object v1, p0, Lcom/tencent/stat/common/c;->p:Landroid/content/Context;

    invoke-static {v1}, Lcom/tencent/stat/StatConfig;->getLocalMidOnly(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lcom/tencent/stat/common/Util;->jsonPut(Lorg/json/JSONObject;Ljava/lang/String;Ljava/lang/String;)V

    goto/16 :goto_0
.end method
