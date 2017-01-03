//
//  MessageViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageClassViewController.h"
#import "AddFriendViewController.h"
#import "MJRefresh.h"
#import "MessageSingleCell.h"
#import "ChatViewController.h"
#import "UserFMDBHelper.h"
#import "OtherModel.h"

@interface MessageViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, EMContactManagerDelegate, EMClientDelegate, EMChatManagerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
///消息数据源
@property (nonatomic , strong) NSArray *conversations;
@end

@implementation MessageViewController

- (NSArray *)conversations
{
    if (!_conversations) {
        _conversations = [NSArray array];
    }
    return _conversations;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadConversations];
}

-(void)loadConversations{
    //获取历史会话记录
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    if (conversations.count == 0) {
        conversations =  [[EMClient sharedClient].chatManager loadAllConversationsFromDB];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"itemBagValue" object:nil];
    }
    
    self.conversations = [conversations sortedArrayUsingComparator:
                          ^(EMConversation *obj1, EMConversation* obj2){
                              EMMessage *message1 = [obj1 latestMessage];
                              EMMessage *message2 = [obj2 latestMessage];
                              if(message1.timestamp > message2.timestamp) {
                                  return(NSComparisonResult)NSOrderedAscending;
                              }else {
                                  return(NSComparisonResult)NSOrderedDescending;
                              }
                          }];
    
    [self.myTableView.mj_header endRefreshing];
    
    [self.myTableView reloadData];
    
    //显示总的未读数
}
- (void)refresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadConversations];
    }];
    //导航栏下隐藏
    header.automaticallyChangeAlpha = YES;
    self.myTableView.mj_header = header;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [HelpManager refreshToken];

    // Do any additional setup after loading the view.
    self.title = @"消息";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon-messageyy"] style:UIBarButtonItemStyleDone target:self action:@selector(message:)];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-additionyy"] style:UIBarButtonItemStylePlain target:self action:@selector(addAction:)];
    UIBarButtonItem *addresSbook = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-addressbookyy"] style:UIBarButtonItemStylePlain target:self action:@selector(addresSbook:)];
    self.navigationItem.rightBarButtonItems = @[addItem, addresSbook];
    
    self.navigationController.navigationBar.tintColor = Color(51, 51, 51);
    [self.myTableView registerNib:[UINib nibWithNibName:@"MessageSingleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    self.myTableView.tableFooterView = [UIView new];
    // 添加代理监听好友申请回调
    // 注: 此处有坑, 如果写在下面会造成代理方法不走, 程序崩溃, 最后调试放到最上面解决问题
    //登录接口相关的代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    //消息，聊天
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self loadConversations];
    [self refresh];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.rowHeight = 60;
}


//添加好友
- (void)addAction:(UIBarButtonItem *)sender {
    //AddFriendViewController *addFriend = [[UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddFriend"];
    
    UINavigationController *nav =[[UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AddFriendNV"];
    [self presentViewController:nav animated:YES completion:nil];
}

//通讯录
- (void)addresSbook:(UIBarButtonItem *)sender {
    
    UINavigationController *nav =[[UIStoryboard storyboardWithName:@"Second" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"FriendListNV"];
    [self presentViewController:nav animated:YES completion:nil];

}


- (void)message:(UIBarButtonItem *)sender {
    MessageClassViewController *messageClassVC = [[MessageClassViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:messageClassVC];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.conversations.count == 0) {
        self.myImage.hidden = NO;
    } else {
        self.myImage.hidden = YES;
    }
    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EMConversation *conversaion = self.conversations[indexPath.row];

    MessageSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [cell showData:conversaion];
    return cell;
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        EMConversation *conversaion = self.conversations[indexPath.row];
        switch (conversaion.type) {
            case 0:
            {
                ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversaion.conversationId conversationType:EMConversationTypeChat];
                if (conversaion.lastReceivedMessage.ext[@"nickname"]) {
                    chatController.title = conversaion.lastReceivedMessage.ext[@"nickname"];
                } else {
                    NSMutableArray *array = [[UserFMDBHelper shareFMDBHelper] searchMessageModelWith:conversaion.conversationId];
                    OtherModel *model = [array firstObject];
                    chatController.title = model.othername;
                }
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatController];
                [self presentViewController:nav animated:YES completion:nil];
            }
                break;
            case 1:
            {
                ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversaion.conversationId conversationType:EMConversationTypeGroupChat];
                NSMutableArray *array = [[UserFMDBHelper shareFMDBHelper] searchMessageModelWith:conversaion.conversationId];
                OtherModel *model = [array firstObject];
                chatController.title = model.othername;
                
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:chatController];
                [self presentViewController:nav animated:YES completion:nil];
            }
                break;
            default: 
                break;
        }
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
        return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EMConversation *conversaion = self.conversations[indexPath.row];
        NSString *converstationID = conversaion.conversationId;
        // 删除会话
        [[EMClient sharedClient].chatManager deleteConversation:converstationID deleteMessages:YES];
        [self loadConversations];
    }
}



#pragma mark - 接收到消息
- (void)didReceiveMessages:(NSArray *)aMessages
{
    [self loadConversations];
}

#pragma mark - 历史会话列表更新
- (void)didUpdateConversationList:(NSArray *)conversationList{
    //给数据源重新赋值
    self.conversations = conversationList;
    //显示总的未读数
}

- (void)dealloc
{
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].chatManager removeDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
