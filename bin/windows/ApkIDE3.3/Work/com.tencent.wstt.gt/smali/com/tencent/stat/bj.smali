.class Lcom/tencent/stat/bj;
.super Ljava/lang/Object;


# instance fields
.field a:J

.field b:Ljava/lang/String;

.field c:I

.field d:I


# direct methods
.method public constructor <init>(JLjava/lang/String;II)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/tencent/stat/bj;->a:J

    iput-object p3, p0, Lcom/tencent/stat/bj;->b:Ljava/lang/String;

    iput p4, p0, Lcom/tencent/stat/bj;->c:I

    iput p5, p0, Lcom/tencent/stat/bj;->d:I

    return-void
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/tencent/stat/bj;->b:Ljava/lang/String;

    return-object v0
.end method
