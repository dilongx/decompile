.class Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;
.super Landroid/widget/BaseAdapter;
.source "DragSortListView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mobeta/android/dslv/DragSortListView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "AdapterWrapper"
.end annotation


# instance fields
.field private mAdapter:Landroid/widget/ListAdapter;

.field final synthetic this$0:Lcom/mobeta/android/dslv/DragSortListView;


# direct methods
.method public constructor <init>(Lcom/mobeta/android/dslv/DragSortListView;Landroid/widget/ListAdapter;)V
    .locals 2
    .param p2, "adapter"    # Landroid/widget/ListAdapter;

    .prologue
    .line 647
    iput-object p1, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    .line 648
    invoke-direct {p0}, Landroid/widget/BaseAdapter;-><init>()V

    .line 649
    iput-object p2, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    .line 651
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    new-instance v1, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper$1;

    invoke-direct {v1, p0}, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper$1;-><init>(Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;)V

    invoke-interface {v0, v1}, Landroid/widget/ListAdapter;->registerDataSetObserver(Landroid/database/DataSetObserver;)V

    .line 660
    return-void
.end method


# virtual methods
.method public areAllItemsEnabled()Z
    .locals 1

    .prologue
    .line 683
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->areAllItemsEnabled()Z

    move-result v0

    return v0
.end method

.method public getAdapter()Landroid/widget/ListAdapter;
    .locals 1

    .prologue
    .line 663
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    return-object v0
.end method

.method public getCount()I
    .locals 1

    .prologue
    .line 678
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->getCount()I

    move-result v0

    return v0
.end method

.method public getItem(I)Ljava/lang/Object;
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 673
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItem(I)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public getItemId(I)J
    .locals 2
    .param p1, "position"    # I

    .prologue
    .line 668
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemId(I)J

    move-result-wide v0

    return-wide v0
.end method

.method public getItemViewType(I)I
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 693
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->getItemViewType(I)I

    move-result v0

    return v0
.end method

.method public getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 6
    .param p1, "position"    # I
    .param p2, "convertView"    # Landroid/view/View;
    .param p3, "parent"    # Landroid/view/ViewGroup;

    .prologue
    const/4 v5, 0x0

    .line 719
    if-eqz p2, :cond_3

    move-object v2, p2

    .line 720
    check-cast v2, Lcom/mobeta/android/dslv/DragSortItemView;

    .line 721
    .local v2, "v":Lcom/mobeta/android/dslv/DragSortItemView;
    invoke-virtual {v2, v5}, Lcom/mobeta/android/dslv/DragSortItemView;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 723
    .local v1, "oldChild":Landroid/view/View;
    iget-object v3, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    iget-object v4, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    invoke-interface {v3, p1, v1, v4}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 724
    .local v0, "child":Landroid/view/View;
    if-eq v0, v1, :cond_2

    .line 728
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    if-eqz v3, :cond_0

    .line 730
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    check-cast v3, Lcom/mobeta/android/dslv/DragSortItemView;

    invoke-virtual {v3, v0}, Lcom/mobeta/android/dslv/DragSortItemView;->removeView(Landroid/view/View;)V

    .line 732
    :cond_0
    if-eqz v1, :cond_1

    .line 733
    invoke-virtual {v2, v5}, Lcom/mobeta/android/dslv/DragSortItemView;->removeViewAt(I)V

    .line 735
    :cond_1
    invoke-virtual {v2, v0}, Lcom/mobeta/android/dslv/DragSortItemView;->addView(Landroid/view/View;)V

    .line 757
    .end local v1    # "oldChild":Landroid/view/View;
    :cond_2
    :goto_0
    iget-object v3, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    iget-object v4, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    invoke-virtual {v4}, Lcom/mobeta/android/dslv/DragSortListView;->getHeaderViewsCount()I

    move-result v4

    add-int/2addr v4, p1

    const/4 v5, 0x1

    # invokes: Lcom/mobeta/android/dslv/DragSortListView;->adjustItem(ILandroid/view/View;Z)V
    invoke-static {v3, v4, v2, v5}, Lcom/mobeta/android/dslv/DragSortListView;->access$1(Lcom/mobeta/android/dslv/DragSortListView;ILandroid/view/View;Z)V

    .line 759
    return-object v2

    .line 738
    .end local v0    # "child":Landroid/view/View;
    .end local v2    # "v":Lcom/mobeta/android/dslv/DragSortItemView;
    :cond_3
    iget-object v3, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    const/4 v4, 0x0

    iget-object v5, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    invoke-interface {v3, p1, v4, v5}, Landroid/widget/ListAdapter;->getView(ILandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v0

    .line 739
    .restart local v0    # "child":Landroid/view/View;
    instance-of v3, v0, Landroid/widget/Checkable;

    if-eqz v3, :cond_5

    .line 740
    new-instance v2, Lcom/mobeta/android/dslv/DragSortItemViewCheckable;

    iget-object v3, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    invoke-virtual {v3}, Lcom/mobeta/android/dslv/DragSortListView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/mobeta/android/dslv/DragSortItemViewCheckable;-><init>(Landroid/content/Context;)V

    .line 744
    .restart local v2    # "v":Lcom/mobeta/android/dslv/DragSortItemView;
    :goto_1
    new-instance v3, Landroid/widget/AbsListView$LayoutParams;

    .line 745
    const/4 v4, -0x1

    .line 746
    const/4 v5, -0x2

    invoke-direct {v3, v4, v5}, Landroid/widget/AbsListView$LayoutParams;-><init>(II)V

    .line 744
    invoke-virtual {v2, v3}, Lcom/mobeta/android/dslv/DragSortItemView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 748
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    if-eqz v3, :cond_4

    .line 750
    invoke-virtual {v0}, Landroid/view/View;->getParent()Landroid/view/ViewParent;

    move-result-object v3

    check-cast v3, Lcom/mobeta/android/dslv/DragSortItemView;

    invoke-virtual {v3, v0}, Lcom/mobeta/android/dslv/DragSortItemView;->removeView(Landroid/view/View;)V

    .line 752
    :cond_4
    invoke-virtual {v2, v0}, Lcom/mobeta/android/dslv/DragSortItemView;->addView(Landroid/view/View;)V

    goto :goto_0

    .line 742
    .end local v2    # "v":Lcom/mobeta/android/dslv/DragSortItemView;
    :cond_5
    new-instance v2, Lcom/mobeta/android/dslv/DragSortItemView;

    iget-object v3, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->this$0:Lcom/mobeta/android/dslv/DragSortListView;

    invoke-virtual {v3}, Lcom/mobeta/android/dslv/DragSortListView;->getContext()Landroid/content/Context;

    move-result-object v3

    invoke-direct {v2, v3}, Lcom/mobeta/android/dslv/DragSortItemView;-><init>(Landroid/content/Context;)V

    .restart local v2    # "v":Lcom/mobeta/android/dslv/DragSortItemView;
    goto :goto_1
.end method

.method public getViewTypeCount()I
    .locals 1

    .prologue
    .line 698
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->getViewTypeCount()I

    move-result v0

    return v0
.end method

.method public hasStableIds()Z
    .locals 1

    .prologue
    .line 703
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->hasStableIds()Z

    move-result v0

    return v0
.end method

.method public isEmpty()Z
    .locals 1

    .prologue
    .line 708
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0}, Landroid/widget/ListAdapter;->isEmpty()Z

    move-result v0

    return v0
.end method

.method public isEnabled(I)Z
    .locals 1
    .param p1, "position"    # I

    .prologue
    .line 688
    iget-object v0, p0, Lcom/mobeta/android/dslv/DragSortListView$AdapterWrapper;->mAdapter:Landroid/widget/ListAdapter;

    invoke-interface {v0, p1}, Landroid/widget/ListAdapter;->isEnabled(I)Z

    move-result v0

    return v0
.end method
