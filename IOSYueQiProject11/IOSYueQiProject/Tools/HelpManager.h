//
//  HelpManager.h
//  AHXRingApp
//
//  Created by 敲代码mac1号 on 16/8/16.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface HelpManager : NSObject <UIImagePickerControllerDelegate>
@property (nonatomic , assign) BOOL isNetWork;

@property (nonatomic , strong) id controller;
@property (nonatomic , copy) NSString *tag;
@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic , strong) UIWebView *webView;

@property (nonatomic , assign) BOOL isBinding;

+ (HelpManager *)shareHelpManager;

+ (NSString *)md5HexDigest:(NSString *)url;

+ (void)changeBtnNOenabled:(UIButton *)sender;

+ (void)changeBtnenabled:(UIButton *)sender;

+ (NSString *)getDate:(NSString *)dateStr;

- (void)showAlertViewWithController:(id)controller WithWebView:(UIWebView *)webView;


+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

#warning
//判断是否开启通讯录
+(void)CheckAddressBookAuthorization:(void (^)(bool isAuthorized))block;


//判断是否有特殊字符
+ (BOOL)isHaveIllegalChar:(NSString *)str;

//判断是否有中文
+ (BOOL)IsChinese:(NSString *)str;

//按比例缩小图片
+ (UIImage *)scaleImage:(UIImage *)img toScale:(CGFloat )scale;

//按尺寸缩小图片
- (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

//上传图片
+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

//上传音频
+ (void)postAudioRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSString *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

//支付
+ (void)payWithOrder:(NSString *)orderNum WithType:(NSString *)type WithWeb:(id )uicontroller;

//分享
+ (void)shareTitle:(NSString *)title Content:(NSString *)content ImgUrl:(NSString *)imgUrl TargetUrl:(NSString *)targetUrl;

+ (NSInteger )serach:(NSString *)type;

+ (NSString*)stringFromDateString:(NSString*)dates;
//获取当前时间戳
+ (NSString* )getCurrentTimestamp;

//获取请求头部
- (NSString *)getDataWithEvent:(NSString *)event WithUrl:(NSString *)urlStr;

//时间戳转时间
+ (NSString *)getDateStringWithDate:(NSString *)dataStr;
//通过颜色 生成图片
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (NSString *)gettttDate:(NSString *)dateStrr WithFormatter:(NSString *)formatter;
+ (void) refreshToken;
//NSString转NSTimeInterval格式
//+ (NSTimeInterval )changeTypeWith:(NSString *);

//+ (void)postRequestWithUrl:(NSString *)url params:(NSDictionary *)params file:(NSArray *)file name:(NSString *)name success:(void(^)(id json))success failure:(void(^)(NSError *error))failure;

@end
