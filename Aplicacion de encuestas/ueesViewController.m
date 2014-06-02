//
//  ueesViewController.m
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 07/11/13.
//  Copyright (c) 2013 Centro de Investigaciones. All rights reserved.
//

#import "ueesViewController.h"

@interface ueesViewController ()

@end

@implementation ueesViewController

@synthesize enFinalizada,delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cerrarAlert:) name:@"EncuestaF" object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)cerrarAlert:(NSNotification *)notification{
    UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Aviso" message:@"Su encuesta se creo exitosamente" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alerta show];
    
    
    [self performSelector:@selector(dismissAlertView:) withObject:alerta afterDelay:2];
}


-(void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];
}



@end
