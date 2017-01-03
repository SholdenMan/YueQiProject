//
//  MyInfoViewController.m
//  IOSYueQiProject
//
//  Created by 程磊 on 2016/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MyInfoViewController.h"
#import "PersonalInforCell.h"
#import "PersonalInforCell.h"
#import "PhotoLibraryView.h"
#import <UIImageView+WebCache.h>
#import "ChangeDateView.h"
#import "SexAlterView.h"
#import "ChangeInfoViewController.h"
#import "OptionViewController.h"





@interface MyInfoViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) PersonalInforCell *cell;
@property (nonatomic , strong) UIImage *myImage;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic , strong) NSArray *imageArray;



@end

@implementation MyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatData];
    // Do any additional setup after loading the view from its nib.
}
- (void)creatData{
    self.imageArray = [NSArray array];
    UIBarButtonItem *leftBut = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = leftBut;

}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   PersonalInforCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.photoImage.hidden = YES;
    //cell分割线顶头
    cell.preservesSuperviewLayoutMargins = NO;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.layoutMargins = UIEdgeInsetsZero;
    if (indexPath.section < 1) {
        cell.contentLabel.hidden = YES;
        cell.photoImage.hidden = NO;
        cell.photoImage.layer.cornerRadius = 25;
        cell.photoImage.layer.masksToBounds = YES;
        if (self.myImage) {
            cell.photoImage.image = self.myImage;
        }else{
             [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:self.myModel.head] placeholderImage:[UIImage imageNamed:@"icon-head"]];
        }
       
        cell.categoryLabel.text = @"头像";
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                cell.categoryLabel.text = @"名字";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.myModel.name];
                break;
            case 1:
                cell.categoryLabel.text = @"手机号";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.myModel.phone];
                cell.jiantouIcon.hidden = YES;
                break;
            case 2:
                cell.categoryLabel.text = @"性别";
                if ([self.myModel.sex isEqualToString:@"0"]) {
                    cell.contentLabel.text = @"女";

                }else{
                cell.contentLabel.text = @"男";
                }
                cell.jiantouIcon.hidden = YES;
                break;
            case 3:
                cell.categoryLabel.text = @"生日";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.myModel.birthday];
                break;
            case 4:
                cell.categoryLabel.text = @"常住地";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.district];
                break;
            default:
                break;
        }
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                cell.categoryLabel.text = @"职业";
                cell.contentLabel.text = [NSString stringWithFormat:@"%@", self.myModel.job];
                break;
            case 1:
                cell.categoryLabel.text = @"情感";
                switch ([self.myModel.relationship intValue]) {
                    case 0:
                        cell.contentLabel.text = @"保密";
                        break;
                    case 1:
                        cell.contentLabel.text = @"单身";
                        break;
                    case 2:
                        cell.contentLabel.text = @"恋爱";
                        break;
                    case 3:
                        cell.contentLabel.text = @"已婚";
                        break;
                    case 4:
                        cell.contentLabel.text = @"未婚";
                        break;
                        
                    default:
                        break;
                }
               
                break;
            case 2:
                cell.categoryLabel.text = @"抽烟";
                if ([self.myModel.smoking isEqualToString:@"0"]) {
                    cell.contentLabel.text = @"否";

                }else{
                    cell.contentLabel.text = @"是";
                }
                break;
                
            default:
                break;
        }
    }else{
        cell.categoryLabel.text = @"签名";
        cell.contentLabel.text =[NSString stringWithFormat:@"%@", self.myModel.sign];;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
    if (indexPath.section < 1) {
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
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                [self refreshUserinfor:indexPath pramkey:@"昵称"];
                break;
            case 3:{
                ChangeDateView *changeView = [ChangeDateView changeDateView];
                [changeView.birthdayPicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
                [[UIApplication sharedApplication].keyWindow addSubview:changeView];
                [changeView setFinishBlock:^{
                    [self changeUserinfo:@{@"birthday":self.myModel.birthday}];
                    [self creatData];
                    [self.myTableView reloadData];
                }];

            }
                break;
            case 4:{
                NSLog(@"点击了常住地");
                ChooseCityView *cityView = [ChooseCityView creatChooseCityView];
                [cityView showCancle:nil confirm:^(NSString *country, NSString *city, NSString *street) {
                    
                    NSLog(@"%@, %@, %@", country, city, street);
                    NSLog(@"%@", [NSString stringWithFormat:@"onRegionSelected('%@', '%@')", country, city]);
                    self.myModel.location = [NSString stringWithFormat:@"%@ %@ %@", country, city, street];
                    self.province = country;
                    self.city = city;
                    self.district = street;
                    [self changeUserinfo:@{@"province":country,@"city":city, @"district":street}];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:1];
                    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    
                }];

            }
                break;
            default:
                break;
        }
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                 [self refreshUserinfor:indexPath pramkey:@"职业"];
                break;
            case 1:
            {
                SexAlterView *sexAV = [SexAlterView creatSexAlterView];
                sexAV.titleLabel.text = @"情感状态";
                sexAV.locationArray = @[@"保密", @"单身", @"恋爱", @"已婚", @"未婚"];
                [sexAV showCancle:nil confirm:^(NSInteger sex) {
                    self.myModel.relationship = [NSString stringWithFormat:@"%ld", sex];
                    [self changeUserinfo:@{@"emotion":self.myModel.relationship}];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:2];
                    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }
                break;
            case 2:
            {
                SexAlterView *sexAV = [SexAlterView creatSexAlterView];
                sexAV.titleLabel.text = @"是否抽烟";
                sexAV.locationArray = @[@"是", @"否"];
                [sexAV showCancle:nil confirm:^(NSInteger sex) {
                    if (sex == 0) {
                        self.myModel.smoking = @"1";
                    }else {
                        self.myModel.smoking = @"0";
                    }
                    [self changeUserinfo:@{@"smoking":self.myModel.smoking}];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:2];
                    [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }
                break;
                
            default:
                break;
        }
    }else{
        OptionViewController *optionVC = [[OptionViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:optionVC];
        optionVC.title = @"签名";
        WS(weakSelf);
        [optionVC setSignBlock:^(NSString *sign) {
            weakSelf.myModel.sign = sign;
            [weakSelf changeUserinfo:@{@"sign":sign}];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:3];
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70.0;
    }else{
        return 51.0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 4.0;
}
- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
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
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.myImage = theImage;
    self.imageArray = @[theImage];
    [self.myTableView reloadData];
    //保存到相册
    [self upload];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.hud = [MBProgressHUD showMessag:@"正在上传" toView:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nonce  = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];
    [HelpManager postRequestWithUrl:[NSString stringWithFormat:@"%@?appid=smart_ring&nonce=%@&checksum=%@", UploadImage,nonce, [HelpManager md5HexDigest:[NSString stringWithFormat:@"smart_ring%@", nonce]]] params:nil file:self.imageArray name:@"file" success:^(id json) {
        NSDictionary *headUrl = json;
        self.myModel.head = headUrl[@"url"];
        [self.hud hide:YES afterDelay:0];
        [self changeUserinfo:@{@"portrait":self.myModel.head}];
        [MBProgressHUD showSuccess:@"更新成功" toView:nil];
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error);
        [self.hud hide:YES afterDelay:0];
    }];

}

- (void)upload {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
}
- (void)dateChange:(UIDatePicker *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSLog(@"%@", self.myModel.birthday);
    self.myModel.birthday = [dateFormatter stringFromDate:sender.date];
    NSLog(@"%@", sender.date);
}

- (void)changeUserinfo:(NSDictionary *)pram {
    [NewWorkingRequestManage requestPUTWith:UserUrl parDic:pram finish:^(id responseObject) {
        MyLog(@"%@", responseObject);
        [MBProgressHUD showSuccess:@"修改成功" toView:nil];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    } error:^(NSError *error) {
        
    }];
}
- (void)refreshUserinfor:(NSIndexPath *)indexPath pramkey:(NSString *)pramKey {
    ChangeInfoViewController *changeVC = [[ChangeInfoViewController alloc] init];
    self.cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    changeVC.title = pramKey;
    WS(weakSelf)
    [changeVC setChangeBlock:^(NSString * infor) {
        if ([pramKey isEqualToString:@"昵称"]) {
            weakSelf.myModel.name = infor;
            [weakSelf changeUserinfo:@{@"nick_name":infor}];
            [weakSelf.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    [changeVC setChangeJop:^(NSString *job) {
        weakSelf.myModel.job = job;
        [weakSelf changeUserinfo:@{@"occupation":job}];
        [weakSelf.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:changeVC];
    [self presentViewController:nav animated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
