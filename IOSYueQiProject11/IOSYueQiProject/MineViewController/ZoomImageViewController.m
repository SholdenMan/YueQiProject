//
//  ZoomImageViewController.m
//  Photo
//
//  Created by yunlu01 on 15/9/11.
//  Copyright (c) 2015年 YunluHealth. All rights reserved.
//

#import "ZoomImageViewController.h"
#define MaxZoomScale 3.0
#define MinZoomScale  0.5
// MainScreen Height&Width

#define PersonUpLoadUserIamge(a) [NSString stringWithFormat:@"%@", a]
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
// View 坐标(x,y)和宽高(width,height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
@interface ZoomImageViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *imageScrollView;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)UILabel *lbPage;
@end
@implementation ZoomImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
//    self.array = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4"];
    
}

-(void)addImageArray:(NSArray *)imageArr andImageIndex:(NSInteger)index{
    self.array = [[NSArray alloc]initWithArray:imageArr];
    
    self.imageScrollView= [[UIScrollView alloc]initWithFrame:CGRectMake(0,0,Main_Screen_Width,Main_Screen_Height)];
    self.imageScrollView.backgroundColor= [UIColor clearColor];
    self.imageScrollView.scrollEnabled=YES;
    self.imageScrollView.pagingEnabled=YES;
    self.imageScrollView.delegate=self;
//    self.imageScrollView.showsHorizontalScrollIndicator = NO;
//    self.imageScrollView.showsVerticalScrollIndicator = NO;
    self.imageScrollView.contentSize=CGSizeMake(self.array.count*WIDTH(_imageScrollView),HEIGHT(_imageScrollView));
    
    UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTap setNumberOfTapsRequired:1];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    for(int i =0; i <self.array.count; i++){

        UIScrollView *s = [[UIScrollView alloc]initWithFrame:CGRectMake(WIDTH(_imageScrollView)*i,0,WIDTH(_imageScrollView),HEIGHT(_imageScrollView))];
        s.backgroundColor= [UIColor clearColor];
        s.contentSize=CGSizeMake(WIDTH(_imageScrollView),HEIGHT(_imageScrollView));
        s.showsVerticalScrollIndicator = NO;
        s.showsHorizontalScrollIndicator = NO;
        s.delegate=self;
        s.minimumZoomScale=MinZoomScale;
        s.maximumZoomScale=MaxZoomScale;
        //        s.tag = i+1;
        [s setZoomScale:1.0];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,WIDTH(_imageScrollView), HEIGHT(_imageScrollView))];
        imageview.contentMode = UIViewContentModeScaleAspectFit;
        if ([self.array[i] isKindOfClass:[UIImage class]]) {
            imageview.image = self.array[i];
        }else{
            [imageview sd_setImageWithURL:[NSURL URLWithString:PersonUpLoadUserIamge(self.array[i])] placeholderImage:[UIImage imageNamed:@"ZC_mrtx_d"]];
        }
        
        imageview.userInteractionEnabled=YES;
        imageview.tag= i+1;
        [imageview addGestureRecognizer:doubleTap];
        [imageview addGestureRecognizer:singleTap];
        [s addSubview:imageview];
        [self.imageScrollView addSubview:s];
    }
    [self.view addSubview:self.imageScrollView];
    
//    self.lbPage = [[UILabel alloc]initWithFrame:CGRectMake(0, Main_Screen_Height-40, Main_Screen_Width, 30)];
//    self.lbPage.textColor = [UIColor redColor];
//    self.lbPage.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.lbPage];
    
    [self.imageScrollView addGestureRecognizer:singleTap];
    //跳转到当前图片
    [self.imageScrollView setContentOffset:CGPointMake(index*Main_Screen_Width, 0)];
    
    // 4,pageControl分页指示条
    _pageControl = [[UIPageControl alloc]init];
    // pageControl分页指示条的中心点在底部中间
    _pageControl.numberOfPages = self.array.count; //这个最重要
    _pageControl.center = CGPointMake(Main_Screen_Width*0.5, Main_Screen_Height-20);
    _pageControl.bounds = CGRectMake(0, 0, 150, 15);
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.enabled = NO; //取消其默认的点击行为
    _pageControl.currentPage = index;
    [self.view addSubview:_pageControl];
}

#pragma mark - ScrollView delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{
    for(UIView *v in scrollView.subviews){
        
        return v;
    }
    return nil;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    for(UIView *v in scrollView.subviews){
        CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
        CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
        v.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
        
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView{
    if(scrollView ==self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        CGPoint offset = scrollView.contentOffset;
        
        int curPageNo = offset.x / scrollView.bounds.size.width;
        _pageControl.currentPage = curPageNo ;
        if(x==-333){
        }
        else{
            //            offset = x;
            for(UIScrollView *s in scrollView.subviews){
                if([s isKindOfClass:[UIScrollView class]]){
                    
                    [s setZoomScale:1.0]; //scrollView每滑动一次将要出现的图片较正常时候图片的倍数（将要出现的图片显示的倍数）
                }
            }
        }
    }
}
////显示当前页数
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // 得到每页宽度
////    CGFloat pageWidth = scrollView.frame.size.width;
//    // 根据当前的x坐标和页宽度计算出当前页数
////    int currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
//    int currentPage = floorf(scrollView.contentOffset.x/Main_Screen_Width);
//    self.lbPage.text = [NSString stringWithFormat:@"%d/%d",currentPage,_array.count];
//    
//    CGPoint offset = scrollView.contentOffset;
//    
//    int curPageNo = offset.x / scrollView.bounds.size.width;
//    _pageControl.currentPage = curPageNo ;
//}

#pragma mark -
//单击
-(void)handleSingleTap:(UIGestureRecognizer*)gesture{
    NSLog(@"1");
    [self dismissViewControllerAnimated:YES completion:nil];
}
//双击
-(void)handleDoubleTap:(UIGestureRecognizer*)gesture{
    if ([(UIScrollView*)gesture.view.superview zoomScale]>=MaxZoomScale) {
        CGRect zoomRect = [self zoomRectForScale:1 withCenter:[gesture locationInView:gesture.view]];
        [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
    }else{
        float newScale = [(UIScrollView*)gesture.view.superview zoomScale] *MaxZoomScale;//每次双击放大倍数
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
        [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
    }
}
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height=self.view.frame.size.height/ scale;
    zoomRect.size.width=self.view.frame.size.width/ scale;
    zoomRect.origin.x= center.x- (zoomRect.size.width/2.0);
    zoomRect.origin.y= center.y- (zoomRect.size.height/2.0);
    return zoomRect;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
