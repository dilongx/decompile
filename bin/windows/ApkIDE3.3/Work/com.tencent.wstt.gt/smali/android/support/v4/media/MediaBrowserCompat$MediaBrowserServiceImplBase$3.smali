.class Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;
.super Ljava/lang/Object;
.source "MediaBrowserCompat.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase;->getItem(Ljava/lang/String;Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase;

.field final synthetic val$cb:Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;

.field final synthetic val$mediaId:Ljava/lang/String;


# direct methods
.method constructor <init>(Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase;Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 955
    iput-object p1, p0, Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;->this$0:Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase;

    iput-object p2, p0, Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;->val$cb:Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;

    iput-object p3, p0, Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;->val$mediaId:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 958
    iget-object v0, p0, Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;->val$cb:Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;

    iget-object v1, p0, Landroid/support/v4/media/MediaBrowserCompat$MediaBrowserServiceImplBase$3;->val$mediaId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Landroid/support/v4/media/MediaBrowserCompat$ItemCallback;->onError(Ljava/lang/String;)V

    .line 959
    return-void
.end method
