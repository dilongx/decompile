.class public Lcom/tencent/stat/common/StatConstants;
.super Ljava/lang/Object;


# static fields
.field public static DATABASE_NAME:Ljava/lang/String; = null

.field public static final FB_KEY:Ljava/lang/String; = "nDkb9nMIizcj2RDehplOjn+Q"

.field public static final LOG_TAG:Ljava/lang/String; = "MtaSDK"

.field public static final MTA_COOPERATION_TAG:Ljava/lang/String; = ""

.field public static final MTA_DB2SP_TAG:Ljava/lang/String; = "tencent_mta_sp_"

.field public static final MTA_FEEDBACK_REPORT_URL:Ljava/lang/String; = "http://mta.qq.com/mta/api/ctr_feedback"

.field public static final MTA_REPORT_FULL_URL:Ljava/lang/String; = "http://pingma.qq.com:80/mstat/report"

.field public static final MTA_SERVER:Ljava/lang/String; = "pingma.qq.com:80"

.field public static final MTA_SERVER_HOST:Ljava/lang/String; = "pingma.qq.com"

.field public static final MTA_SERVER_PORT:I = 0x50

.field public static final MTA_STAT_URL:Ljava/lang/String; = "/mstat/report"

.field public static final MTA_STORAGE_PRE_TAG:Ljava/lang/String;

.field public static final SDK_ONLINE_CONFIG_TYPE:I = 0x1

.field public static final STAT_DB_VERSION:I = 0x3

.field public static final USER_ONLINE_CONFIG_TYPE:I = 0x2

.field public static final VERSION:Ljava/lang/String; = "2.1.0"

.field public static final XG_PRO_VERSION:I = 0x1


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "tencent.mta"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "data"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/tencent/stat/common/StatConstants;->MTA_STORAGE_PRE_TAG:Ljava/lang/String;

    const-string v0, "tencent_analysis.db"

    sput-object v0, Lcom/tencent/stat/common/StatConstants;->DATABASE_NAME:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
