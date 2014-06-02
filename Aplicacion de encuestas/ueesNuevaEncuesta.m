//
//  ueesNuevaEncuesta.m
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 14/01/14.
//  Copyright (c) 2014 Centro de Investigaciones. All rights reserved.
//

#import "ueesNuevaEncuesta.h"
#import "ueesCeldaCV.h"
#import "ueesControllerCrearEncuestas.h"

@interface ueesNuevaEncuesta ()
{
    //Variables Generales de creación de encuestas
    NSString *nombre_enc;
    NSString *descrip_enc;
    int tema_enc;
    NSString *msj_inicio_enc;
    NSString *msj_fin_enc;
    NSArray *tipos_preg_enc;
    
    
    
    //Variables de la clase
    UIAlertView *alerta;
    NSArray *colores;
    NSIndexPath *index_cv;
}

@end

@implementation ueesNuevaEncuesta

@synthesize nombreEncuesta,desEncuesta;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    colores=[[NSArray alloc]initWithObjects:[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor whiteColor],[UIColor greenColor],[UIColor grayColor],[UIColor cyanColor],[UIColor brownColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor  magentaColor],[UIColor lightTextColor], nil];
    self.tv1.layer.borderWidth=3.0f;
    self.tv1.layer.borderColor = [[UIColor grayColor] CGColor];
    self.tv1.layer.cornerRadius = 8;
    
    self.cv.layer.borderWidth=3.0f;
    self.cv.layer.borderColor = [[UIColor grayColor] CGColor];
    self.cv.layer.cornerRadius = 8;
    
    self.tv2.layer.borderWidth=3.0f;
    self.tv2.layer.borderColor = [[UIColor grayColor] CGColor];
    self.tv2.layer.cornerRadius = 8;
    
    [self.nombreEncuesta setAlpha:0];
    [self.desEncuesta setAlpha:0];
    alerta=[[UIAlertView alloc]initWithTitle:@"Encuesta UEES" message:@"Ingresa el nombre de la encuesta:" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    alerta.alertViewStyle=UIAlertViewStylePlainTextInput;
    [alerta show];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    nombreEncuesta.text=[[alerta textFieldAtIndex:0]text];
    [nombreEncuesta setAlpha:1.0f];
    [desEncuesta setAlpha:1.0f];
}


#pragma mark CollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return colores.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ueesCeldaCV *celda=[collectionView dequeueReusableCellWithReuseIdentifier:@"CeldaID" forIndexPath:indexPath];
    //[[celda imagenCV]setImage:[colores objectAtIndex:indexPath.item]];
    [celda setBackgroundColor:[colores objectAtIndex:indexPath.item]];
    
    return celda;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    index_cv=indexPath;
    [self.view setBackgroundColor:[colores objectAtIndex:indexPath.item]];
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ueesControllerCrearEncuestas *conSiguiente=segue.destinationViewController;
    conSiguiente.nombre_enc=self.nombreEncuesta.text;
    conSiguiente.descrip_enc=self.desEncuesta.text;
    conSiguiente.tema_enc=index_cv.item;
    conSiguiente.msj_inicio_enc=self.tv1.text;
    conSiguiente.msj_fin_enc=self.tv2.text;
    conSiguiente.color=self.view.backgroundColor;
    conSiguiente.num_pregunta_enc=1;
}


#pragma mark scroll



- (void)keyboardDidShow:(NSNotification *)notification
{
    if (!self.desEncuesta.editing) {
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad){
            CGSize tamano=[[UIScreen mainScreen]bounds].size;
            
            if(tamano.height<=1024){
                
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     [self.view setFrame:CGRectMake(0,-90,768,1024)];
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
            else {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     [self.view setFrame:CGRectMake(0,-90,1536,2048)];
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
        }
    }
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    if (!self.desEncuesta.editing) {
    if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad){
        CGSize tamano=[[UIScreen mainScreen]bounds].size;
        
        if(tamano.height<=1024){
            
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.view setFrame:CGRectMake(0,0,768,1024)];
                             }
                             completion:^(BOOL finished){
                             }];
        }
        else {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options: UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 [self.view setFrame:CGRectMake(0,0,1536,2048)];
                             }
                             completion:^(BOOL finished){
                             }];
        }
    }
    }
}



@end
