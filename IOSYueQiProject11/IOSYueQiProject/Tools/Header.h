//
//  Header.h
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/25.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define UploadFile @"http://static.binvshe.com:2016/res/"

#define YueQiApp @"http://17178.xmappservice.com"

#import "BaseViewController.h"
#import "LgAccount.h"
#import "ChooseCityView.h"
#import "SexAlterView.h"
#import "SheetAlertView.h"
#import "ChangeDateView.h"
#import "NIDropDown.h"
#import "UMSocial.h"
#import "SendMessageView.h"
#import "ShowAlertView.h"


#define AColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define APPGreenColor Color(14 , 178, 181)

#define TheW [UIScreen mainScreen].bounds.size.width
#define TheH [UIScreen mainScreen].bounds.size.height

#define MyLog(...) NSLog(__VA_ARGS__)

#define userDef [NSUserDefaults standardUserDefaults]

//上传图片
#define UploadImage [NSString stringWithFormat:@"%@upload", UploadFile]

//支付宝支付
#define Alipay [NSString stringWithFormat:@"%@/app/alipay/", YueQiApp]

//微信支付
#define WXpay [NSString stringWithFormat:@"%@/app/wxpay/",YueQiApp]


//分享地址
#define ShareUrl [NSString stringWithFormat:@"%@", @"http://47.90.47.195:8888/smart-ring/static/download/index.html"]

//登录
#define MyLogin [NSString stringWithFormat:@"%@/v1.0/app/user/login", YueQiApp]
//注册
#define MyRegister [NSString stringWithFormat:@"%@/v1.0/app/user/register", YueQiApp]
//用户检测
#define UserCheak [NSString stringWithFormat:@"%@/v1.0/app/user/exists/", YueQiApp]

//忘记密码
#define ForgetPassword [NSString stringWithFormat:@"%@/v1.0/app/user/password/forget", YueQiApp]

//个人信息请求
#define UserInfo [NSString stringWithFormat:@"%@/v1.0/app/user/", YueQiApp]

//个人数据
#define UserUrl  [NSString stringWithFormat:@"%@/v1.0/app/user", YueQiApp]
//修改密码
#define ChangePassword [NSString stringWithFormat:@"%@/v1.0/app/user/password", YueQiApp]

//茶店详情
#define TeaListUrl [NSString stringWithFormat:@"%@/v1.0/app/stores?", YueQiApp]

//申请加入约局
#define ApplyUrl [NSString stringWithFormat:@"%@/v1.0/app/game/", YueQiApp]

//附近茶馆
#define NearShopUrl [NSString stringWithFormat:@"%@/v1.0/app/stores/nearby?", YueQiApp]
//发现茶馆
#define FindUrl  [NSString stringWithFormat:@"%@/v1.0/app/discovery", YueQiApp]

//我的收藏
#define FavoriteUrl  [NSString stringWithFormat:@"%@/v1.0/app/stores/favorite?", YueQiApp]
//更新经纬度
#define UpdateLocation [NSString stringWithFormat:@"%@/v1.0/app/user/coords", YueQiApp]

//评论列表
#define getCommentList [NSString stringWithFormat:@"%@/v1.0/app/comment/increment", YueQiApp]
//我的约局
#define MySponsorUrl  [NSString stringWithFormat:@"%@/v1.0/app/games/history?", YueQiApp]

//删除我的收藏
#define DeleteFavoriteUrl [NSString stringWithFormat:@"%@/v1.0/app/user/event/favorite/store/", YueQiApp]

//我的积分
#define MyIntegralUrl [NSString stringWithFormat:@"%@/v1.0/app/score/logs?", YueQiApp]

//踢出成员
#define KickOutUrl [NSString stringWithFormat:@"%@/v1.0/app/game/", YueQiApp]

//生成订单
#define makeOrder [NSString stringWithFormat:@"%@/v1.0/app/store/", YueQiApp]



/**
 *  消息接口
 */


//用户列表
#define UserList [NSString stringWithFormat:@"%@/v1.0/app/user", YueQiApp]

//好友列表
#define FriendList [NSString stringWithFormat:@"%@/v1.0/app/friends", YueQiApp]

//添加好友
#define ToApplyForFriend [NSString stringWithFormat:@"%@/v1.0/app/friend/apply", YueQiApp]

//好友申请
#define ThroughTheApplication [NSString stringWithFormat:@"%@/v1.0/app/friend/apply", YueQiApp]

//好友信息
#define GetUserInfor [NSString stringWithFormat:@"%@/v1.0/app/user", YueQiApp]

//通讯录
#define GetContacts [NSString stringWithFormat:@"%@/v1.0/app/contacts", YueQiApp]

//创建约局
#define CreatTeaUrl [NSString stringWithFormat:@"%@/v1.0/app/games", YueQiApp]

//刷新token值
#define TokenUrl [NSString stringWithFormat:@"%@/v1.0/app/user/token/refresh", YueQiApp]

//token常量  一天
#define timeDay 86400000

//我的优惠券
#define CouponsUrl [NSString stringWithFormat:@"%@/v1.0/app/coupons?", YueQiApp]

//我的订单
#define MyOrderUrl [NSString stringWithFormat:@"%@/v1.0/app/orders?", YueQiApp]

///邀请我的
#define InviteMeUrl [NSString stringWithFormat:@"%@/v1.0/app/games/invite/me", YueQiApp]
///门店详情
#define ShopDetailUrl [NSString stringWithFormat:@"%@/v1.0/app/stores/", YueQiApp]

///获取订单详情
#define getOrderUrl [NSString stringWithFormat:@"%@/v1.0/app/orders/game/", YueQiApp]

///根据订单去查找
#define getOrder_noUrl [NSString stringWithFormat:@"%@/v1.0/app/orders/", YueQiApp]
//获取包厢详情
#define getBoxDetail [NSString stringWithFormat:@"%@/v1.0/app/store/", YueQiApp]    

//茶点正餐
#define getGoodClass [NSString stringWithFormat:@"%@/v1.0/app/store/", YueQiApp]
//上传图片
#define UploadImage [NSString stringWithFormat:@"%@upload", UploadFile]

//批量上传
#define MoreUploadImage [NSString stringWithFormat:@"%@upload/multi", UploadFile]
/**
 * end
 */
///消息类型
#define MSG_FRIEND_REQUEST [NSString stringWithFormat:@"100"]   ///好友申请

#define MSG_FRIEND_REQUEST_REJECTED [NSString stringWithFormat:@"101"]   ///好友申请被拒绝

#define MSG_FRIEND_REQUEST_ACCEPTED [NSString stringWithFormat:@"102"]   ///好友申请被同意


/**
 *  约局接口
 */
#define GetPartyLis [NSString stringWithFormat:@"%@/v1.0/app/games", YueQiApp]
/**
 * end
 */

///发现购买包厢
#define BuyUrl [NSString stringWithFormat:@"%@/v1.0/app/store", YueQiApp]


///消息类型
#define MSG_SYSTEM_NORMAL [NSString stringWithFormat:@"0"] ///系统消息

#define MSG_FRIEND_REQUEST [NSString stringWithFormat:@"100"]   ///好友申请

#define MSG_FRIEND_REQUEST_REJECTED [NSString stringWithFormat:@"101"]   ///好友申请被拒绝

#define MSG_FRIEND_REQUEST_ACCEPTED [NSString stringWithFormat:@"102"]   ///好友申请被同意
/**
 * 约局申请
 */
#define MSG_TYPE_GAME_APPLY [NSString stringWithFormat:@"200"]

/**
 * 同意加入约局申请
 */
#define MSG_TYPE_GAME_APPLY_PASS [NSString stringWithFormat:@"201"]


/**
 * 拒绝加入约局申请
 */
#define MSG_TYPE_GAME_APPLY_REFUSE [NSString stringWithFormat:@"202"]


/**
 * 约局邀请
 */
#define MSG_TYPE_GAME_INVITE [NSString stringWithFormat:@"203"]


/**
 * 同意约局邀请
 */
#define MSG_TYPE_GAME_INVITE_PASS [NSString stringWithFormat:@"204"]



/**
 * 拒绝约局邀请
 */
#define MSG_TYPE_GAME_INVITE_REFUSE [NSString stringWithFormat:@"205"]


/**
 * 加入约局通知（通知其他人）
 */
#define MSG_TYPE_GAME_JOIN [NSString stringWithFormat:@"206"]


/**
 * 退出约局
 */
#define MSG_TYPE_GAME_EXIT [NSString stringWithFormat:@"207"]


/**
 * 移除用户
 */
#define MSG_TYPE_GAME_REMOVE_MEMBER [NSString stringWithFormat:@"208"]


/**
 * 解散
 */
#define MSG_TYPE_GAME_DISSOLVE [NSString stringWithFormat:@"209"]


/**
 * 选定茶馆生成订单
 */
#define MSG_TYPE_GAME_ORDER [NSString stringWithFormat:@"210"]


/**
 * 约局成员支付成功
 */
#define MSG_TYPE_GAME_MEMBER_PAY_SUCCESS [NSString stringWithFormat:@"211"]


/**
 * 约局支付成功
 */
#define MSG_TYPE_GAME_PAY_SUCCESS [NSString stringWithFormat:@"212"]


/**
 *发布评论
 */
#define CommentUrl [NSString stringWithFormat:@"%@/v1.0/app/comment", YueQiApp]


//包厢续费信息
#define getBoxRenewalInfor [NSString stringWithFormat:@"%@/v1.0/app/games/", YueQiApp]

//收藏
#define MyFavoriteUrl [NSString stringWithFormat:@"%@/v1.0/app/user/event/favorite/store/", YueQiApp]

//删除订单
#define DeleOrderUrl [NSString stringWithFormat:@"%@/v1.0/app/orders/", YueQiApp]
//约局详情
#define TeaDetailUrl [NSString stringWithFormat:@"%@/v1.0/app/games/", YueQiApp]

//呼叫茶水
#define CallteaUrl [NSString stringWithFormat:@"%@/v1.0/app/games/", YueQiApp]
//使用优惠券
#define UserCouponUrl [NSString stringWithFormat:@"%@/v1.0/app/orders/", YueQiApp]
//举报接口
#define ReportUrl [NSString stringWithFormat:@"%@/v1.0/app/feedback", YueQiApp]
//使用优惠券
#define UseCouponsUrl [NSString stringWithFormat:@"%@/v1.0/app/orders/", YueQiApp]


#endif /* Header_h */
