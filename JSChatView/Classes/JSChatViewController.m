//
//  UUChatTestVC.m
//  TestCom
//
//  Created by admin on 15/2/3.
//  Copyright (c) 2015年 cmge. All rights reserved.
//

#import "JSChatViewController.h"

#import "JSChatInputView.h"
#import "JSChatCell.h"
#import "ChatModel.h"
#import "JSChatCellViewModel.h"
#import "JSChatMessage.h"

#import "ACMacros.h"

#import "JSShortHand.h"

#define kTag_InputView 12345
#define kTag_ChatTableView 12346


@interface JSChatViewController ()
<JSChatCellDelegate,JSChatInputViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) ChatModel *chatModel;

@end

@implementation JSChatViewController{
    JSChatViewManager *manager;
}

- (id)initWithManager:(JSChatViewManager*)mana{
    self = [super init];
    if (self) {
        manager = mana; // just assign
    }
    return self;
}

- (void)dealloc{
    JS_releaseSafely(_chatTableView);
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self buildChatTableView];
    [self loadBaseViewsAndData];
}

- (void)buildChatTableView {
    CGRect inputViewFrm = CGRectMake(0, Main_Screen_Height-40, Main_Screen_Width, 40);
    JSChatInputView *inputView = [[JSChatInputView alloc] initWithFrame:inputViewFrm];
    inputView.delegate = self;
    inputView.uiResponder = manager.uiResponder;
    inputView.tag = kTag_InputView;
    [self.view addSubview:inputView];
    
    // adjust tableview's height to make room for input view
    CGRect oriFrm = self.chatTableView.frame;
    self.chatTableView.frame = CGRectMake(CGRectGetMinX(oriFrm), CGRectGetMinY(oriFrm),
                                          CGRectGetWidth(oriFrm), CGRectGetHeight(self.view.bounds) - CGRectGetHeight(inputView.frame));
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
    self.chatTableView.tag = kTag_ChatTableView;
    
    [self.view addSubview:self.chatTableView];
    [self.view sendSubviewToBack:self.chatTableView];
}


- (void)loadBaseViewsAndData{
    self.chatTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    self.chatModel = [[[ChatModel alloc]init] autorelease];
    [self.chatModel populateRandomDataSource];
    
    [self.chatTableView reloadData];
    
    //add notification
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChange:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tableViewScrollToBottom) name:UIKeyboardDidShowNotification object:nil];
}

//adjust UUInputFunctionView's height
-(void)keyboardChange:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    CGRect keyboardEndFrame;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    [self adjustInputViewPosWithKeyboardNotiName:notification.name keyboardFrame:keyboardEndFrame];
    
    [self adjustChatTableViewPosWithKeyboardNotiName:notification.name keyboardFrame:keyboardEndFrame];
    
    [UIView commitAnimations];
    
}

- (void)adjustInputViewPosWithKeyboardNotiName:(NSString*)notiName keyboardFrame:(CGRect)keyboardEndFrame {
    UIView *inputView = [self.view viewWithTag:kTag_InputView];
    CGFloat inputViewH = CGRectGetHeight(inputView.bounds);
    
    CGFloat yOffset = [notiName isEqualToString:UIKeyboardWillShowNotification] ? keyboardEndFrame.size.height : 0;
    
    inputView.frame = CGRectMake(0, CGRectGetHeight(self.view.bounds) - yOffset - inputViewH,
                                 CGRectGetWidth(inputView.bounds), inputViewH);
}

- (void)adjustChatTableViewPosWithKeyboardNotiName:(NSString*)notiName keyboardFrame:(CGRect)keyboardEndFrame {
    UIView *chatView = [self.view viewWithTag:kTag_ChatTableView];
    CGFloat chatViewH = CGRectGetHeight(chatView.bounds);
    
    CGFloat keyboardH = CGRectGetHeight(keyboardEndFrame);
    
    CGFloat hOffset = [notiName isEqualToString:UIKeyboardWillShowNotification] ? keyboardH : -keyboardH;
    
    chatView.frame = CGRectMake(0, chatView.frame.origin.y,
                                 CGRectGetWidth(chatView.bounds), chatViewH - hOffset);
}

//tableView Scroll to bottom
- (void)tableViewScrollToBottom{
    if (self.chatModel.dataSource.count==0)
        return;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatModel.dataSource.count-1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark - JSChatInputViewDelegate

- (void)inputView:(JSChatInputView *)inputView afterSendTextBtnTapWithText:(NSString *)text{
    NSDictionary *dic = @{@"strContent": text, @"type":@(UUMessageTypeText)};
    inputView.textInputView.text = @"";
    [inputView changeSendBtnWithPhoto:YES];
    [self dealTheFunctionData:dic];
}

//- (void)inputView:(JSChatInputView *)funcView sendPicture:(UIImage *)image{
//    NSDictionary *dic = @{@"picture": image, @"type":@(UUMessageTypePicture)};
//    [self dealTheFunctionData:dic];
//}
//
//- (void)inputView:(JSChatInputView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second{
//    NSDictionary *dic = @{@"voice": voice, @"strVoiceTime":[NSString stringWithFormat:@"%d",(int)second],
//                          @"type":@(UUMessageTypeVoice)};
//    [self dealTheFunctionData:dic];
//}

- (void)dealTheFunctionData:(NSDictionary *)dic
{
    [self.chatModel addSpecifiedItem:dic];
    [self.chatTableView reloadData];
    [self tableViewScrollToBottom];
}

#pragma mark - tableView delegate & datasource

-(JSMessageContentHandler*)handlerForMessage:(JSChatMessage*)message{
    return [manager handlerForMessage:message];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.chatModel.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSChatCellViewModel *vm = self.chatModel.dataSource[indexPath.row];

    JSMessageContentHandler *handler = [self handlerForMessage:vm.message];
    
    NSString *cellId = [@"UUMessageCell-" stringByAppendingFormat:@"%@", handler.class];
    JSChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[[JSChatCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:cellId
                                          handler:handler
                                         delegate:self] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell setViewModel:vm];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JSChatCellViewModel *vm = self.chatModel.dataSource[indexPath.row];
    JSMessageContentHandler *handler = [self handlerForMessage:vm.message];
    handler.message = vm.message;
    
    [vm calculateElementCoordinateWithContentHandler:handler];

    return vm.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
}

#pragma mark - cellDelegate

-(UIImageView*)createHeadImageViewInCell:(JSChatCell*)cell headBgView:(UIView*)bgView{
    return [manager.uiRender createHeadImageViewInCell:cell headBgView:bgView];
}

-(void)renderHeadImageView:(UIImageView*)headView headBgView:(UIView*)bgView
                    inCell:(JSChatCell*)cell{
    [manager.uiRender renderSenderHead:headView headBgView:bgView inCell:cell];
}

-(UIView*)createSenderNameViewInCell:(JSChatCell*)cell{
    return [manager.uiRender createSenderNameViewInCell:cell];
}

-(void)renderSenderNameView:(UIView*)nameView inCell:(JSChatCell*)cell{
    [manager.uiRender renderSenderNameView:nameView inCell:cell];
}

-(UIView*)createSendTimeViewInCell:(JSChatCell*)cell{
    return [manager.uiRender createSendTimeViewInCell:cell];
}

-(void)renderSendTimeView:(UIView*)timeView inCell:(JSChatCell*)cell{
    [manager.uiRender renderSendTimeView:timeView inCell:cell];
}

- (void)headImageDidTapWithImageBgView:(UIView*)bgView headView:(UIImageView*)headView
                                  cell:(JSChatCell *)cell
                             viewModel:(JSChatCellViewModel*)vm{
    [manager.uiResponder headerViewInCell:cell didTapWithViewModel:vm];
    
    NSLog(@"sender head url:%@",vm.message.senderHeadURL);
    
    // TEST only
    int pageNum = 3;

    [self.chatModel addRandomItemsToDataSource:pageNum];
    
    if (self.chatModel.dataSource.count>pageNum) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pageNum inSection:0];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.chatTableView reloadData];
            [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        });
    }


}

@end
