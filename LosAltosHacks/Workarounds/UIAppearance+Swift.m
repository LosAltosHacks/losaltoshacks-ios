//
//  UIAppearance+Swift.m
//  LosAltosHacks
//
//  Created by Dan Appel on 1/19/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

#import "UIAppearance+Swift.h"

@implementation UIView (UIViewAppearance_Swift)
+ (instancetype)LAH_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}
@end