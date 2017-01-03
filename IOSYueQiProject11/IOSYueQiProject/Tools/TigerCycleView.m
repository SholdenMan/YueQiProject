//
//  TigerCycleView.m
//  OurProjectA
//
//  Created by tiger on 16/3/28.
//  Copyright © 2016年 爬虫. All rights reserved.
//

#import "TigerCycleView.h"
#import "UIImageView+AFNetworking.h"
#import "myCollectionViewCell.h"


//屏幕宽
#define KDeviceWidth [UIScreen mainScreen].bounds.size.width

//屏幕高
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height


@interface TigerCycleView ()<UIScrollViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView * myScrollView;
@property (nonatomic, strong) UIPageControl * myPageControl;
@property (nonatomic, strong) NSTimer * myTimer;//定时器
//image数组
@property (nonatomic, strong) NSMutableArray * imageUrlStringArray;

//时间
@property (nonatomic, assign) NSTimeInterval timeInterval;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end


@implementation TigerCycleView

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        self.dataSource = [NSMutableArray array];
    }
    return  _dataSource;
}

- (id)initWithImageUrlArray:(NSMutableArray *)imageUrlArray imageChangeTime : (NSTimeInterval)timeInterval Frame : (CGRect )frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //赋值  方便其他地方进行调用
        self.imageUrlStringArray = imageUrlArray;
        //时间赋值
        self.timeInterval = timeInterval;
        NSMutableArray * temArray = [NSMutableArray array];
        [temArray addObject:[imageUrlArray lastObject]];
        [temArray addObjectsFromArray:imageUrlArray];
        [temArray addObject:[imageUrlArray firstObject]];
        
        [self initScrollViewWith:temArray];
        self.myScrollView.contentOffset = CGPointMake(CGRectGetWidth(self.myScrollView.frame), 0);
        //定时器
        [self initWithTimer];
        
    }
    return self;
}
//定时器初始化
- (void)initWithTimer
{
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
}

//定时器方法
-(void)timerAction:(NSTimer *)timer
{
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.contentOffset.x + self.myScrollView.frame.size.width, 0) animated:YES];
}

//释放定时器
- (void)removeTimer
{
    [self.myTimer invalidate];//定时器失效
    self.myTimer = nil;
}

- (void)initScrollViewWith:(NSMutableArray *)imageUrl
{
    self.dataSource = imageUrl;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    //设置最小行列间距
    layOut.minimumInteritemSpacing = 0;
    //设置最小行间距
    layOut.minimumLineSpacing = 0;
    //设置item的大小
    layOut.itemSize = self.bounds.size;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置分区上下左右间距
    // layOut.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.myScrollView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layOut];
    [self.myScrollView registerClass:[myCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.myScrollView.contentSize = CGSizeMake(imageUrl.count * self.bounds.size.width, self.bounds.size.height);
    self.myScrollView.delegate = self;
    self.myScrollView.dataSource = self;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.backgroundColor = [UIColor grayColor];
    //是否显示水平滚动条
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.myScrollView];
    
    //小圆点
    self.myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - 30, 100, 30)];
    self.myPageControl.numberOfPages = self.imageUrlStringArray.count;
    self.myPageControl.currentPage = 0;//小圆点默认位置
    [self addSubview:self.myPageControl];
}



#pragma mark -UIScrollViewDelegate
//只要发生改变offset就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //
    float temNum = scrollView.contentOffset.x / scrollView.frame.size.width;
    //小圆点赋值
    self.myPageControl.currentPage = [[NSString stringWithFormat:@"%f", temNum] integerValue] - 1;
}
//将要拖拽时, 需要将定时器进行暂停
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //定时器暂停
    [self.myTimer setFireDate:[NSDate distantFuture]];
}

//已经结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //1 更改动画, 头一张  或者 最后一张的一些处理.
    [self headAndFooterChangeImage];
    //2.重新开启定时器.
    [self.myTimer setFireDate:[[NSDate alloc] initWithTimeIntervalSinceNow:self.timeInterval]];
}



//结束滚动的动画.
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //1 更改动画, 头一张  或者 最后一张的一些处理.
    [self headAndFooterChangeImage];
}
//第一张和最后一张的处理方法.
- (void)headAndFooterChangeImage
{
    //如果是第一张
    if (self.myScrollView.contentOffset.x == 0) {
        [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.frame.size.width * self.imageUrlStringArray.count, 0) animated:NO];
    }
    //跳转到第一张
    if (self.myScrollView.contentOffset.x == self.myScrollView.frame.size.width * (self.imageUrlStringArray.count + 1)) {
        [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.frame.size.width, 0) animated:NO];
    }
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell showData:self.dataSource[indexPath.row]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //self.tapBlock(self.myPageControl.currentPage);
}


- (void)dealloc {
    [self removeTimer];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
