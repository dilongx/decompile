.class public Loicq/wlogin_sdk/code2d/fetch_code;
.super Loicq/wlogin_sdk/code2d/b;
.source "fetch_code.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 1

    .prologue
    .line 34
    invoke-direct {p0}, Loicq/wlogin_sdk/code2d/b;-><init>()V

    .line 35
    const/16 v0, 0x31

    iput v0, p0, Loicq/wlogin_sdk/code2d/fetch_code;->_cmd:I

    .line 36
    return-void
.end method


# virtual methods
.method public get_request(JJJ[BLoicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;JJ[B)[B
    .locals 19

    .prologue
    .line 40
    move-object/from16 v0, p7

    array-length v6, v0

    add-int/lit8 v6, v6, 0x11

    add-int/lit8 v7, v6, 0x2

    .line 41
    const/4 v6, 0x5

    new-array v10, v6, [I

    fill-array-data v10, :array_0

    .line 42
    array-length v11, v10

    .line 43
    new-instance v12, Ljava/util/ArrayList;

    invoke-direct {v12}, Ljava/util/ArrayList;-><init>()V

    .line 44
    const/4 v6, 0x0

    move v9, v6

    move v6, v7

    :goto_0
    if-ge v9, v11, :cond_2

    .line 45
    new-instance v13, Loicq/wlogin_sdk/b/a;

    invoke-direct {v13}, Loicq/wlogin_sdk/b/a;-><init>()V

    .line 46
    aget v7, v10, v9

    invoke-virtual {v13, v7}, Loicq/wlogin_sdk/b/a;->a(I)V

    .line 47
    const/4 v8, 0x0

    .line 48
    const/4 v7, 0x0

    .line 49
    const/4 v14, 0x0

    .line 51
    aget v15, v10, v9

    sparse-switch v15, :sswitch_data_0

    .line 117
    :cond_0
    :goto_1
    if-eqz v8, :cond_1

    .line 118
    invoke-virtual {v13, v8, v7}, Loicq/wlogin_sdk/b/a;->b([BI)V

    .line 119
    invoke-virtual {v13}, Loicq/wlogin_sdk/b/a;->d()V

    .line 121
    invoke-virtual {v13}, Loicq/wlogin_sdk/b/a;->a()[B

    move-result-object v7

    .line 122
    array-length v8, v7

    add-int/2addr v6, v8

    .line 123
    invoke-virtual {v12, v7}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 44
    :cond_1
    add-int/lit8 v7, v9, 0x1

    move v9, v7

    goto :goto_0

    .line 53
    :sswitch_0
    if-eqz p13, :cond_0

    move-object/from16 v0, p13

    array-length v14, v0

    if-lez v14, :cond_0

    .line 55
    move-object/from16 v0, p13

    array-length v7, v0

    .line 56
    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    const-string v14, "qrpushsig of "

    invoke-virtual {v8, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    move-wide/from16 v0, p3

    invoke-virtual {v8, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    move-wide/from16 v0, p1

    invoke-virtual {v14, v0, v1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ""

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    invoke-static {v8, v14}, Loicq/wlogin_sdk/tools/util;->LOGI(Ljava/lang/String;Ljava/lang/String;)V

    move-object/from16 v8, p13

    goto :goto_1

    .line 60
    :sswitch_1
    move-object/from16 v0, p0

    move-wide/from16 v1, p3

    move-wide/from16 v3, p5

    invoke-virtual {v0, v1, v2, v3, v4}, Loicq/wlogin_sdk/code2d/fetch_code;->getAppInfo(JJ)[B

    move-result-object v8

    .line 61
    array-length v7, v8

    goto :goto_1

    .line 64
    :sswitch_2
    const/16 v7, 0x1e

    .line 65
    new-array v8, v7, [B

    .line 67
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Micro:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 68
    const/4 v14, 0x4

    .line 69
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Version:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 70
    const/16 v14, 0x8

    .line 71
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Size:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 72
    const/16 v14, 0xc

    .line 73
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Margin:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 74
    const/16 v14, 0x10

    .line 75
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Dpi:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 76
    const/16 v14, 0x14

    .line 77
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->EcLevel:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 78
    const/16 v14, 0x18

    .line 79
    move-object/from16 v0, p8

    iget v15, v0, Loicq/wlogin_sdk/code2d/fetch_code$QRCodeCustom;->Hint:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int32_to_buf([BII)V

    .line 80
    const/16 v14, 0x1c

    .line 81
    const/4 v15, 0x0

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int16_to_buf([BII)V

    goto/16 :goto_1

    .line 86
    :sswitch_3
    const/16 v7, 0xe

    .line 87
    new-array v8, v7, [B

    .line 89
    const/4 v15, 0x1

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int8_to_buf([BII)V

    .line 90
    const/4 v14, 0x1

    .line 91
    move-wide/from16 v0, p9

    invoke-static {v8, v14, v0, v1}, Loicq/wlogin_sdk/tools/util;->int64_to_buf32([BIJ)V

    .line 92
    const/4 v14, 0x5

    .line 93
    move-wide/from16 v0, p11

    invoke-static {v8, v14, v0, v1}, Loicq/wlogin_sdk/tools/util;->int64_to_buf32([BIJ)V

    .line 94
    const/16 v14, 0x9

    .line 95
    const/4 v15, 0x0

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int8_to_buf([BII)V

    .line 96
    const/16 v14, 0xa

    .line 97
    const-wide/16 v16, 0x0

    move-wide/from16 v0, v16

    invoke-static {v8, v14, v0, v1}, Loicq/wlogin_sdk/tools/util;->int64_to_buf32([BIJ)V

    goto/16 :goto_1

    .line 102
    :sswitch_4
    sget-object v7, Loicq/wlogin_sdk/request/u;->I:[B

    array-length v7, v7

    add-int/lit8 v7, v7, 0x3

    add-int/lit8 v7, v7, 0x2

    sget-object v8, Loicq/wlogin_sdk/request/u;->H:[B

    array-length v8, v8

    add-int/2addr v7, v8

    add-int/lit8 v7, v7, 0x2

    add-int/lit8 v7, v7, 0x2

    sget-object v8, Loicq/wlogin_sdk/request/u;->A:[B

    array-length v8, v8

    add-int/2addr v7, v8

    add-int/lit8 v7, v7, 0x2

    add-int/lit8 v7, v7, 0x0

    add-int/lit8 v7, v7, 0x2

    sget-object v8, Loicq/wlogin_sdk/request/u;->D:[B

    array-length v8, v8

    add-int/2addr v7, v8

    .line 104
    new-array v8, v7, [B

    .line 105
    sget v15, Loicq/wlogin_sdk/request/u;->X:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int8_to_buf([BII)V

    .line 106
    const/4 v14, 0x1

    .line 107
    sget-object v15, Loicq/wlogin_sdk/request/u;->I:[B

    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v15, v14}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    move-result v14

    .line 108
    sget-object v15, Loicq/wlogin_sdk/request/u;->H:[B

    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v15, v14}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    move-result v14

    .line 109
    sget v15, Loicq/wlogin_sdk/request/u;->B:I

    invoke-static {v8, v14, v15}, Loicq/wlogin_sdk/tools/util;->int16_to_buf([BII)V

    .line 110
    add-int/lit8 v14, v14, 0x2

    .line 111
    sget-object v15, Loicq/wlogin_sdk/request/u;->A:[B

    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v15, v14}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    move-result v14

    .line 112
    const/4 v15, 0x0

    new-array v15, v15, [B

    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v15, v14}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    move-result v14

    .line 113
    sget-object v15, Loicq/wlogin_sdk/request/u;->D:[B

    move-object/from16 v0, p0

    invoke-virtual {v0, v8, v15, v14}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    goto/16 :goto_1

    .line 128
    :cond_2
    new-array v9, v6, [B

    .line 131
    const/4 v6, 0x2

    .line 132
    move-wide/from16 v0, p3

    invoke-static {v9, v6, v0, v1}, Loicq/wlogin_sdk/tools/util;->int64_to_buf32([BIJ)V

    .line 133
    const/4 v6, 0x6

    .line 134
    move-wide/from16 v0, p1

    invoke-static {v9, v6, v0, v1}, Loicq/wlogin_sdk/tools/util;->int64_to_buf([BIJ)V

    .line 135
    const/16 v6, 0xe

    .line 137
    const/16 v7, 0x8

    invoke-static {v9, v6, v7}, Loicq/wlogin_sdk/tools/util;->int8_to_buf([BII)V

    .line 138
    const/16 v6, 0xf

    .line 140
    move-object/from16 v0, p0

    move-object/from16 v1, p7

    invoke-virtual {v0, v9, v1, v6}, Loicq/wlogin_sdk/code2d/fetch_code;->fill_staff([B[BI)I

    move-result v6

    .line 142
    invoke-virtual {v12}, Ljava/util/ArrayList;->size()I

    move-result v10

    .line 143
    invoke-static {v9, v6, v10}, Loicq/wlogin_sdk/tools/util;->int16_to_buf([BII)V

    .line 144
    add-int/lit8 v7, v6, 0x2

    .line 145
    const/4 v6, 0x0

    move v8, v7

    move v7, v6

    :goto_2
    if-ge v7, v10, :cond_3

    .line 146
    invoke-virtual {v12, v7}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v6

    check-cast v6, [B

    .line 147
    const/4 v11, 0x0

    array-length v13, v6

    invoke-static {v6, v11, v9, v8, v13}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 148
    array-length v6, v6

    add-int/2addr v8, v6

    .line 145
    add-int/lit8 v6, v7, 0x1

    move v7, v6

    goto :goto_2

    .line 151
    :cond_3
    const/4 v6, 0x1

    move-object/from16 v0, p0

    move-wide/from16 v1, p1

    invoke-virtual {v0, v1, v2, v6, v9}, Loicq/wlogin_sdk/code2d/fetch_code;->get_request(JZ[B)[B

    move-result-object v6

    return-object v6

    .line 41
    :array_0
    .array-data 4
        0x11
        0x16
        0x1b
        0x1d
        0x1f
    .end array-data

    .line 51
    :sswitch_data_0
    .sparse-switch
        0x11 -> :sswitch_0
        0x16 -> :sswitch_1
        0x1b -> :sswitch_2
        0x1d -> :sswitch_3
        0x1f -> :sswitch_4
    .end sparse-switch
.end method

.method public get_response([B)I
    .locals 8

    .prologue
    const/16 v6, 0x9

    const/4 v2, 0x0

    .line 156
    invoke-virtual {p0, p1, v2}, Loicq/wlogin_sdk/code2d/fetch_code;->get_response([BI)[B

    move-result-object v3

    .line 159
    if-eqz v3, :cond_0

    array-length v0, v3

    const/16 v1, 0xb

    if-ge v0, v1, :cond_1

    .line 160
    :cond_0
    const/16 v0, -0x3f1

    .line 208
    :goto_0
    return v0

    .line 162
    :cond_1
    const/4 v0, 0x2

    .line 163
    sget-object v1, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int32([BI)I

    move-result v0

    int-to-long v4, v0

    iput-wide v4, v1, Loicq/wlogin_sdk/code2d/c;->h:J

    .line 164
    const/4 v0, 0x6

    .line 165
    sget-object v1, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int8([BI)I

    move-result v0

    iput v0, v1, Loicq/wlogin_sdk/code2d/c;->b:I

    .line 166
    const/4 v0, 0x7

    .line 167
    sget-object v1, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    iget v1, v1, Loicq/wlogin_sdk/code2d/c;->b:I

    if-eqz v1, :cond_2

    .line 169
    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v0

    .line 171
    sget-object v1, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    new-array v4, v0, [B

    iput-object v4, v1, Loicq/wlogin_sdk/code2d/c;->f:[B

    .line 172
    sget-object v1, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    iget-object v1, v1, Loicq/wlogin_sdk/code2d/c;->f:[B

    invoke-static {v3, v6, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 173
    add-int/lit8 v0, v0, 0x9

    .line 174
    sget-object v0, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    iget v0, v0, Loicq/wlogin_sdk/code2d/c;->b:I

    goto :goto_0

    .line 177
    :cond_2
    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v0

    .line 179
    new-array v1, v0, [B

    sput-object v1, Loicq/wlogin_sdk/code2d/c;->i:[B

    .line 180
    sget-object v1, Loicq/wlogin_sdk/code2d/c;->i:[B

    invoke-static {v3, v6, v1, v2, v0}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 181
    add-int/lit8 v0, v0, 0x9

    .line 183
    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v4

    .line 184
    add-int/lit8 v0, v0, 0x2

    move v1, v2

    .line 185
    :goto_1
    if-ge v1, v4, :cond_3

    .line 186
    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v5

    .line 187
    add-int/lit8 v0, v0, 0x2

    .line 189
    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v6

    .line 190
    add-int/lit8 v0, v0, 0x2

    .line 192
    sparse-switch v5, :sswitch_data_0

    .line 185
    :goto_2
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 194
    :sswitch_0
    sget-object v5, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    new-array v7, v6, [B

    iput-object v7, v5, Loicq/wlogin_sdk/code2d/c;->j:[B

    .line 195
    sget-object v5, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    iget-object v5, v5, Loicq/wlogin_sdk/code2d/c;->j:[B

    invoke-static {v3, v0, v5, v2, v6}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 196
    add-int/2addr v0, v6

    .line 197
    goto :goto_2

    .line 200
    :sswitch_1
    sget-object v5, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int32([BI)I

    move-result v6

    int-to-long v6, v6

    iput-wide v6, v5, Loicq/wlogin_sdk/code2d/c;->k:J

    .line 201
    add-int/lit8 v0, v0, 0x4

    .line 202
    sget-object v5, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    invoke-static {v3, v0}, Loicq/wlogin_sdk/tools/util;->buf_to_int16([BI)I

    move-result v6

    iput v6, v5, Loicq/wlogin_sdk/code2d/c;->l:I

    .line 203
    add-int/lit8 v0, v0, 0x2

    goto :goto_2

    .line 208
    :cond_3
    sget-object v0, Loicq/wlogin_sdk/code2d/fetch_code;->_status:Loicq/wlogin_sdk/code2d/c;

    iget v0, v0, Loicq/wlogin_sdk/code2d/c;->b:I

    goto/16 :goto_0

    .line 192
    :sswitch_data_0
    .sparse-switch
        0x17 -> :sswitch_0
        0x1c -> :sswitch_1
    .end sparse-switch
.end method
