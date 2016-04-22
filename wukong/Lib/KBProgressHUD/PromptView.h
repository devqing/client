//
//  PromptView.h
//  customer-ios
//
//  Created by liuweiqing on 15/12/27.
//  Copyright © 2015年 Leoc O'Cear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptView : UIView

+ (void)showErrorWithTitle:(NSString *)title;
+ (void)showSuccessWithTitle:(NSString *)title;

@end
