//
//  ueesNuevaEncuesta.h
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 14/01/14.
//  Copyright (c) 2014 Centro de Investigaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ueesNuevaEncuesta : UIViewController<UIAlertViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) IBOutlet UIScrollView *scroll;

@property (nonatomic,weak) IBOutlet UILabel *nombreEncuesta;
@property (nonatomic,weak) IBOutlet UITextField *desEncuesta;

@property (nonatomic,weak) IBOutlet UICollectionView *cv;
@property (nonatomic,weak) IBOutlet UITextView *tv1;
@property (nonatomic,weak) IBOutlet UITextView *tv2;

@end
