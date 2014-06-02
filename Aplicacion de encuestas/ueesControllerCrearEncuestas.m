//
//  ueesControllerCrearEncuestas.m
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 14/11/13.
//  Copyright (c) 2013 Centro de Investigaciones. All rights reserved.
//

#import "ueesControllerCrearEncuestas.h"
#import "ueesViewController.h"

@interface ueesControllerCrearEncuestas ()
{
    
    //Variables de pregunta
    NSMutableArray *datosPreguntas;
    int num_preg;
    int tipo_preg;
    NSString *titulo_preg;
    NSString *txt_ayuda_preg;
    BOOL obliga_preg;
    
    //Variables de texto
     NSMutableArray *datosTexto;//Array que contiene arrays que a su vez contiene las variables para cdada pregunta(numero, tipo, titulo, texto ayuda y si es obligatoria)
    
    //Variables de parrafo
    NSArray *datosTextoParrafo;
    
    
    int tipo_pregunta;
    int contLista;
    NSArray *tiposPregunta;
    UIView *actualView,*viewVacia;
    NSMutableArray *views,*viewsTipo;
    //ultima fila lista
    //0=label,1=menos,2=textfield,3=mas,4=numFila
    NSMutableArray *ultimaFila;
}

@end



@implementation ueesControllerCrearEncuestas

@synthesize nuevoElemento,finalizarEncuesta,titulo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    views=[[NSMutableArray alloc]init];
    viewsTipo=[[NSMutableArray alloc]init];
    self.viewInicial.tag=self.num_pregunta_enc;  
    [views addObject:self.viewInicial];
    id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewInicial]];
    viewVacia = (UIView *)vistaCopia;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    datosPreguntas=[[NSMutableArray alloc]init];//se inicializa el array que contiene todas preguntas y sus datos
    datosTexto=[[NSMutableArray alloc]init];//se inicializa el array que contiene todos los datos de "Texto"
    NSString *path = [[NSBundle mainBundle] pathForResource: @"ConfiguracionApp" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    self.tipos_preg_enc =[dict objectForKey: @"tipos_preguntas"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    tiposPregunta=self.tipos_preg_enc;
    self.navigationItem.title=self.titulo;
    self.view.backgroundColor=self.color;
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    self.num_pregunta_enc=1;
    contLista=0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tipoDePregunta:(id)sender{
    switch ([self.tipoPregunta selectedRowInComponent:0]) {
        case 0:
            {
              [datosTexto addObject:[NSArray arrayWithObjects:self.num_pregunta_enc,, nil]]
            id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewTexto]];
                if([[[views objectAtIndex:self.num_pregunta_enc-1]subviews]count]!=0){
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];
                    [viewsTipo replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:vistaCopia];
                }
                else{
                    [viewsTipo addObject:vistaCopia];
                }
            }
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [self reiniciarVistas];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1] setAlpha:1.0];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderWidth=2.0f;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].cornerRadius = 8;
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:[viewsTipo objectAtIndex:self.num_pregunta_enc-1]];
            [UIView commitAnimations];
            break;
        case 1:
        {
            id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewTextoP]];
            if([[[views objectAtIndex:self.num_pregunta_enc-1]subviews]count]!=0){
                [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];
                [viewsTipo replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:vistaCopia];
            }
            else{
                [viewsTipo addObject:vistaCopia];
            }
        }
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [self reiniciarVistas];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1] setAlpha:1.0];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderWidth=2.0f;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].cornerRadius = 8;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].borderWidth=0.5f;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].cornerRadius = 8;
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:[viewsTipo objectAtIndex:self.num_pregunta_enc-1]];
            [UIView commitAnimations];
            break;
        case 4:
        {
            id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewLista]];
            if([[[views objectAtIndex:self.num_pregunta_enc-1]subviews]count]!=0){
                [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];
                [viewsTipo replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:vistaCopia];
            }
            else{
                [viewsTipo addObject:vistaCopia];
            }
        }
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [self reiniciarVistas];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1] setAlpha:1.0];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderWidth=2.0f;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]layer].cornerRadius = 8;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29]setTag:1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29]addTarget:self action:@selector(eliminarFila1) forControlEvents:UIControlEventTouchUpInside];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]addTarget:self action:@selector(anadirRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:[viewsTipo objectAtIndex:self.num_pregunta_enc-1]];
            ultimaFila=[[NSMutableArray alloc]initWithObjects:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4],[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29],[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7],[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28],[NSNumber numberWithInt:1], nil];
            [UIView commitAnimations];
            break;
    }
    if(self.num_pregunta_enc==[views count]){
        self.nuevoElemento.alpha=1.0f;
        self.finalizarEncuesta.alpha=1.0f;
    }
    
}


#pragma mark siguiente atras

-(IBAction)nuevaPregunta:(id)sender{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
    self.num_pregunta_enc++;
    id copyOfView =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:viewVacia]];
    UIView *viewNuevaP = (UIView *)copyOfView;
    viewNuevaP.tag=self.num_pregunta_enc;
    viewNuevaP.alpha=1.0f;
    [views addObject:viewNuevaP];
    [self.view addSubview:viewNuevaP];
    self.pregAnterior.alpha=1.0f;
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    [UIView commitAnimations];
}

-(IBAction)siguientePregunta:(id)sender{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
    self.num_pregunta_enc++;
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0];
    self.pregAnterior.alpha=1.0f;
    if(self.num_pregunta_enc==[views count]){
        self.pregSiguiente.alpha=0.0f;
        self.nuevoElemento.alpha=1.0f;
    }
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    [UIView commitAnimations];
}

-(IBAction)preguntaAnterior:(id)sender{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
    self.pregSiguiente.alpha=1.0f;
    self.nuevoElemento.alpha=0.0f;
    self.num_pregunta_enc--;
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0];
    if(self.num_pregunta_enc==1){
         self.pregAnterior.alpha=0.0f;
    }
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    [UIView commitAnimations];
}

#pragma mark - Lista

//darle tag a el primer case
-(IBAction)anadirRespuesta:(id)sender{
    contLista++;
    switch (contLista) {
        case 1:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:17]setAlpha:1.0f];
        {
            CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
            frame1.origin.y=frame1.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
            UIButton *menos1=[UIButton buttonWithType:UIButtonTypeSystem];
            menos1.titleLabel.text=@"-";
            menos1.frame=[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29]frame];
            menos1.tag=1;
            CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29]frame];
            frame2.origin.y=frame2.origin.y+38;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:menos1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]setFrame:frame2];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            [UIView commitAnimations];
            break;
        case 2:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
        {
            CGRect frame0 = [[ultimaFila objectAtIndex:0]frame];//label
            [(UILabel*)[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18]setText:[NSString stringWithFormat:@"Respuesta %d: ",[[ultimaFila objectAtIndex:4]intValue]+1]];
            frame0.origin.y=frame0.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18]setFrame:frame0];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18]setAlpha:1.0f];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"-" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            button.tag=2;
            CGRect frame1 = [[ultimaFila objectAtIndex:1]frame];//signo menos
            frame1.origin.y=frame1.origin.y+38;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]setFrame:frame1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame2 = [[ultimaFila objectAtIndex:2]frame];//textfield
            frame2.origin.y=frame2.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8]setFrame:frame2];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8]setAlpha:1.0f];
            
            CGRect frame3 = [[ultimaFila objectAtIndex:3]frame];//signo mas
            frame3.origin.y=frame3.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame3];
            
            [ultimaFila replaceObjectAtIndex:0 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18]];
            [ultimaFila replaceObjectAtIndex:1 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]];
            [ultimaFila replaceObjectAtIndex:2 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8]];
            [ultimaFila replaceObjectAtIndex:3 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]];
            [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:2]];
        }
            [UIView commitAnimations];
            break;
       case 3:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
        {
            CGRect frame0 = [[ultimaFila objectAtIndex:0]frame];//label
            [(UILabel*)[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19]setText:[NSString stringWithFormat:@"Respuesta %d: ",[[ultimaFila objectAtIndex:4]intValue]+1]];
            frame0.origin.y=frame0.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19]setFrame:frame0];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19]setAlpha:1.0f];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"-" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            button.tag=3;
            CGRect frame1 = [[ultimaFila objectAtIndex:1]frame];//signo menos
            frame1.origin.y=frame1.origin.y+38;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31]setFrame:frame1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31]addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame2 = [[ultimaFila objectAtIndex:2]frame];//textfield
            frame2.origin.y=frame2.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]setFrame:frame2];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]setAlpha:1.0f];
            
            CGRect frame3 = [[ultimaFila objectAtIndex:3]frame];//signo mas
            frame3.origin.y=frame3.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame3];
            
            [ultimaFila replaceObjectAtIndex:0 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19]];
            [ultimaFila replaceObjectAtIndex:1 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31]];
            [ultimaFila replaceObjectAtIndex:2 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]];
            [ultimaFila replaceObjectAtIndex:3 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]];
            [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:3]];
        }
            [UIView commitAnimations];
            break;
        case 4:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
        {
            CGRect frame0 = [[ultimaFila objectAtIndex:0]frame];//label
            [(UILabel*)[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:20]setText:[NSString stringWithFormat:@"Respuesta %d: ",[[ultimaFila objectAtIndex:4]intValue]+1]];
            frame0.origin.y=frame0.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:20]setFrame:frame0];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:20]setAlpha:1.0f];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"-" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            button.tag=4;
            CGRect frame1 = [[ultimaFila objectAtIndex:1]frame];//signo menos
            frame1.origin.y=frame1.origin.y+38;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:32]setFrame:frame1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:32]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:32]addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame2 = [[ultimaFila objectAtIndex:2]frame];//textfield
            frame2.origin.y=frame2.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:10]setFrame:frame2];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:10]setAlpha:1.0f];
            
            CGRect frame3 = [[ultimaFila objectAtIndex:3]frame];//signo mas
            frame3.origin.y=frame3.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame3];
            
            [ultimaFila replaceObjectAtIndex:0 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:20]];
            [ultimaFila replaceObjectAtIndex:1 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:32]];
            [ultimaFila replaceObjectAtIndex:2 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:10]];
            [ultimaFila replaceObjectAtIndex:3 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]];
            [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:4]];
        }
            [UIView commitAnimations];
            break;
        case 5:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
        {
            CGRect frame0 = [[ultimaFila objectAtIndex:0]frame];//label
            [(UILabel*)[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:21]setText:[NSString stringWithFormat:@"Respuesta %d: ",[[ultimaFila objectAtIndex:4]intValue]+1]];
            frame0.origin.y=frame0.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:21]setFrame:frame0];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:21]setAlpha:1.0f];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [button setTitle:@"-" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            button.tag=5;
            CGRect frame1 = [[ultimaFila objectAtIndex:1]frame];//signo menos
            frame1.origin.y=frame1.origin.y+38;
            [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:33]setFrame:frame1];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:33]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:33]addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchUpInside];
            
            CGRect frame2 = [[ultimaFila objectAtIndex:2]frame];//textfield
            frame2.origin.y=frame2.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:11]setFrame:frame2];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:11]setAlpha:1.0f];
            
            CGRect frame3 = [[ultimaFila objectAtIndex:3]frame];//signo mas
            frame3.origin.y=frame3.origin.y+38;
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame3];
            
            [ultimaFila replaceObjectAtIndex:0 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:21]];
            [ultimaFila replaceObjectAtIndex:1 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:33]];
            [ultimaFila replaceObjectAtIndex:2 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:11]];
            [ultimaFila replaceObjectAtIndex:3 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]];
            [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:5]];
        }
            [UIView commitAnimations];
            break;
        case 6:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:12]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:22]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:33]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:34]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
        case 7:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:13]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:23]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:34]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:35]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
        case 8:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:14]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:24]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:35]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:36]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
        case 9:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:15]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:25]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:36]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:37]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
        case 10:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:16]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:26]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:37]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:38]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
        case 11:
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:17]setAlpha:1.0f];
            [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:27]setAlpha:1.0f];
         {
         CGRect frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];
         frame1.origin.y=frame1.origin.y+38;
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
         UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
         [button setTitle:@"-" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:20.0f];
         CGRect frame2 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:38]frame];
         frame2.origin.y=frame2.origin.y+38;
         [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]addSubview:button];
         [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:39]setFrame:frame2];
         }
            [UIView commitAnimations];
            break;
            
        default:
            break;
    }
}


//PENDIENTE 
-(IBAction)eliminarRespuesta:(id)sender{
    NSLog(@"eliminar fila %ld",(long)[sender tag]);
    switch ([sender tag]) {
        case 1:
            [self eliminarFila1];
            break;
        case 2:
            [self eliminarFila2];
            break;            
    }
}

-(void)eliminarFila1{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7]setAlpha:0.0f];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:17]setAlpha:0.0f];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:29]setAlpha:0.0];
    [self recorrerFilas:1 haciaArriba:2];
    NSLog(@"contlista %d",contLista );
}


-(void)eliminarFila2{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8]setAlpha:0.0f];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18]setAlpha:0.0f];
    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30]setAlpha:0.0];
    [self recorrerFilas:2 haciaArriba:2];
}


//revisar el contador de object 4
-(void)recorrerFilas:(int)filaEliminada haciaArriba:(int)filasDebajo{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    {
        for (int i=0; i<filasDebajo;i++) {
            switch (filaEliminada) {
                case 1:
                {
                    CGRect frame1;
                    if(i==0){
                        frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];//signo mas
                        frame1.origin.y=frame1.origin.y-38;
                        [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
                    }
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18+i]frame];//label
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18+i]setFrame:frame1];
                    UILabel *label=[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18+i];
                    label.text=[NSString stringWithFormat:@"Respuesta %d: ",i+1];
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8+i]frame];//TEXTFIELD
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8+i]setFrame:frame1];
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30+i]frame];//signo menos
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30+i]setFrame:frame1];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:7+i withSubviewAtIndex:8+i];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:17+i withSubviewAtIndex:18+i];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:29+i withSubviewAtIndex:30+i];
                    //[ultimaFila replaceObjectAtIndex:0 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:18+i]];
                    //[ultimaFila replaceObjectAtIndex:1 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:30+1]];
                    //[ultimaFila replaceObjectAtIndex:2 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:11]];
                    //[ultimaFila replaceObjectAtIndex:3 withObject:[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]];
                    [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:filaEliminada+filasDebajo]];
                }
                    break;
                case 2:
                {
                    CGRect frame1;
                    if(i==0){
                        frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]frame];//signo mas
                        frame1.origin.y=frame1.origin.y-38;
                        [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:28]setFrame:frame1];
                    }
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19+i]frame];//label
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19+i]setFrame:frame1];
                    UILabel *label=[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:19+i];
                    label.text=[NSString stringWithFormat:@"Respuesta %d: ",i+1];
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9+i]frame];//TEXTFIELD
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9+i]setFrame:frame1];
                    frame1 = [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31+i]frame];//signo menos
                    frame1.origin.y=frame1.origin.y-38;
                    [[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:31+i]setFrame:frame1];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:8+i withSubviewAtIndex:9+i];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:18+i withSubviewAtIndex:19+i];
                    [[viewsTipo objectAtIndex:self.num_pregunta_enc-1]exchangeSubviewAtIndex:28+i withSubviewAtIndex:31+i];
                    [ultimaFila replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:filaEliminada+filasDebajo]];
                }
                    break;
            }
            

        }
    }
    [UIView commitAnimations];
}


#pragma mark picker View

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.tipos_preg_enc.count;
}


-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [self.tipos_preg_enc objectAtIndex:row];
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}



-(void)reiniciarVistas{
    
    //Reiniciar lista
    contLista=1;
    [self.viewTexto setAlpha:0.0];
    [self.viewTextoP setAlpha:0.0];
    [self.viewLista setAlpha:0.0];
    self.anadir.frame=CGRectMake(self.anadir.frame.origin.x, 167, self.anadir.frame.size.width, self.anadir.frame.size.height);
    self.resp2L.alpha=0.0f;
    self.resp2LBL.alpha=0.0f;
    self.resp3L.alpha=0.0f;
    self.resp3LBL.alpha=0.0f;
    self.resp4L.alpha=0.0f;
    self.resp4LBL.alpha=0.0f;
    self.resp5L.alpha=0.0f;
    self.resp5LBL.alpha=0.0f;
    self.resp6L.alpha=0.0f;
    self.resp6LBL.alpha=0.0f;
    self.resp7L.alpha=0.0f;
    self.resp7LBL.alpha=0.0f;
    self.resp8L.alpha=0.0f;
    self.resp8LBL.alpha=0.0f;
    self.resp9L.alpha=0.0f;
    self.resp9LBL.alpha=0.0f;
    self.resp10L.alpha=0.0f;
    self.resp10LBL.alpha=0.0f;
    self.resp11L.alpha=0.0f;
    self.resp11LBL.alpha=0.0f;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    if ([[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:13]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:14]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:15]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:16]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:17]isEditing]) {
        NSLog(@"Objeto: %@",notification.object);
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad){
            CGSize tamano=[[UIScreen mainScreen]bounds].size;
            
            if(tamano.height<=1024){
                
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     [self.view setFrame:CGRectMake(0,-200,768,1024)];
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
            else {
                [UIView animateWithDuration:0.3
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     [self.view setFrame:CGRectMake(0,-200,1536,2048)];
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
        }
    }
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    if ([[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:13]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:14]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:15]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:16]isEditing] ||[[[[viewsTipo objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:17]isEditing]) {
        if([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPad){
            CGSize tamano=[[UIScreen mainScreen]bounds].size;
            
            if(tamano.height<=1024){
                
                [UIView animateWithDuration:0.1
                                      delay:0.0
                                    options: UIViewAnimationOptionCurveEaseIn
                                 animations:^{
                                     [self.view setFrame:CGRectMake(0,0,768,1024)];
                                 }
                                 completion:^(BOOL finished){
                                 }];
            }
            else {
                [UIView animateWithDuration:0.1
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


#pragma mark finalizar Encuesta

-(IBAction)finalizarEncuesta:(id)sender{
     UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Encuesta UEES" message:@"¿Está seguro que desea finalizar la encuesta?" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"OK", nil];
    [alerta show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
    if([title isEqualToString:@"OK"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"EncuestaF" object:self];
    }
    else if([title isEqualToString:@"Cancelar"])
    {
        
    }
}

@end
