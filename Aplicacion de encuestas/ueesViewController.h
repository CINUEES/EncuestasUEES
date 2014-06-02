//
//  ueesViewController.h
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 07/11/13.
//  Copyright (c) 2013 Centro de Investigaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyDelegateProtocol
- (void)cerrarAlert;
@end

@interface ueesViewController : UIViewController

@property id <MyDelegateProtocol> delegate;

@property BOOL enFinalizada;

@end
