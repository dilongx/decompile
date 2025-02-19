.class public Lcom/tencent/bugly/crashreport/CrashReport$CrashHandleCallback;
.super Ljava/lang/Object;
.source "BUGLY"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/tencent/bugly/crashreport/CrashReport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "CrashHandleCallback"
.end annotation


# static fields
.field public static final CRASHTYPE_ANR:I = 0x4

.field public static final CRASHTYPE_COCOS2DX_JS:I = 0x5

.field public static final CRASHTYPE_COCOS2DX_LUA:I = 0x6

.field public static final CRASHTYPE_JAVA_CATCH:I = 0x1

.field public static final CRASHTYPE_JAVA_CRASH:I = 0x0

.field public static final CRASHTYPE_NATIVE:I = 0x2

.field public static final CRASHTYPE_U3D:I = 0x3

.field public static final MAX_USERDATA_KEY_LENGTH:I = 0x64

.field public static final MAX_USERDATA_VALUE_LENGTH:I = 0x7530


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 1017
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public declared-synchronized onCrashHandleStart(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/util/Map;
    .locals 1
    .param p1, "crashType"    # I
    .param p2, "errorType"    # Ljava/lang/String;
    .param p3, "errorMessage"    # Ljava/lang/String;
    .param p4, "errorStack"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Map",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    .line 1039
    monitor-enter p0

    const/4 v0, 0x0

    monitor-exit p0

    return-object v0
.end method

.method public declared-synchronized onCrashHandleStart2GetExtraDatas(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1
    .param p1, "crashType"    # I
    .param p2, "errorType"    # Ljava/lang/String;
    .param p3, "errorMessage"    # Ljava/lang/String;
    .param p4, "errorStack"    # Ljava/lang/String;

    .prologue
    .line 1053
    monitor-enter p0

    const/4 v0, 0x0

    monitor-exit p0

    return-object v0
.end method
