//
//  UIAlertController+DY.m
//  ChessGame
//
//  Created by dai yi on 2017/8/16.
//  Copyright © 2017年 Riber. All rights reserved.
//

#import "UIAlertController+DY.h"
#import <objc/runtime.h>

@implementation UIAlertController (DY)


+ (UIAlertController *)alertMessage:(NSString *)message leftHandler:(UIAlertActionHandler)leftHandler rightHandler:(UIAlertActionHandler)rightHandler leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle leftStyle:(UIAlertActionStyle)leftStyle rightStyle:(UIAlertActionStyle)rightStyle title:(NSString *)title {
    if (leftTitle == nil) {
        leftTitle = @"";
    }
    if (rightTitle == nil) {
        rightTitle = @"";
    }
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *leftAction = [UIAlertAction actionWithTitle:leftTitle style:leftStyle handler:leftHandler];
    UIAlertAction *rightAction = [UIAlertAction actionWithTitle:rightTitle style:rightStyle handler:rightHandler];
    
    [alertC addAction:leftAction];
    [alertC addAction:rightAction];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message leftHandler:(UIAlertActionHandler)leftHandler rightHandler:(UIAlertActionHandler)rightHandler leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle title:(NSString *)title {
    
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:leftHandler rightHandler:rightHandler leftTitle:leftTitle rightTitle:rightTitle leftStyle:(UIAlertActionStyleDefault) rightStyle:(UIAlertActionStyleDefault) title:title];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message leftHandler:(UIAlertActionHandler)leftHandler rightHandler:(UIAlertActionHandler)rightHandler leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle {
    
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:leftHandler rightHandler:rightHandler leftTitle:leftTitle rightTitle:rightTitle leftStyle:(UIAlertActionStyleDefault) rightStyle:(UIAlertActionStyleDefault) title:nil];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message leftHandler:(UIAlertActionHandler)leftHandler rightHandler:(UIAlertActionHandler)rightHandler leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle leftStyle:(UIAlertActionStyle)leftStyle {
    
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:leftHandler rightHandler:rightHandler leftTitle:leftTitle rightTitle:rightTitle leftStyle:leftStyle rightStyle:(UIAlertActionStyleDefault) title:nil];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message okHandler:(UIAlertActionHandler)okHandler cancelHandler:(UIAlertActionHandler)cancelHandler cancelStyle:(UIAlertActionStyle)cancelStyle {
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:okHandler rightHandler:cancelHandler leftTitle:@"取消" rightTitle:@"确定" leftStyle:cancelStyle rightStyle:(UIAlertActionStyleDefault) title:nil];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message okHandler:(UIAlertActionHandler)okHandler cancelHandler:(UIAlertActionHandler)cancelHandler {
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:okHandler rightHandler:cancelHandler leftTitle:@"取消" rightTitle:@"确定" leftStyle:UIAlertActionStyleDestructive rightStyle:(UIAlertActionStyleDefault) title:nil];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message okHandler:(UIAlertActionHandler)okHandler cancelHandler:(UIAlertActionHandler)cancelHandler title:(NSString *)title {
    UIAlertController *alertC = [UIAlertController alertMessage:message leftHandler:cancelHandler rightHandler:okHandler leftTitle:@"取消" rightTitle:@"确定" leftStyle:UIAlertActionStyleDestructive rightStyle:(UIAlertActionStyleDefault) title:title];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message singleHandler:(UIAlertActionHandler)singleHandler  singleTitle:(NSString *)singleTitle singleStyle:(UIAlertActionStyle)singleStyle title:(NSString *)title {
    if (singleTitle == nil) {
        singleTitle = @"确定";
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:singleTitle style:singleStyle handler:singleHandler];
    [okAction setValue:UIColorFromRGB(0xFE7039) forKey:@"titleTextColor"];
    [alertC addAction:okAction];
    
    return alertC;
}


+ (UIAlertController *)alertMessage:(NSString *)message singleHandler:(UIAlertActionHandler)singleHandler  singleTitle:(NSString *)singleTitle singleStyle:(UIAlertActionStyle)singleStyle {
    UIAlertController *alertC = [UIAlertController alertMessage:message singleHandler:singleHandler singleTitle:singleTitle singleStyle:singleStyle title:nil];
    
    return alertC;
}

+ (UIAlertController *)alertMessage:(NSString *)message okHandler:(UIAlertActionHandler)okHandler {
    UIAlertController *alertC = [UIAlertController alertMessage:message singleHandler:okHandler singleTitle:@"确定" singleStyle:(UIAlertActionStyleDefault)];
    
    return alertC;
}


- (void)setAttributeMessage:(NSAttributedString *)attributeMessage {
    static NSString * messageKey = @"_attributedMessage";
    if (![UIAlertController validateKeypath:messageKey forClass:[self class]]) {
        return;
    }
    [self setValue:attributeMessage forKey:@"_attributedMessage"];
}

- (void)setAttributeTitle:(NSAttributedString *)attributeTitle {
    static NSString *titleKey = @"_attributedTitle";
    if (![UIAlertController validateKeypath:titleKey forClass:[self class]]) {
        return;
    }
    [self setValue:attributeTitle forKey:titleKey];
}

- (void)setAttributeMessage:(NSAttributedString *)attributeMessage attributeTitle:(NSAttributedString *)attributeTitle {
    [self setAttributeMessage:attributeMessage];
    [self setAttributeTitle:attributeTitle];
}

- (void)setFirstActionColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor {
    static NSString *textColorKey = @"_titleTextColor";
    if ([UIAlertController validateKeypath:textColorKey forClass:[UIAlertAction class]]) {
        return;
    }
    NSArray *actions = self.actions;
    UIAlertAction *firstAction = [actions firstObject];
    if (firstAction && firstColor) {
        [firstAction setValue:firstColor forKey:textColorKey];
    }
    if (actions.count >= 2 && secondColor) {
        UIAlertAction *secondAction = actions[1];
        if (secondAction) {
            [secondAction setValue:secondColor forKey:textColorKey];
        }
    }
}

+ (BOOL)validateKeypath:(NSString *)keypath forClass:(Class)cls {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(cls, &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        // 获取属性名
        const char *name = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        if ([propertyName isEqualToString:keypath]) {
            return true;
        }
    }
    return false;
}

+ (UIAlertController *)alertSheetWithTitle:(NSString *)title titles:(NSArray<NSString *> *)titiles  handler:(void(^)(NSInteger index))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    int index = 0;
    for (NSString *actionTitle in titiles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            if (handler) {
                handler(index);
            }
        }];
        [alert addAction:action];
        index ++;
    }
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:cancel];

    return alert;
}


@end
