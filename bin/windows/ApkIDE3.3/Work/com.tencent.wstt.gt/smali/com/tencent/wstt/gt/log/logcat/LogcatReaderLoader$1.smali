.class Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader$1;
.super Ljava/lang/Object;
.source "LogcatReaderLoader.java"

# interfaces
.implements Landroid/os/Parcelable$Creator;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Landroid/os/Parcelable$Creator",
        "<",
        "Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .prologue
    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1
    return-void
.end method


# virtual methods
.method public createFromParcel(Landroid/os/Parcel;)Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;
    .locals 2
    .param p1, "in"    # Landroid/os/Parcel;

    .prologue
    .line 79
    new-instance v0, Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;

    const/4 v1, 0x0

    invoke-direct {v0, p1, v1}, Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;-><init>(Landroid/os/Parcel;Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;)V

    return-object v0
.end method

.method public bridge synthetic createFromParcel(Landroid/os/Parcel;)Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader$1;->createFromParcel(Landroid/os/Parcel;)Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;

    move-result-object v0

    return-object v0
.end method

.method public newArray(I)[Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;
    .locals 1
    .param p1, "size"    # I

    .prologue
    .line 83
    new-array v0, p1, [Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;

    return-object v0
.end method

.method public bridge synthetic newArray(I)[Ljava/lang/Object;
    .locals 1

    .prologue
    .line 1
    invoke-virtual {p0, p1}, Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader$1;->newArray(I)[Lcom/tencent/wstt/gt/log/logcat/LogcatReaderLoader;

    move-result-object v0

    return-object v0
.end method
