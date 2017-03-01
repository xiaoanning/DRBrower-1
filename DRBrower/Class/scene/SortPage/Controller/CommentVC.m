//
//  CommentVC.m
//  DRBrower
//
//  Created by apple on 2017/2/24.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#define UP_LOAD @"上拉"
#define DOWN_LOAD @"下拉"

#import "CommentVC.h"
#import "CommentListCell.h"
#import "CommentModel.h"

@interface CommentVC ()<UITextViewDelegate> {
    CGFloat fitHeight;
}
@property (nonatomic,strong) NSMutableArray *commentListArray;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong) UILabel *bgLabel;
@property (nonatomic,strong) NSMutableArray *inputTextArray;

@property (nonatomic,strong) UIView *bottomView;//蒙版
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UITextView *commentTextView;
@property (nonatomic,assign) CGFloat keyboardHeight;
@property (nonatomic,strong) UILabel *placeHolderLabel;
@end

@implementation CommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部评论";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"nav_btn_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    self.navigationItem.leftBarButtonItem = backButton;

    self.view.backgroundColor = [UIColor whiteColor];
    self.commentListArray = [NSMutableArray arrayWithCapacity:5];
    self.inputTextArray = [NSMutableArray arrayWithCapacity:5];
    self.page = 1;
    [self getCommentListData:nil page:self.page];
    
    [self.commentListTableView registerNib:[UINib nibWithNibName:@"CommentListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"commentListCell"];
    self.commentListTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.textView1.layer.cornerRadius = 15;
    self.textView1.layer.masksToBounds = YES;
    self.textView1.delegate = self;
    
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
- (void)backButtonAction:(UIBarButtonItem *)barButton {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - 上下拉刷新
//下拉
- (void)headerRereshing {
    
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.commentListTableView.mj_header =
    [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
}

//上拉
- (void)fooderRereshing {
    
    [self headerRereshing];
    __unsafe_unretained __typeof(self) weakSelf = self;
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.commentListTableView.mj_footer =
    [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)loadNewData {
    // 1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态
    self.page = 1;
    [self getCommentListData:DOWN_LOAD page:self.page];
    [self.commentListTableView.mj_header endRefreshing];
    NSLog(@"下拉刷新");
}

- (void)loadMoreData {
    //1.请求数据\2.刷新表格\3.拿到当前的下拉刷新控件，结束刷新状态
    self.page += 1;
    [self getCommentListData:UP_LOAD page:self.page];
    [self.commentListTableView.mj_footer endRefreshing];
    
    NSLog(@"上拉刷新");
}

//获取评论列表
-(void)getCommentListData:(NSString *)type page:(NSInteger)page{
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&page_num=%@",BASE_URL,URL_GETCOMMENTLIST,self.sortModel.url_md5,[NSString stringWithFormat:@"%ld",(long)page]];
    [CommentModel getCommentListUrl:urlString parameters:@{} block:^(CommentListModel *commentList, NSError *error) {
        if ([type isEqualToString:DOWN_LOAD]) {
            [self.commentListArray insertObjects:commentList.data
                                    atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [commentList.data count])]];
        }else {
            [self.commentListArray removeAllObjects];
            [self.commentListArray addObjectsFromArray:commentList.data];
            if (!(self.commentListArray.count>0)) {
                [self createBackground];
            }else {
                [self.bgLabel removeFromSuperview];
            }
        }
        [self.commentListTableView reloadData];
    }];
}
//发表评论
-(void)addCommentData:(NSString *)content {
// "tel=" + mobile + "&md5=" + md5Url + "&content=" + content + "&address=" + address + "&dev_id=" + id + "&sex=" + sex;
    NSLog(@"%@",self.sortModel);
    NSString *currentDeviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
    
    NSString *contentStr = [content stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    NSString *urlString = [NSString stringWithFormat:@"%@%@%@&md5=%@&content=%@&address=%@&dev_id=%@&sex=%@",BASE_URL,URL_ADDCOMMENT,@"",self.sortModel.url_md5,contentStr,@"Bj",currentDeviceId,@"1"];

    [CommentModel addCommentUrl:urlString parameters:@{} block:^(NSDictionary *dic, NSError *error) {
        NSLog(@"%@",dic);
        if ([[dic objectForKey:@"info"] isEqualToString:@"评论成功"]) {
            [self getCommentListData:nil page:1];
        }
    }];
}
-(void)createBackground {
    if (self.bgLabel == nil) {
        self.bgLabel = [[UILabel alloc] init];
        self.bgLabel.backgroundColor = [UIColor whiteColor];
        self.bgLabel.frame = self.commentListTableView.frame;
        self.bgLabel.text = @"没有评论哦";
        self.bgLabel.textAlignment = NSTextAlignmentCenter;
        [self.commentListTableView addSubview:self.bgLabel];
        self.commentListTableView.scrollEnabled = NO;
    }
}
-(void)createTextView {
    self.bottomView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.bottomView.backgroundColor = [UIColor colorWithRed:125/255.0 green:125/255.0 blue:125/255.0 alpha:0.5];
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self.bottomView];
    /*添加手势事件,移除View*/
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissContactView:)];
    [self.bottomView addGestureRecognizer:tapGesture];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-130-self.keyboardHeight, SCREEN_WIDTH, 130)];
    self.bgView.backgroundColor = [UIColor colorWithRed:243/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self.bottomView addSubview:self.bgView];
    
    self.commentTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 70)];
    self.commentTextView.layer.cornerRadius = 5;
    self.commentTextView.layer.masksToBounds = YES;
    [self.bgView addSubview:self.commentTextView];
    self.commentTextView.tag = 200;
    self.commentTextView.delegate = self;
    self.commentTextView.font = [UIFont boldSystemFontOfSize:15];
    self.commentTextView.selectedRange=NSMakeRange(0,0) ;   //起始位置
    
    self.placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 3, 200, 20)];
    self.placeHolderLabel.enabled = NO;
    self.placeHolderLabel.text = @"写评论：";
    self.placeHolderLabel.font =  [UIFont systemFontOfSize:15];
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    [self.commentTextView addSubview: self.placeHolderLabel];
    [self.commentTextView sendSubviewToBack:self.placeHolderLabel];
    
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    commitButton.frame = CGRectMake(CGRectGetWidth(self.bgView.frame)-60, CGRectGetMaxY(self.commentTextView.frame)+15, 50, 25);
    [commitButton setTitle:@"发布"forState:UIControlStateNormal];
    [commitButton setBackgroundColor:[UIColor grayColor]];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton addTarget:self action:@selector(clickCommitButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:commitButton];
    commitButton.layer.cornerRadius = 5;
    
}
#pragma mark - 手势点击事件,移除View
- (void)dismissContactView:(UITapGestureRecognizer *)tapGesture{
    [self.bottomView removeFromSuperview];
    [self.commentTextView resignFirstResponder];
}

-(void)clickCommitButton:(UIButton *)button {
    NSString *inputString = [self.inputTextArray lastObject];
    if (inputString.length>0) {
        [self.commentTextView resignFirstResponder];
        [self addCommentData:[self.inputTextArray lastObject]];
    }else {
        NSLog(@"写点什么吧");
    }
}
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.height;    
    self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT-130-self.keyboardHeight, SCREEN_WIDTH, 130);
}
//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    [self.bottomView removeFromSuperview];
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    _keyboardHeight = keyboardRect.size.height;
//    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    self.bgView.frame = CGRectMake(0, SCREEN_HEIGHT-130, SCREEN_WIDTH, 130);
}
#pragma mark - -------------TextView--------
-(void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView.tag == 100) {
        [self createTextView];
        [self.commentTextView becomeFirstResponder];
    }
    if (textView.tag == 200){
        if ([textView.text length] == 0) {
            [self.placeHolderLabel setHidden:NO];
        }else{
            [self.placeHolderLabel setHidden:YES];
        }
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView.tag == 200) {
        if (1 == range.length) {//按下回格键
            return YES;
        }
        if ([text isEqualToString:@"\n"]) {//按下return键
            [textView resignFirstResponder];
            return NO;
        }else {
            if ([textView.text length] < 140) {//判断字符个数
                NSLog(@"%@",text);
                return YES;
            }
        }
    }
    return NO;
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.tag == 200) {
        [self.inputTextArray addObject:textView.text];
        
        if ([textView.text length] == 0) {
            [self.placeHolderLabel setHidden:NO];
        }else{
            [self.placeHolderLabel setHidden:YES];
        }
    }
}
//-(void)textViewDidEndEditing:(UITextView *)textView {
//    if (textView.tag == 100) {
//        NSLog(@"%@",textView.text);
//    }
//}
#pragma mark - -------------TableView--------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.commentListArray.count > 0) {
        return self.commentListArray.count;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90+fitHeight;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CommentModel *commentModel = self.commentListArray[indexPath.row];
    [cell commentListCell:cell model:commentModel index:indexPath.row];
    fitHeight = [self fitToText:cell.contentLabel text:commentModel.content];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
//自适应高度
-(CGFloat)fitToText:(UILabel *)label text:(NSString *)text{
    label.text = text;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [label sizeThatFits:CGSizeMake(self.view.frame.size.width-20, MAXFLOAT)];
    return size.height;
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
