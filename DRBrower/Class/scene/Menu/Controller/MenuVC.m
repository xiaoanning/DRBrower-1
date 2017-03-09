//
//  MenuVC.m
//  DRBrower
//
//  Created by QiQi on 2017/1/17.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "MenuVC.h"
#import "MoreVC.h"
#import "HistoryVC.h"

@interface MenuVC ()

@property (weak, nonatomic) IBOutlet UILabel *fullScreenLabel;

@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIButton *reloadBtn;
@property (weak, nonatomic) IBOutlet UIButton *fullScreenBtn;
@property (weak, nonatomic) IBOutlet UIButton *MoreBtn;
@property (weak, nonatomic) IBOutlet UIButton *teasingBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;



@end

@implementation MenuVC
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dismissView) name:DISMISS_VIEW object:nil];
}

- (void)setupSubviews {
    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];
    
    if (isFullScreen == YES) {
        self.fullScreenLabel.text = NSLocalizedString(@"退出全屏", nil);
    }else {
        self.fullScreenLabel.text = NSLocalizedString(@"全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kFullScreen];
        
    }
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:USERINFO_GENDER]isEqualToString:@"男"]) {
        self.iconImageView.image = [UIImage imageNamed:@"userHead_man"];
    }else {
        self.iconImageView.image = [UIImage imageNamed:@"userHead_woman"];
    }
    
    self.iconImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIconImageView:)];
    [self.iconImageView addGestureRecognizer:tap];
    
    switch (_rootVCType) {
        case MenuVCRootVCTypeUnknown:
            
            break;
        case MenuVCRootVCTypeHome:{
            [self.collectBtn setImage:[UIImage imageNamed:@"menu_collect_enabel"] forState:UIControlStateNormal];
            [self.reloadBtn setImage:[UIImage imageNamed:@"menu_reload_enable"] forState:UIControlStateNormal];
        }
            break;
        case MenuVCRootVCTypeSearch:
            
            break;
            
        default:
            break;
    }
}

- (void)dealloc{
   
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)dismissView{
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)recordButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpRecordButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpRecordButtonAction];
    }
}

- (IBAction)collectButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpCollectButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpCollectButtonAction];
    }
}

- (IBAction)fullScreenButtonAction:(id)sender {
    
    BOOL isFullScreen = [[NSUserDefaults standardUserDefaults] boolForKey:kFullScreen];
    
    if (isFullScreen == YES) {
        self.fullScreenLabel.text = NSLocalizedString(@"退出全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:kFullScreen];

    }else {
        self.fullScreenLabel.text = NSLocalizedString(@"全屏", nil);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kFullScreen];
        
    }
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpFullScreenButtonAction:)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpFullScreenButtonAction:isFullScreen];
    }
}

- (IBAction)refreshDataButtonAction:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpRefreshDataButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpRefreshDataButtonAction];
    }
}
- (IBAction)touchUpMoreButton:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpMoreButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpMoreButtonAction];
    }
}
- (IBAction)touchUpSpitButton:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpSpitButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpSpitButtonAction];
    }
}
- (IBAction)touchUpService:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(touchUpServiceButtonAction)]){
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpServiceButtonAction];
    }
}
-(void)tapIconImageView:(UITapGestureRecognizer *)tapIconImageView {
    if (_delegate && [_delegate respondsToSelector:@selector(touchUpIconImageView)]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate touchUpIconImageView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    

}


@end
