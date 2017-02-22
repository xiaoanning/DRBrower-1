//
//  ShareVC.m
//  DRBrower
//
//  Created by QiQi on 2017/2/19.
//  Copyright © 2017年 QiQi. All rights reserved.
//

#import "ShareVC.h"
#import "ShareView.h"

@interface ShareVC ()

@property(strong,nonatomic)ShareView *shareView;
@end

@implementation ShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.shareView = [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:self options:nil] objectAtIndex:0];
    [self.shareView.titleLabel.superview bringSubviewToFront:self.shareView.titleLabel];
    self.shareView.frame = CGRectMake(0, 0, self.view.frame.size.width, 245);
    [self.view addSubview:self.shareView];
    

    [self.shareView shareButtonClick:^(SSDKPlatformType type) {
        
        [self shareSDK:type];
    }];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shareSuccess) name:@"ShareCirclesSuccess" object:nil];
   
}

- (void)shareSDK:(SSDKPlatformType)shareType  {
    
    UIImage *image = [UIImage imageCompressForWidth:self.shareModel.image targetWidth:100];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:self.shareModel.content
                                     images:image
                                        url:[NSURL URLWithString:self.shareModel.shareUrl]
                                      title:self.shareModel.title
                                       type:SSDKContentTypeAuto];
    
    [ShareSDK share:shareType
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateBegin:
                 break;
             case SSDKResponseStateSuccess: {
//                 [self showView:@"分享成功"];
                 NSLog(@"分享成功");
                 break;
             }
             case SSDKResponseStateFail: {
//                 [self showView:@"分享失败"];
                 NSLog(@"分享失败");
                 break;
             }
             case SSDKResponseStateCancel: {
                 NSLog(@"分享取消");
                 break;
             }
         }
         
     }];

}

-(void)showView:(NSString *)title{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(title, @"HUD message title");
    hud.tintColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:2.f];
    
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
