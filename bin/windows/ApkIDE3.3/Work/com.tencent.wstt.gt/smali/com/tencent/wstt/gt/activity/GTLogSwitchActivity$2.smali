.class Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity$2;
.super Ljava/lang/Object;
.source "GTLogSwitchActivity.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;->onResume()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;


# direct methods
.method constructor <init>(Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;)V
    .locals 0

    .prologue
    .line 1
    iput-object p1, p0, Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity$2;->this$0:Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 2
    .param p1, "buttonView"    # Landroid/widget/CompoundButton;
    .param p2, "isChecked"    # Z

    .prologue
    const/4 v1, 0x0

    .line 71
    if-eqz p2, :cond_0

    .line 72
    invoke-static {}, Lcom/tencent/wstt/gt/log/GTLogInternal;->enable()V

    .line 79
    :goto_0
    return-void

    .line 74
    :cond_0
    invoke-static {}, Lcom/tencent/wstt/gt/log/GTLogInternal;->disable()V

    .line 76
    iget-object v0, p0, Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity$2;->this$0:Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;

    # getter for: Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;->cb_autoSave:Lcom/tencent/wstt/gt/views/GTCheckBox;
    invoke-static {v0}, Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;->access$0(Lcom/tencent/wstt/gt/activity/GTLogSwitchActivity;)Lcom/tencent/wstt/gt/views/GTCheckBox;

    move-result-object v0

    invoke-virtual {v0, v1}, Lcom/tencent/wstt/gt/views/GTCheckBox;->setChecked(Z)V

    .line 77
    invoke-static {v1}, Lcom/tencent/wstt/gt/log/GTLogInternal;->setAutoSave(Z)V

    goto :goto_0
.end method
