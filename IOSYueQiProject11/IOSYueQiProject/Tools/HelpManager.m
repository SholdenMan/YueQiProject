//
//  HelpManager.m
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/8/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "HelpManager.h"
#import "PhotoLibraryView.h"
#import <CommonCrypto/CommonDigest.h>
#import "UMSocial.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "AppDelegate.h"
#import "MessageModel.h"
#import <AddressBookUI/AddressBookUI.h>
#import <CommonCrypto/CommonHMAC.h>
#import "SuccessPayViewController.h"
#import "MainTabBarViewController.h"


@interface HelpManager () 


@end

@implementation HelpManager

+ (HelpManager *)shareHelpManager {
    static HelpManager *helpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helpManager = [[HelpManager alloc] init];
    });
    return helpManager;
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



+ (void)payWithOrder:(NSString *)orderNum WithType:(NSString *)type WithWeb:(UIViewController * )uicontroller{
    if ([type isEqualToString:@"0"]) {
        //支付宝
        NSString *url = [NSString stringWithFormat:@"%@%@", Alipay, orderNum];
        [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
            NSString *orderString = responseObject[@"order_string"];
            NSString *appScheme = @"IOSYueQi";
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"支付的结果:*********reslut = %@",resultDic);
                NSString *result = [NSString stringWithFormat:@"%@", resultDic[@"resultStatus"]];
                if ([result isEqualToString:@"9000"]) {
                    MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
                    [uicontroller presentViewController:successVC animated:YES completion:nil];
                    return;
                }else {
                    //支付失败 返回
                    
                }
            }];
        } error:^(NSError *error) {
            
        }];
    }
    
    if ([type isEqualToString:@"1"]) {
        //微信
        NSString *url = [NSString stringWithFormat:@"%@%@", WXpay, orderNum];
        [NewWorkingRequestManage requestGetWith:url parDic:nil finish:^(id responseObject) {
            NSDictionary *json = responseObject;
            NSLog(@"%@", json);
            PayReq *request = [[PayReq alloc] init] ;
            request.partnerId = [NSString stringWithFormat:@"%@", json[@"partnerid"]];
            request.prepayId = [NSString stringWithFormat:@"%@", json[@"prepayid"]];
            request.package = [NSString stringWithFormat:@"%@", json[@"package"]];
            request.nonceStr= [NSString stringWithFormat:@"%@", json[@"noncestr"]];
            request.timeStamp = [[NSString stringWithFormat:@"%@", json[@"timestamp"]] intValue];
            request.sign = [NSString stringWithFormat:@"%@", json[@"sign"]];
            BOOL isPay =  [WXApi sendReq:request];
            if (isPay) {
                MainTabBarViewController *successVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"main"];
//                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:successVC];
                [uicontroller presentViewController:successVC animated:YES completion:nil];
            }
        } error:^(NSError *error) {
            
        }];
    }
    
}


+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block
{
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    ABAuthorizationStatus authStatus = ABAddressBookGetAuthorizationStatus();
    
    if (authStatus != kABAuthorizationStatusAuthorized)
    {
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         if (error)
                                                         {
                                                             NSLog(@"Error: %@", (__bridge NSError *)error);
                                                         }
                                                         else if (!granted)
                                                         {
                                                             
                                                             block(NO);
                                                         }
                                                         else
                                                         {
                                                             block(YES);
                                                         }
                                                     });
                                                 });
    }
    else
    {
        block(YES);
    }
    
}

//MD5加密算法
+ (NSString *)md5HexDigest:(NSString *)url
{
    const char *original_str = [url UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}


+ (void)changeBtnNOenabled:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_nextN"] forState:UIControlStateNormal];
    sender.enabled = NO;
}

+ (void)changeBtnenabled:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"bg_next"] forState:UIControlStateNormal];
    sender.enabled = YES;
}

+ (BOOL)isHaveIllegalChar:(NSString *)str{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)@_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location < str.length;
}



//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}



+ (NSString *)getDate:(NSString *)dateStr {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue] / 1000];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

//按比例缩小图片
+ (UIImage *)scaleImage:(UIImage *)img toScale:(CGFloat )scale {
    CGSize imgSize = img.size;
    CGSize scaleSize = CGSizeMake(imgSize.width*scale, imgSize.height*scale);
    
    UIGraphicsBeginImageContext(scaleSize);
    [img drawInRect:CGRectMake(0, 0, imgSize.width*scale, imgSize.height*scale)];
    
    UIImage * scaleImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImg;
}

//按尺寸缩小图片
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width) * height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  上传多张图片
 *
 *  @param url     接口地址
 *  @param params  上传的参数
 *  @param file    图片数组
 *  @param name    图片传@"image"/
 *  @param success 成功block
 *  @param failure 失败block
 */

+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
{
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //发起请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger ID = 100;
        //将UIImage转换为NSData
        for (UIImage *images in file) {
            //压缩比例
            NSData *data = UIImageJPEGRepresentation(images, 0.01);
            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%ld.jpg",(long)ID] mimeType:@"image/jpeg"];
            ID++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        MyLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"%@", responseObject);
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
            } else {
                success(responseObject);
            }
        }
        //上传成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    //添加到操作队列
}


//上传音频文件
+ (void)postAudioRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSString *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure {
    //创建管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //发起请求
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = [NSData dataWithContentsOfFile:file];
        [formData appendPartWithFileData:data name:name fileName:@"mp3" mimeType:@"audio/mpeg3"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        MyLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MyLog(@"%@", responseObject);
        if (success) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                success(result);
            } else {
                success(responseObject);
            }
        }
        //上传成功
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //上传失败
        if (failure) {
            failure(error);
        }
    }];
    //添加到操作队列
}


+ (void)shareTitle:(NSString *)title Content:(NSString *)content ImgUrl:(NSString *)imgUrl TargetUrl:(NSString *)targetUrl {
    [UMSocialData defaultData].extConfig.title = @"珠宝连接你的情感";
    UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:
                                        ShareUrl];
    ShareView *share = [ShareView shareViewQQShare:^{
        MyLog(@"QQ分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:ShareUrl image:[UIImage imageWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"icon96" ofType:@"png"]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    } WeiChatShare:^{
        MyLog(@"微信分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:ShareUrl image:[UIImage imageWithData:[NSData dataWithContentsOfFile:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"icon96" ofType:@"png"]]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    } WeiBoShare:^{
        MyLog(@"微博分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:ShareUrl image:[UIImage imageWithData:[NSData dataWithContentsOfFile:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"icon96" ofType:@"png"]]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    } FriendShare:^{
        MyLog(@"朋友圈分享");
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:ShareUrl image:[UIImage imageWithData:[NSData dataWithContentsOfFile:[NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"icon96" ofType:@"png"]]]] location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
            if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                MyLog(@"分享成功！");
            }
        }];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:share];
}









- (void)showAlertViewWithController:(id)controller WithWebView:(UIWebView *)webView{
    self.controller = controller;
    self.webView = webView;
    dispatch_async(dispatch_get_main_queue(), ^{
        //更改头像
        PhotoLibraryView *photoLibView = [[PhotoLibraryView alloc] init];
        photoLibView.viewController = self.controller;
        [photoLibView.buttonOne setTitle:@"拍照" forState:UIControlStateNormal];
        [photoLibView.buttonOne setTitleColor:Color(245, 81, 30) forState:UIControlStateNormal];
        [photoLibView.buttonTwo setTitle:@"选择相册" forState:UIControlStateNormal];
        [photoLibView.buttonTwo setTitleColor:Color(245, 81, 30) forState:UIControlStateNormal];
        
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
    });
    
}

/** 打开照相机 */
- (void)openCrema
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self.controller presentViewController:ipc animated:YES completion:nil];
}
/** 打开相册 */
- (void)openPictureLibrary
{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.allowsEditing = YES;
    ipc.delegate = self;
    [self.controller presentViewController:ipc animated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    UIImage *theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //保存到相册
    NSArray *array = @[theImage];
    [self upload:array];
    [self.controller dismissViewControllerAnimated:YES completion:nil];

}

- (void)upload:(NSArray *)array {
    self.hud = [MBProgressHUD showMessag:@"正在上传" toView:nil];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *nonce  = [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970] * 1000];
    [HelpManager postRequestWithUrl:[NSString stringWithFormat:@"%@?appid=smart_ring&nonce=%@&checksum=%@", UploadImage,nonce, [HelpManager md5HexDigest:[NSString stringWithFormat:@"smart_ring%@", nonce]]] params:nil file:array name:@"file" success:^(id json) {
        NSString *headUrl = json[@"url"];
        [NewWorkingRequestManage requestPUTWith:@"" parDic:@{@"bg_image":headUrl} finish:^(id responseObject) {
            [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"onBackgroundSelected('%@')", headUrl]];
        } error:^(NSError *error) {
            
        }];
        [self.hud hide:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
        [self.hud hide:YES afterDelay:0];
    }];
    
}


+ (NSInteger )serach:(NSString *)type {
    NSArray *array = [[FMDBHelper shareFMDBHelper] searchMessageModelWith:type];
    NSMutableArray *unreadArray = [NSMutableArray array];
    for (MessageModel *model in array) {
        if ([model.isRead isEqualToString:@"0"]) {
            [unreadArray addObject:model];
        }
    }
    return  unreadArray.count;
}


//获取当前时间戳
+ (NSString* )getCurrentTimestamp{
    
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    
    NSTimeInterval a=[dat timeIntervalSince1970];
    
    NSString*timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    
    return timeString;
    
}

static NSDateFormatter* formater = nil;
+ (NSString*)stringFromDateString:(NSString *)dates {
    
    NSString *date = [self gettttDate:dates];
    NSLog(@"%@", date);//2016-06-30 17:06 //2016-06-30 17:25:41
    
    if(!formater) {
        formater = [[NSDateFormatter alloc]init];
        [formater setDateFormat:@"MM月dd日HH时mm"];
        // [formater setLocale:[NSLocale systemLocale]];
    }
    
    //获得现在的年月日,小时，分钟
    NSDate* nowDate = [NSDate date];
    
    [formater setDateFormat:@"MM月dd日HH时mm"];
    
    //发布时间
    NSLog(@"%@", date);
    NSLog(@"%@", formater);
    NSDate* pubDate = [formater dateFromString:date];
    NSLog(@"%@", pubDate);
    //如果发布时间比现在的时间还大，直接显示刚刚
    if ([pubDate compare:nowDate] == NSOrderedDescending)
        return @"刚刚";
    
    //时间差
    NSTimeInterval delta = [nowDate timeIntervalSinceDate:pubDate];
    
    if(delta<60){
        //小于60秒
        return @"刚刚";
    }else if (delta<3600){
        //一小时以内
        return [NSString stringWithFormat:@"%.0f分钟前",delta/60.0f];
    }else if (delta<3600*24){
        //24小时内
        return [NSString stringWithFormat:@"%.0f小时前",delta/3600.0f ];
    }else{
        [formater setDateFormat:@"MM/dd"];
        return [formater stringFromDate:pubDate];
    }
    
}

+ (NSString *)gettttDate:(NSString *)dateStrr {
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStrr doubleValue] / 1000];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:@"MM月dd日HH时mm"];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

/**
 *  获取请求头部
 */
- (NSString *)getDataWithEvent:(NSString *)event WithUrl:(NSString *)urlStr{
    NSString *once = [NSString stringWithFormat:@"%@:%@", [HelpManager getDateStr], [self getRandom]];
    NSURL *U = [NSURL URLWithString:urlStr];
    NSString *dataStr = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n", once, event, [self getURL:U], [self getWithUrl:U]];
    NSString *token = [userDef objectForKey:@"token"];
    NSString *str = [NSString stringWithFormat:@"MAC id=\"%@\",nonce=\"%@\",mac=\"%@\"", token, once, [self getHeadStrWithData:dataStr]];
    NSLog(@"dataStr:%@", dataStr);
    NSLog(@"%@", str);
    return str;
}

- (NSString *)getHeadStrWithData:(NSString *)data {
    NSString *key = [userDef objectForKey:@"Mackey"];
    const char *cKey = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *hash = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *s= [self base64forData:hash];
    return s;
}
//加密方法
- (NSString *)base64forData:(NSData *)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {  value |= (0xFF & input[j]);  }  }  NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

//获取url域名
- (NSString *)getWithUrl:(NSURL *)url {
    NSLog(@"%@", url.port);
    if (url.port) {
        if ([url.port isEqualToNumber:@80]) {
            return url.host;
        } else {
            return [NSString stringWithFormat:@"%@:%@", url.host, url.port];
        }
    } else {
        return url.host;
    }
}

//获取url地址
//- (NSString *)getURL:(NSURL *)url {
//    if (!url.query) {
//        return url.relativePath;
//    } else {
//        return [NSString stringWithFormat:@"%@?%@", url.relativePath,url.query];
//    }
//}
//获取url地址
- (NSString *)getURL:(NSURL *)url {
    if (!url.query) {
        return url.path;
    } else {
        return [NSString stringWithFormat:@"%@?%@", url.path,url.query];
    }
}

//获取随机值
- (NSString *)getRandom {
    NSMutableString *string1 = [[NSMutableString alloc]initWithCapacity:8];
    for (int i = 0; i < 8; i++) {
        [string1 insertString:[NSString stringWithFormat:@"%d", arc4random()%10] atIndex:i];
    }
    return string1;
}

/**
 *  获取请求头部
 */

+ (NSString *)getDateStr {
    NSString *str = [NSString stringWithFormat:@"%.lf", [[NSDate date] timeIntervalSince1970] * 1000];
    return  str;
}

// 时间戳转时间
+ (NSString *)getDateStringWithDate:(NSString *)dataStr{
    // dataStr时间戳
    NSTimeInterval time=[dataStr doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //    NSLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:@"MM月dd日HH时mm"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
+ (NSString *)gettttDate:(NSString *)dateStrr WithFormatter:(NSString *)formatter{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dateStrr doubleValue] / 1000];
    NSDateFormatter *DATEFormatter = [[NSDateFormatter alloc] init];
    [DATEFormatter setDateFormat:formatter];
    NSString *getdateStr = [DATEFormatter stringFromDate:confromTimesp];
    return getdateStr;
}

//NSString转NSTimeInterval格式
//+ (NSTimeInterval )changeTypeWith:(NSString *){
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    
//    [formatter setDateFormat:@"YY年MM月dd日HH时mm分ss秒"];
//    NSDate *date =[dateFormat dateFromString:];
//    
//    
//    
//}

//+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure
//{
//    //创建管理者
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    //发起请求
//    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSInteger ID = 100;
//        //将UIImage转换为NSData
//        for (UIImage *images in file) {
//            //压缩比例
//            NSData *data = UIImageJPEGRepresentation(images, 0.01);
//            [formData appendPartWithFileData:data name:name fileName:[NSString stringWithFormat:@"%ld.jpg",(long)ID] mimeType:@"image/jpeg"];
//            ID++;
//        }
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        //上传进度
//        MyLog(@"%lld", uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        MyLog(@"%@", responseObject);
//        if (success) {
//            if ([responseObject isKindOfClass:[NSData class]]) {
//                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//                success(result);
//            } else {
//                success(responseObject);
//            }
//        }
//        //上传成功
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //上传失败
//        if (failure) {
//            failure(error);
//        }
//    }];
//    //添加到操作队列
//}

+ (void) refreshToken {
    [NewWorkingRequestManage requestGetWith:TokenUrl parDic:nil finish:^(id responseObject) {
        [userDef setObject:responseObject[@"mac_key"] forKey:@"Mackey"];
        [userDef setObject:responseObject[@"access_token"] forKey:@"token"];
    } error:^(NSError *error) {
        
    }];
}

@end
