//
//  CommentViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/12/6.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
// 评论列表


#import "CommentViewController.h"
#import "NewStarView.h"
#import "StartCollectionViewCell.h"
#import "StartModel.h"
#import "TZTestCell.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import "PhotoLibraryView.h"
#define PersonUpLoadUserIamge(a) [NSString stringWithFormat:@"%@", a]


@interface CommentViewController ()<NewStarViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, QBImagePickerControllerDelegate,MessagePhotoItemDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *StartView;
@property (strong, nonatomic) NewStarView *starRateView;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (strong, nonatomic) NSMutableArray *selectedPhotos;//选择的照片数组
@property (weak, nonatomic) IBOutlet UILabel *placeholedLabel;
@property (nonatomic , strong)NSString *grade;
@property (nonatomic, assign)BOOL isAnonymous;
@property (nonatomic, strong)NSMutableArray *iamges;
@property (nonatomic, strong) MBProgressHUD *hud;



@end

@implementation CommentViewController

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)selectedPhotos{
    if (!_selectedPhotos) {
        self.selectedPhotos = [NSMutableArray array];
    }
    return _selectedPhotos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.grade = @"5";
    self.isAnonymous = NO;
    self.iamges = [NSMutableArray array];
    self.title = @"评论列表";
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"StartCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"start"];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(comment)];
    self.myTextView.delegate = self;
//    self.myTextView.borderStyle = UITextBorderStyleNone;
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake((TheW - 90) / 5, 100);
    layOut.minimumInteritemSpacing = 15;
    layOut.minimumLineSpacing = 15;
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
    self.myCollectionView.collectionViewLayout = layOut;
    
    UICollectionViewFlowLayout *layout1 = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    [layout1 setScrollDirection:UICollectionViewScrollDirectionVertical];
    //cell间距
    layout1.minimumInteritemSpacing = 15.0f;
    //cell行距
    layout1.minimumLineSpacing = 15.0f;
    layout1.itemSize = CGSizeMake((TheW - 90) / 3, ((TheW - 90) / 3) * 5/6);

//    _imageCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout1];
    _imageCollection.backgroundColor = [UIColor clearColor];
    _imageCollection.contentInset = UIEdgeInsetsMake(4, 4, 0, 4);
    _imageCollection.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -2);
    _imageCollection.dataSource = self;
    _imageCollection.delegate = self;
    [_imageCollection registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    self.imageCollection.collectionViewLayout = layout1;

    [self creatData];
}
//发布
-(void)comment{
    NSLog(@"%@", self.grade);
    if (self.myTextView.text.length == 0 && self.myTextView.text.length >140) {
        [MBProgressHUD showError:@"评论不能为空且字数不超过140个字" toView:nil];
        return;
    }
    NSDictionary *dic = @{@"grade":self.grade, @"anonymous":@(self.isAnonymous), @"content":self.myTextView.text, @"order_id":self.orderID, @"images":self.iamges};
    self.hud = [MBProgressHUD showMessag:@"正在上传" toView:nil];
    [NewWorkingRequestManage requestPostWith:CommentUrl parDic:dic finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
        [self dismissViewControllerAnimated:YES completion:nil];
    } error:^(NSError *error) {
        NSLog(@"%@", [NewWorkingRequestManage newWork].errorStr);
        [self.hud hide:YES afterDelay:0];
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
        
    }];
    
    
}

- (void)creatData{
    StartModel *model1 = [[StartModel alloc] init];
    model1.content = @"差";
    model1.isLight = YES;
    [self.dataSource addObject:model1];
    
    StartModel *model2 = [[StartModel alloc] init];
    model2.content = @"一般";
    model2.isLight = YES;
    [self.dataSource addObject:model2];
    
    StartModel *model3 = [[StartModel alloc] init];
    model3.content = @"较满意";
    model3.isLight = YES;
    [self.dataSource addObject:model3];
    
    StartModel *model4 = [[StartModel alloc] init];
    model4.content = @"满意";
    model4.isLight = YES;
    [self.dataSource addObject:model4];
    
    StartModel *model5 = [[StartModel alloc] init];
    model5.content = @"强烈满意";
    model5.isLight = YES;
    [self.dataSource addObject:model5];
    [self.myCollectionView reloadData];
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.myCollectionView]) {
        return self.dataSource.count;
    }else{
        if (self.selectedPhotos.count==3) {
            return 3;
        }
        return self.selectedPhotos.count+1 ;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.myCollectionView]) {
        StartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"start" forIndexPath:indexPath];
        StartModel *model = self.dataSource[indexPath.row];
        [cell showWith:model];
        return cell;

    }else{
        TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
        NSMutableArray *selectedPhotos = [self.selectedPhotos mutableCopy];
        cell.delegate = self;
        if (indexPath.row == selectedPhotos.count) {
            cell.imageView.image = [UIImage imageNamed:@"icon-photographyy"];
            cell.indexPath = nil;
        } else if ([selectedPhotos[indexPath.row] isKindOfClass:[UIImage class]]) {
            cell.imageView.image = selectedPhotos[indexPath.row];
            cell.indexPath = [indexPath copy];
        }else {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:PersonUpLoadUserIamge(selectedPhotos[indexPath.row])] placeholderImage:nil];
            cell.indexPath = [indexPath copy];
        }
        return cell;

    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.myTextView resignFirstResponder];
    self.grade = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    if ([collectionView isEqual:self.myCollectionView]) {
        for (StartModel *model in self.dataSource) {
            model.isLight = NO;
        };
        for (int i = 0 ; i < indexPath.row + 1; i++) {
            StartModel *model = self.dataSource[i];
            model.isLight =YES;
        }
        [self.myCollectionView reloadData];
    }else{
        if (indexPath.row == self.selectedPhotos.count) {
            NSLog(@"1111");
            PhotoLibraryView *photoLibView = [[PhotoLibraryView alloc] init];
            photoLibView.viewController = self.navigationController;
            [photoLibView.buttonOne setTitle:@"拍照" forState:UIControlStateNormal];
            [photoLibView.buttonTwo setTitle:@"选择相册" forState:UIControlStateNormal];
            __weak typeof(photoLibView) weakPhotoLibView = photoLibView;
            photoLibView.PhotoOption = ^{
                [weakPhotoLibView coverClick];
                [self openCrema];
            };
            photoLibView.LibraryOption = ^{
                [weakPhotoLibView coverClick];
                [self openPictureLibrary];
            };
            [photoLibView show];

        }
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return YES;
}


-(void)messagePhotoItemView:(TZTestCell *)messagePhotoItemView didSelectDeleteButtonAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.selectedPhotos removeObjectAtIndex:indexPath.row];
    [self.imageCollection reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

/** 打开照相机 */
- (void)openCrema
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

/** 打开相册 */
- (void)openPictureLibrary
{
    QBImagePickerController *imagePickerController = [QBImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.maximumNumberOfSelection = 3-self.selectedPhotos.count;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - 照片多选
- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}
- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
    BOOL isFirset;
    __block NSInteger uploadNumOfImages = assets.count;
    for (PHAsset *asset in assets) {
        isFirset = YES;
        PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
        [imageManager requestImageForAsset:asset
                                targetSize:PHImageManagerMaximumSize
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info)
         {
             BOOL downloadFinined = ![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && ![[info objectForKey:PHImageResultIsDegradedKey] boolValue];
             if (downloadFinined) {
                 [self.selectedPhotos addObjectsFromArray:@[result]];
                   NSString *nonce  = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];
                 [HelpManager postRequestWithUrl:[NSString stringWithFormat:@"%@?appid=modo&nonce=%@&checksum=%@", MoreUploadImage,nonce, [HelpManager md5HexDigest:[NSString stringWithFormat:@"modo%@", nonce]]] params:nil file:self.selectedPhotos name:@"file" success:^(id json) {
                     NSLog(@"1111%@", json);
                     self.iamges = json[@"items"];
                     
                     
                 } failure:^(NSError *error) {
                     
                     
                 }];
                 uploadNumOfImages--;
             }
             
         }];
    }
    while(uploadNumOfImages > 0) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
//    [self resetFootViewHeight];
    [_imageCollection reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.placeholedLabel.hidden = YES;
    return YES;
}
- (IBAction)nimingAction:(UIButton *)sender {
    sender.selected =!sender.isSelected;
    self.isAnonymous = sender.selected;
}

//- (IBAction)touchAction:(UITapGestureRecognizer *)sender {
//    [self.myTextView resignFirstResponder];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
