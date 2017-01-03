//
//  AddFriendViewController.m
//  IOSYueQiProject
//
//  Created by 敲代码mac1号 on 16/10/26.
//  Copyright © 2016年 敲代码mac1号. All rights reserved.
//

#import "AddFriendViewController.h"
#import "FriendRequestsTableViewCell.h"
#import <AddressBookUI/AddressBookUI.h>
#import "XYLinkManModel.h"
#import "Contactmodel.h"
#import "SendMessageView.h"

@interface AddFriendViewController () <UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UILabel *userIDlabel;
@property (nonatomic , strong) NSMutableArray *linkManArray;

@end

@implementation AddFriendViewController


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        self.dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSMutableArray *)linkManArray {
    if (!_linkManArray) {
        self.linkManArray = [NSMutableArray array];
    }
    return _linkManArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.userIDlabel.text = [NSString stringWithFormat:@"我的局多多账号 : %@", [userDef objectForKey:@"userID"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"login-icon-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"FriendRequestsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    self.title = @"添加好友";
    [HelpManager CheckAddressBookAuthorization:^(bool isAuthorized) {
        if (isAuthorized) {
            NSLog(@"开启");
        } else {
            NSLog(@"未开启");
        }
    }];
    
    int __block tip=0;
    //声明一个通讯簿的引用
    ABAddressBookRef addBook =nil;
    
    ABAddressBookRef addressBookref = ABAddressBookCreateWithOptions(NULL, NULL);
    [self copyAddressBook:addressBookref];

    //因为在IOS6.0之后和之前的权限申请方式有所差别，这里做个判断
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        //创建通讯簿的引用
        addBook = ABAddressBookCreateWithOptions(NULL, NULL);
        //创建一个出事信号量为0的信号
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        //申请访问权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool greanted, CFErrorRef error)        {
            //greanted为YES是表示用户允许，否则为不允许
            if (!greanted) {
                tip=1;
            }
            //发送一次信号
            dispatch_semaphore_signal(sema);
        });
        //等待信号触发
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }else{
        //IOS6之前
        addBook = ABAddressBookCreate();
    }
    if (tip) {
        //做一个友好的提示
        UIAlertView * alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请您设置允许APP访问您的通讯录\nSettings>General>Privacy" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alart show];
        return;
    }
    self.myTableView.rowHeight = 60;

    
}

- (void)copyAddressBook:(ABAddressBookRef)addressBook {
    //获取联系人个数
    CFIndex numberOfPeoples = ABAddressBookGetPersonCount(addressBook);
    CFArrayRef peoples = ABAddressBookCopyArrayOfAllPeople(addressBook);
    NSLog(@"有%ld个联系人", numberOfPeoples);
    //循环获取联系人
    for (int i = 0; i < numberOfPeoples; i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(peoples, i);
        XYLinkManModel *linkMan = [[XYLinkManModel alloc] init];
        linkMan.firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
        linkMan.lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
        linkMan.nickName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonNicknameProperty);
        linkMan.organiztion = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
        linkMan.headImage = (__bridge NSData*)ABPersonCopyImageData(person);
        
        if (linkMan.firstName && linkMan.lastName) {
            linkMan.name = [NSString stringWithFormat:@"%@%@",linkMan.lastName, linkMan.firstName];
        }else if(!linkMan.firstName){
            linkMan.name = linkMan.lastName;
        }else{
            linkMan.name = linkMan.firstName;
        }
        if (!linkMan.name) {
            linkMan.name = linkMan.organiztion;
        }
        if (linkMan.nickName) {
            linkMan.name =[NSString stringWithFormat:@"%@", linkMan.nickName];
        }
        
        //读取电话多值
        NSMutableArray *phoneArray = [[NSMutableArray alloc] init];
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        for (int k = 0; k<ABMultiValueGetCount(phone); k++)
        {
            //获取电话Label
            NSString * personPhoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phone, k));
            //获取該Label下的电话值
            NSString * tempstr = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phone, k);
            NSArray *array = [NSArray arrayWithObjects:tempstr, nil];
            [phoneArray addObject:array];
        }
        linkMan.phones = phoneArray;

        for (NSArray *phone in linkMan.phones) {
            NSString *sstr = [NSString stringWithFormat:@"%@", phone.firstObject];
            NSString *phoneArr = [sstr stringByReplacingOccurrencesOfString:@"-" withString:@""];
            NSString *phoneStr = [NSString stringWithFormat:@"%@", phoneArr];
            if (linkMan.name && phoneStr) {
                NSDictionary *dic = @{@"name":linkMan.name, @"phone":phoneStr};
                [self.linkManArray addObject:dic];
            }
            NSLog(@"%@", phoneStr);
        }
    }
    NSLog(@"%@", self.linkManArray);
    NSDictionary *dic = @{@"items":self.linkManArray};
    [NewWorkingRequestManage requestPostWith:GetContacts parDic:dic finish:^(id responseObject) {
        NSLog(@"%@", responseObject);
        NSArray *modeArr = responseObject[@"items"];
        for (NSDictionary *dicmodel in modeArr) {
            Contactmodel *model = [[Contactmodel alloc] init];
            [model setValuesForKeysWithDictionary:dicmodel];
            if (![model.apply_state isEqualToString:@"1"]) {
                [self.dataSource addObject:model];
            }
        }
        
        [self.myTableView reloadData];
    } error:^(NSError *error) {
        NSLog(@"111%@", [NewWorkingRequestManage newWork].errorStr);
        [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
    }];
}


- (void)back {
    [self dismissViewControllerAnimated: YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendRequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Contactmodel *model = self.dataSource[indexPath.row];
    [cell showConta:model];
    [cell setActionBlock:^(UIButton *sender) {
        Contactmodel *model = [self getModelWith:sender];
        if ([model.apply_state isEqualToString:@"-1"]) {
            return ;
        }
        SendMessageView *sendView = [SendMessageView sendMessageVie];
        [[UIApplication sharedApplication].keyWindow addSubview:sendView];
        [sendView setCancleBlock:^{
            NSString *urlStr = [NSString stringWithFormat:@"%@", ToApplyForFriend];
            NSDictionary *pram = @{@"target_id":model.user_id, @"reason":sendView.MyTextView.text};
            sender.enabled = NO;
            [NewWorkingRequestManage requestPostWith:urlStr parDic:pram finish:^(id responseObject) {
                sender.enabled = YES;
                model.apply_state = @"-1";
                [self.myTableView reloadRowsAtIndexPaths:@[[self getIndexPathWith:sender]] withRowAnimation:UITableViewRowAnimationFade];
                [MBProgressHUD showMessage:@"添加成功" toView:nil];
                NSLog(@"%@", responseObject);
            } error:^(NSError *error) {
               
                [MBProgressHUD showError:[NewWorkingRequestManage newWork].errorStr toView:nil];
                 sender.enabled = YES;
            }];
        }];
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSelector:@selector(deselect) withObject:nil afterDelay:0.5f];
}

- (void)deselect
{
    [self.myTableView deselectRowAtIndexPath:[self.myTableView indexPathForSelectedRow] animated:YES];
}

- (Contactmodel*)getModelWith:(UIButton *)sender {
    FriendRequestsTableViewCell *cell = (FriendRequestsTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    Contactmodel *model = self.dataSource[path.row];
    return model;
}

- (NSIndexPath *) getIndexPathWith:(UIButton *)sender {
    FriendRequestsTableViewCell *cell = (FriendRequestsTableViewCell *)sender.superview.superview;
    NSIndexPath *path = [self.myTableView indexPathForCell:cell];
    return path;
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
