.class final Lcom/tencent/stat/ac;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:Lcom/tencent/stat/event/d;

.field final synthetic c:Landroid/content/Context;

.field final synthetic d:Lcom/tencent/stat/StatSpecifyReportedInfo;


# direct methods
.method constructor <init>(Ljava/lang/String;Lcom/tencent/stat/event/d;Landroid/content/Context;Lcom/tencent/stat/StatSpecifyReportedInfo;)V
    .locals 0

    iput-object p1, p0, Lcom/tencent/stat/ac;->a:Ljava/lang/String;

    iput-object p2, p0, Lcom/tencent/stat/ac;->b:Lcom/tencent/stat/event/d;

    iput-object p3, p0, Lcom/tencent/stat/ac;->c:Landroid/content/Context;

    iput-object p4, p0, Lcom/tencent/stat/ac;->d:Lcom/tencent/stat/StatSpecifyReportedInfo;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lcom/tencent/stat/ac;->a:Ljava/lang/String;

    invoke-static {v0}, Lcom/tencent/stat/StatServiceImpl;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    invoke-static {}, Lcom/tencent/stat/StatServiceImpl;->f()Lcom/tencent/stat/common/StatLogger;

    move-result-object v0

    const-string v1, "The event_id of StatService.trackCustomEndEvent() can not be null or empty."

    invoke-virtual {v0, v1}, Lcom/tencent/stat/common/StatLogger;->error(Ljava/lang/Object;)V

    :goto_0
    return-void

    :cond_0
    invoke-static {}, Lcom/tencent/stat/StatServiceImpl;->p()Ljava/util/Map;

    move-result-object v0

    iget-object v1, p0, Lcom/tencent/stat/ac;->b:Lcom/tencent/stat/event/d;

    invoke-interface {v0, v1}, Ljava/util/Map;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Long;

    if-eqz v0, :cond_2

    new-instance v2, Lcom/tencent/stat/event/c;

    iget-object v1, p0, Lcom/tencent/stat/ac;->c:Landroid/content/Context;

    iget-object v3, p0, Lcom/tencent/stat/ac;->c:Landroid/content/Context;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/tencent/stat/ac;->d:Lcom/tencent/stat/StatSpecifyReportedInfo;

    invoke-static {v3, v4, v5}, Lcom/tencent/stat/StatServiceImpl;->a(Landroid/content/Context;ZLcom/tencent/stat/StatSpecifyReportedInfo;)I

    move-result v3

    iget-object v4, p0, Lcom/tencent/stat/ac;->b:Lcom/tencent/stat/event/d;

    iget-object v4, v4, Lcom/tencent/stat/event/d;->a:Ljava/lang/String;

    iget-object v5, p0, Lcom/tencent/stat/ac;->d:Lcom/tencent/stat/StatSpecifyReportedInfo;

    invoke-direct {v2, v1, v3, v4, v5}, Lcom/tencent/stat/event/c;-><init>(Landroid/content/Context;ILjava/lang/String;Lcom/tencent/stat/StatSpecifyReportedInfo;)V

    invoke-virtual {v2}, Lcom/tencent/stat/event/c;->b()Lcom/tencent/stat/event/d;

    move-result-object v1

    iget-object v3, p0, Lcom/tencent/stat/ac;->b:Lcom/tencent/stat/event/d;

    iget-object v3, v3, Lcom/tencent/stat/event/d;->c:Lorg/json/JSONObject;

    iput-object v3, v1, Lcom/tencent/stat/event/d;->c:Lorg/json/JSONObject;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    sub-long v0, v4, v0

    const-wide/16 v4, 0x3e8

    div-long/2addr v0, v4

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v4

    const-wide/16 v6, 0x0

    cmp-long v1, v4, v6

    if-gtz v1, :cond_1

    const-wide/16 v0, 0x1

    :goto_1
    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    invoke-virtual {v2, v0, v1}, Lcom/tencent/stat/event/c;->a(J)V

    new-instance v0, Lcom/tencent/stat/av;

    invoke-direct {v0, v2}, Lcom/tencent/stat/av;-><init>(Lcom/tencent/stat/event/f;)V

    invoke-virtual {v0}, Lcom/tencent/stat/av;->a()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    invoke-static {}, Lcom/tencent/stat/StatServiceImpl;->f()Lcom/tencent/stat/common/StatLogger;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/tencent/stat/common/StatLogger;->e(Ljava/lang/Throwable;)V

    iget-object v1, p0, Lcom/tencent/stat/ac;->c:Landroid/content/Context;

    invoke-static {v1, v0}, Lcom/tencent/stat/StatServiceImpl;->a(Landroid/content/Context;Ljava/lang/Throwable;)V

    goto :goto_0

    :cond_1
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    goto :goto_1

    :cond_2
    invoke-static {}, Lcom/tencent/stat/StatServiceImpl;->f()Lcom/tencent/stat/common/StatLogger;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "No start time found for custom event: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/tencent/stat/ac;->b:Lcom/tencent/stat/event/d;

    invoke-virtual {v2}, Lcom/tencent/stat/event/d;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", lost trackCustomBeginKVEvent()?"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/tencent/stat/common/StatLogger;->warn(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_0
.end method
