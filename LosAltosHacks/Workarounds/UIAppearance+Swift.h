//
//  UIAppearance+Swift.h
//  LosAltosHacks
//
//  Created by Dan Appel on 1/19/16.
//  Copyright © 2016 Dan Appel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIViewAppearance_Swift)
// appearanceWhenContainedIn: is not available in Swift. This fixes that.
+ (instancetype)LAH_appearanceWhenContainedIn:(Class<UIAppearanceContainer>)containerClass;
@end
