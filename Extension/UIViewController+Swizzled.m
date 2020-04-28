//
//  UIViewController+Swizzled.m
//  LaiAi
//
//  Created by Ryan on 2020/4/28.
//  Copyright © 2020 Laiai. All rights reserved.
//

#import "UIViewController+Swizzled.h"
#import <objc/message.h>

@implementation UIViewController (Swizzled)

+ (void)load {
    Method swizzledViewDidLoadMethod = class_getInstanceMethod([self class], @selector(swizzled_viewDidLoad));
    Method originalViewDidLoadMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    method_exchangeImplementations(swizzledViewDidLoadMethod, originalViewDidLoadMethod);
    
    Method swizzledDeallocMethod = class_getInstanceMethod([self class], @selector(swizzled_dealloc));
    Method originalDeallocMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    method_exchangeImplementations(swizzledDeallocMethod, originalDeallocMethod);
}

- (void)swizzled_viewDidLoad {
    NSLog(@"%@ viewDidLoad", self.class);
    [self swizzled_viewDidLoad];
}

- (void)swizzled_dealloc {
    NSLog(@"%@ dealloc", self.class);
    [self swizzled_dealloc];
}

@end
