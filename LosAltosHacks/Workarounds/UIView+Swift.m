//
//  UIView+Swift.m
//  LosAltosHacks
//
//  Created by Dan Appel on 1/26/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

#import "UIView+Swift.h"

@implementation UIView (Swift)
+ (instancetype)LAH_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass {
    return [self appearanceWhenContainedIn:containerClass, nil];
}
@end
