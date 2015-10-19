//
//  StatusDetailTableViewController.m
//  GouDa
//
//  Created by 张威 on 15/9/27.
//  Copyright © 2015年 zhangwei. All rights reserved.
//

#import "StatusDetailTableViewController.h"
//#import "FirstStatusCommentTableViewCell.h"
#import "TriangleStatusTableViewCell.h"
#import "CommonStatusCommentTableViewCell.h"
#import "AppHTTPSessionManager+Quan.h"
#import "MainNavigationController.h"
#import "Status.h"
#import "ZWCommentInputView.h"
#import "StatusWithoutPhotoTableViewCell.h"
#import "RepliesModel.h"
#import "UIView+App.h"

@interface StatusDetailTableViewController ()
<UITableViewDataSource, UITableViewDelegate, ZWCommentInputViewDelegate, StatusTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

//@property (nonatomic, strong) StatusWithoutPhotoView *statusView;


////////////////////////////// 评论框 //////////////////////////////
@property (nonatomic, strong) ZWCommentInputView *commentInputView;

@property (nonatomic, strong) UIView *emotionManagerView;
@property (nonatomic, assign) ZWInputViewType textViewInputViewType;

@property (nonatomic, strong) RepliesModel *replyModel;

#define kFaceManageViewHeight     (200.f)

@end

@implementation StatusDetailTableViewController {
//    CGFloat kCommentInputViewHeight;
}

static NSString * const statusBodyCellIdentifier          = @"statusBodyCellIdentifier";
static NSString * const statusFirstCommentCellIdentifier  = @"statusFirstCommentCellIdentifier";
static NSString * const statusCommonCommentCellIdentifier = @"statusCommonCommentCellIdentifier";

- (void)loadView {
    self.view =
    [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth,
                                             mainScreenHeight-statusBarHeight-navigationBarHeight)];
    
    self.tableView =
    [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth,
                                                  mainScreenHeight - navigationBarHeight - statusBarHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (void)initViews {
    
    // navigation bar
    self.navigationItem.leftBarButtonItem =
    [UIView barButtonItemWithImage:[UIImage imageNamed:@"ic_return.png"]
                            target:self
                            action:@selector(leftBarButtonItemClicked:)];
    
    self.tableView.tableFooterView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainScreenWidth, tableFooterViewHeight)];
        view;
    });
    
    CGFloat commentViewFixedHeight = [ZWCommentInputView initalHeight];
    self.commentInputView =
    [[ZWCommentInputView alloc] initWithOrigin:CGPointMake(0, self.view.frame.size.height - commentViewFixedHeight)];
    self.commentInputView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initViews];
    
    self.title = @"动态详情";
    
//    kCommentInputViewHeight = [ZWCommentInputView initalHeight];
    
    // configure table view
    [self.tableView registerClass:[StatusWithoutPhotoTableViewCell class]
           forCellReuseIdentifier:statusBodyCellIdentifier];
    [self.tableView registerClass:[TriangleStatusTableViewCell class]
           forCellReuseIdentifier:statusFirstCommentCellIdentifier];
    [self.tableView registerClass:[CommonStatusCommentTableViewCell class]
           forCellReuseIdentifier:statusCommonCommentCellIdentifier];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view
    // be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view
    // is set to a non-zero value.
    // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath:
    // for every row in the table on first load;
    // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
    self.tableView.estimatedRowHeight = 88.f;
    
    // Self-sizing table view cells in iOS 8 require that the rowHeight property of the table view
    // be set to the constant UITableViewAutomaticDimension
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // load detail
    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];
    WeakSelf(weakSelf);
    
    [httpManager statusReplyListWithID:self.status.statusID
                             pageIndex:0
                          countPerPage:2000
                               success:^(NSDictionary *resultDic) {
                                   
                                   StrongSelf(strongSelf);
                                   
                                   strongSelf.replyModel = [[RepliesModel alloc] initWithDictionary:resultDic];
                                   
                                   [strongSelf.tableView reloadData];
                               }
                               failure:^(NSError *error) {
                                   [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                               }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // add keyboard notification observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - ZWCommentInputViewDelegate

- (void)inputView:(ZWCommentInputView *)inputView didSendEmotionStateChanged:(BOOL)selected {
    
    if (!selected) {    // 取消「表情选择器」
        // 1. update input view type
        self.textViewInputViewType = ZWInputViewTypeText;
        
        // 2. hide face manage view
        if (self.emotionManagerView.superview != nil) {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 self.emotionManagerView.alpha = 0.0;
                             }
                             completion:^(BOOL finished) {
                                 self.emotionManagerView.transform = CGAffineTransformIdentity;
                                 if (self.emotionManagerView.superview) {
                                     [self.emotionManagerView removeFromSuperview];
                                 }
                             }];
        }
        // 3. active keyboard
        [self.commentInputView.inputView becomeFirstResponder];
        
    } else {
        // 1. update input view type
        self.textViewInputViewType = ZWInputViewTypeEmotion;
        
        // 2. resign input view responder
        [self.commentInputView.inputView resignFirstResponder];
        
        // 3. init face manage view
        self.emotionManagerView.transform = CGAffineTransformIdentity;
        self.emotionManagerView.alpha = 1.0;
        if (self.emotionManagerView.superview == nil) {
            [self.view addSubview:self.emotionManagerView];
        }
        [self.view bringSubviewToFront:self.emotionManagerView];
        
        // 4. update input view position
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.commentInputView.transform =
                             CGAffineTransformMakeTranslation(0, 0 - self.emotionManagerView.frame.size.height);
                             
                             self.tableView.contentInset =
                             UIEdgeInsetsMake(0, 0,
                                              self.emotionManagerView.frame.size.height+
                                              self.commentInputView.frame.size.height, 0);
                         }
                         completion:^(BOOL finished) {
                             
                         }];
    }
}

- (BOOL)inputViewShouldReturn:(ZWCommentInputView *)inputView {
    DLog(@"发送评论：%@", inputView.inputView.text);
    
    NSString *content = inputView.inputView.text;
    
    // 去掉两端的空白字符
    content = [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (content.length == 0) {
        return YES;
    }
    
    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];

    MainNavVC(mainNavigationController);
    
    WeakSelf(weakSelf);
    [httpManager replyStatusWithUserID:mainNavigationController.userInfo.userID
                              statusID:self.status.statusID
                               content:content
                             repliedID:nil
                               success:^(NSDictionary *resultDic) {
                                   
                                   NSString *replyID = [resultDic objectForKey:@"reply_id"];
                                   if (![replyID isKindOfClass:[NSString class]] || replyID.length <= 0) {
                                       [SVProgressHUD showInfoWithStatus:@"服务器异常"];
                                       return;
                                   }
                                   
                                   // 构建一个新的replyID
                                   StatusReply *reply =
                                   [[StatusReply alloc] initWithID:replyID
                                                           content:content
                                                           senerID:mainNavigationController.userInfo.userID
                                                        senderNick:mainNavigationController.userInfo.nick
                                             senderAvatarURLString:mainNavigationController.userInfo.avatarURLString
                                                         repliedID:nil
                                                       repliedNick:nil
                                                        timeString:@"假时间"];
                                   StrongSelf(strongSelf);
                                   [strongSelf insertReplyAtTopAndRefreshTableView:reply];
                                   
                               }
                               failure:^(NSError *error) {
                                   [SVProgressHUD showInfoWithStatus:error.localizedDescription];
                               }];
    return YES;
}

- (void)insertReplyAtTopAndRefreshTableView:(StatusReply *)reply {
    [self.replyModel insertReply:reply atIndex:0];
    
    if (self.replyModel.count > 1) {
        [self.tableView beginUpdates];
        NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:2];
        [self.tableView insertRowsAtIndexPaths:@[indexPath1]
                                    withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        
        [self.tableView beginUpdates];
        NSIndexPath *indexPath2 = [NSIndexPath indexPathForItem:1 inSection:2];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath2]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    } else {
        [self.tableView reloadData];
    }
}

#pragma mark - notification observer handles

// keyboard will show
- (void)keyBoardWillShow:(NSNotification *)notification {
    
    CGRect keyBoardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY = keyBoardRect.size.height;
    //    NSLog(@"keyBoardWillShow, superView = %@ keyBoardHeight = %f",
    //          [[self.commentInputView.superview class] description], deltaY);
    CGFloat inputViewHeight = self.inputView.frame.size.height;
    if (inputViewHeight < 0.1f) {
        inputViewHeight = [ZWCommentInputView initalHeight];
    }
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]
                     animations:^{
                         self.commentInputView.transform = CGAffineTransformMakeTranslation(0, -deltaY);
                         
                         self.tableView.contentInset = UIEdgeInsetsMake(0, 0, deltaY + inputViewHeight, 0);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

// keyboard will hide
- (void)keyBoardWillHide:(NSNotification *)notification {
    //    NSLog(@"keyBoardWillHide, superView = %@", [[self.commentInputView.superview class] description]);
    if (self.textViewInputViewType == ZWInputViewTypeText) {
        CGFloat inputViewHeight = self.commentInputView.frame.size.height;
        [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]
                         animations:^{
                             self.commentInputView.transform =
                             CGAffineTransformMakeTranslation(0, inputViewHeight);
                             
                             self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                         }
                         completion:^(BOOL finished) {
                             self.commentInputView.transform = CGAffineTransformIdentity;
                             [self.commentInputView prepareForReuse];
                             [self.commentInputView removeFromSuperview];
                         }];
        self.textViewInputViewType = ZWInputViewTypeNormal;
    }
}

- (void)hideAllInputViewWithCompletion:(void (^ __nullable)(void))completion {
    if (self.commentInputView.superview == nil) {
        self.textViewInputViewType = ZWInputViewTypeNormal;
        
        if (completion) {
            completion();
        }
        
        return;
    }
    
    if (self.textViewInputViewType == ZWInputViewTypeText) {
        
        NSAssert(self.commentInputView.inputView.isFirstResponder, @"some error");
        // hide keyboard
        [self.commentInputView.inputView resignFirstResponder];
        
        if (completion) {
            completion();
        }
        
    } else if (self.textViewInputViewType == ZWInputViewTypeEmotion) {
        CGFloat inputViewHeight = self.inputView.frame.size.height;
        // hide face manage view and input view
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.commentInputView.transform =
                             CGAffineTransformMakeTranslation(0, inputViewHeight);
                             self.emotionManagerView.transform =
                             CGAffineTransformMakeTranslation(0, self.emotionManagerView.frame.size.height+
                                                              inputViewHeight);
                             
                             self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                         }
                         completion:^(BOOL finished) {
                             self.commentInputView.transform = CGAffineTransformIdentity;
                             self.emotionManagerView.transform = CGAffineTransformIdentity;
                             [self.commentInputView prepareForReuse];
                             [self.commentInputView removeFromSuperview];
                             [self.emotionManagerView removeFromSuperview];
                             if (completion) {
                                 completion();
                             }
                         }];
    } else {
        if (completion) {
            completion();
        }
    }
    
    self.textViewInputViewType = ZWInputViewTypeNormal;
}

#pragma mark - setters and getters

- (UIView *)emotionManagerView {
    if (_emotionManagerView == nil) {
        _emotionManagerView =
        [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - kFaceManageViewHeight,
                                                 [UIScreen mainScreen].bounds.size.width,
                                                 kFaceManageViewHeight)];
        _emotionManagerView.backgroundColor = [UIColor redColor];
    }
    return _emotionManagerView;
}

- (void)setTextViewInputViewType:(ZWInputViewType)textViewInputViewType {
    _textViewInputViewType = textViewInputViewType;
//    NSArray *array = @[@"Normal", @"Text", @"Emotion", @"Media"];
//    NSLog(@"test = %@, commentView = %@, emotionView = %@",
//          array[textViewInputViewType],
//          [self.commentInputView.class description],
//          [self.emotionManagerView.class description]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return self.replyModel.count > 0 ? 1 : 0;
    } else if (section == 2) {
        return self.replyModel.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:statusBodyCellIdentifier
                                               forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:statusFirstCommentCellIdentifier
                                               forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:statusCommonCommentCellIdentifier
                                               forIndexPath:indexPath];
    }
    
    // Configure the cell ...
    [self configureCell:cell atIndexPath:indexPath];
    
    // Make sure the constraints have been added to this cell, since it may have just been created from scratch
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        NSAssert([cell conformsToProtocol:@protocol(StatusTableViewCellCommonDelegate)], @"error1");
        id<StatusTableViewCellCommonDelegate> statusBodyCell = (id<StatusTableViewCellCommonDelegate>)cell;
        statusBodyCell.hideBottomLine      = YES;
        statusBodyCell.hideOperationButton = YES;
        statusBodyCell.delegate            = self;
        
        statusBodyCell.status              = self.status;
        
    } else if (indexPath.section == 1) {
        
        NSAssert([cell isKindOfClass:[TriangleStatusTableViewCell class]], @"error2");
        //TriangleStatusTableViewCell *statusFirstCommentCell = (TriangleStatusTableViewCell *)cell;
        // populate data
        /*
        StatusReply *reply = [self.replyModel firstReply];
        
        statusFirstCommentCell.commentString = reply.content;
        statusFirstCommentCell.nickString    = reply.senderNick;
        statusFirstCommentCell.timeString    = reply.timeString;
         */
    } else if (indexPath.section == 2) {
        
        NSAssert([cell isKindOfClass:[CommonStatusCommentTableViewCell class]], @"error3");
        
        CommonStatusCommentTableViewCell *statusCommonCommentCell = (CommonStatusCommentTableViewCell *)cell;
        // populate data
        StatusReply *reply = [self.replyModel replyAtIndex:(indexPath.row)];
        
        statusCommonCommentCell.commentString = reply.content;
        statusCommonCommentCell.nickString    = reply.senderNick;
        statusCommonCommentCell.timeString    = reply.timeString;
        if (indexPath.row == 0) {
            statusCommonCommentCell.showTopLine = false;
        } else {
            statusCommonCommentCell.showTopLine = true;
        }
    }
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusReply *reply = [self.status statusReplyAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        //self.prototypeCell1.nickString = @"刘希茜";
        self.prototypeCell1.nickString = reply.senderNick;
        self.prototypeCell1.commentString = reply.content;
//        @"每次下班的时候看到男生带着狗出来溜达的时候，就也好想拥有一个这样的男朋友。每天下班一起带着狗在公园散步和聊天。";
        CGSize size = [self.prototypeCell1.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height;
    } else {
//        self.prototypeCell2.nickString = @"张不坏";
        self.prototypeCell2.nickString = reply.senderNick;
        self.prototypeCell2.commentString = reply.content;
//        @"每次下班的时候看到男生带着狗出来溜达的时候，就也好想拥有一个这样的男朋友。每天下班一起带着狗在公园散步和聊天。";
        CGSize size = [self.prototypeCell2.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return size.height;
    }
    return 0.f;
}
 */

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selected = false;
    
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    
//    DLog(@"回复%@", )
    
    if (self.textViewInputViewType != ZWInputViewTypeNormal) {
        [self hideAllInputViewWithCompletion:nil];
        self.textViewInputViewType = ZWInputViewTypeNormal;
        return;
    }
    [self.commentInputView prepareForReuse];
    
    // active keyboard
    [self.commentInputView.inputView becomeFirstResponder];
    
    self.textViewInputViewType = ZWInputViewTypeText;
    
    if (self.commentInputView.superview == nil) {
        [self.view addSubview:self.commentInputView];
    }
}

#pragma mark - StatusTableViewCellDelegate

- (void)didSelectedLikeButtonInCell:(UITableViewCell *)tableViewCell {
    if (![tableViewCell conformsToProtocol:@protocol(StatusTableViewCellCommonDelegate)]) {
        return;
    }
    
    id<StatusTableViewCellCommonDelegate> statusBodyCell = (id<StatusTableViewCellCommonDelegate>)tableViewCell;
    
    // 这一段已在view内部处理了，这一段不会执行，如果需要修改逻辑，则修改GDStatusBottomView
    if (self.status.liked && statusBodyCell.likeSelected) {
        [SVProgressHUD showInfoWithStatus:@"您已经点过赞了"];
    }
    
    statusBodyCell.likeSelected = YES;
    
    AppHTTPSessionManager *httpManager = [AppHTTPSessionManager sharedHTTPManager];
    MainNavVC(mainNavigationController);
    WeakSelf(weakSelf);
    [httpManager likeStatusWithUserID:mainNavigationController.userInfo.userID
                             statusID:self.status.statusID
                              success:^(NSDictionary *resultDic) {
                                  StrongSelf(strongSelf);
                                  
                                  strongSelf.status.liked = YES;
                              }
                              failure:^(NSError *error) {
                                  statusBodyCell.likeSelected = NO;
                                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                              }];
    
    DLog(@"like");
}

- (void)didClickedReplyButtonInCell:(UITableViewCell *)tableViewCell {
    
    if (self.textViewInputViewType != ZWInputViewTypeNormal) {
        [self hideAllInputViewWithCompletion:nil];
        self.textViewInputViewType = ZWInputViewTypeNormal;
        return;
    }
    [self.commentInputView prepareForReuse];
    
    // active keyboard
    [self.commentInputView.inputView becomeFirstResponder];
    
    self.textViewInputViewType = ZWInputViewTypeText;
    
    if (self.commentInputView.superview == nil) {
        [self.view addSubview:self.commentInputView];
    }
}

#pragma mark - actions

- (void)leftBarButtonItemClicked:(id)sender {
    [self hideAllInputViewWithCompletion:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
