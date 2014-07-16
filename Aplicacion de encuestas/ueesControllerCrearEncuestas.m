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
    
    //Arrays que contienen los datos de las preguntas
    
    NSMutableArray *datosTexto;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    
    NSMutableArray *datosTextoParrafo;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    
    NSMutableArray *datosTest;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    //respuesta_1 4
    //respuesta...
    //respuesta_10 13
    
    NSMutableArray *datosCasillasVeri;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    //respuesta_1 4
    //respuesta...
    //respuesta_10 13
    
    NSMutableArray *datosLista;
    NSMutableArray *respuestas;
    
    //tipo_preg 0
    
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    //respuestas 4
    
    
    NSMutableArray *datosEscala;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    //valor minimo 4
    //valor maximo 5
    //etiqueta minimo 6
    //etiqueta maximo 7
    
    NSMutableArray *datosTabla;
    //tipo_preg 0
    //obligatorio 1
    //titulo_preg 2
    //texto_ayuda 3
    //array filas 4 NSMUTABLEARRAY
    //array columnas 5 NSMUTABLEARRAY
    
    NSMutableArray *array_filas;
    //fila_1
    //fila_2
    NSMutableArray *array_colum;
    //colum_1
    //colum_2

    
    
    int tipo_pregunta;
    int contLista;
    UIView *actualView,*viewVacia;
    NSMutableArray *views;
    //NSMutableArray *viewsTipo;
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
    
    //viewsTipo=[[NSMutableArray alloc]init];
    //self.viewInicial.tag=self.num_pregunta_enc;
    //[views addObject:self.viewInicial];
    //id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewInicial]];
    //viewVacia = (UIView *)vistaCopia;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    views=[[NSMutableArray alloc]init];
    self.preguntas_enc=[[NSMutableArray alloc]init];//se inicializa el array que contiene todas preguntas y sus datos
    NSString *path = [[NSBundle mainBundle] pathForResource: @"ConfiguracionApp" ofType: @"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
    self.tipos_preg_enc =[dict objectForKey: @"tipos_preguntas"];//se inicializa el array que contiene los tipos de pregunta para despues setearlos en el pickerView
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];//añade un observador cuando el teclado se muestra
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];//añade un observador cuando el teclado se esconde
    
    self.navigationItem.title=self.titulo;
    self.view.backgroundColor=self.color;
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)tipoDePregunta:(id)sender{
    UIView *view;//se crea el view que muestra la pregunta
    tipo_pregunta=[self.tipoPregunta selectedRowInComponent:0];
    NSLog(@"tipo pregunta %d",tipo_pregunta);
    switch (tipo_pregunta) {
        case 0:
            {
                if ([views count]) {
                    
                    if ([views count]<self.num_pregunta_enc) {//si hay menos views que preguntas
                    }
                    else{
                            NSLog(@"views count %d",[views count]);
                            NSLog(@"num_preg_enc %d",self.num_pregunta_enc);
                            [UIView beginAnimations:nil context:NULL];
                            [UIView setAnimationDuration:0.8];
                            [[views objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];//si ya existe una view en esa pregunta, se la remplaza por la nueva seleccion
                            [UIView commitAnimations];
                            
                            [views removeObjectAtIndex:self.num_pregunta_enc-1];
                    }
                }
                
                datosTexto=[[NSMutableArray alloc]init];//se crea el array que contiene los datos de la vista
                NSNumber *tipoPreg=[NSNumber numberWithInt:0];
                [datosTexto addObject:tipoPreg];//se añade el tipo de pregunta (0 texto)
            id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewTexto]];//se crea una nueva vista a partir de la vidta texto definida en el storyboard
                view = (UIView *)vistaCopia;
                view.frame = CGRectMake(view.frame.origin.x, 380, view.frame.size.width, view.frame.size.height );
                [views insertObject:view atIndex:self.num_pregunta_enc-1];//se añade la vista en el array de vistas totales de la aplicación
                
            }
            
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].borderWidth=2.0f;
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].cornerRadius = 8;
            [self.view addSubview:[views objectAtIndex:self.num_pregunta_enc-1]];//se añade el view a la pantalla
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0f];//se setea la transparencia en 1
            [UIView commitAnimations];
            break;
        case 1:
        {
            if ([views count]) {
                
                if ([views count]<self.num_pregunta_enc) {//si hay menos views que preguntas
                }
                else{
                    NSLog(@"views count %d",[views count]);
                    NSLog(@"num_preg_enc %d",self.num_pregunta_enc);
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.8];
                    [[views objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];//si ya existe una view en esa pregunta, se la remplaza por la nueva seleccion
                    [UIView commitAnimations];
                    
                    [views removeObjectAtIndex:self.num_pregunta_enc-1];
                }
            }
                datosTextoParrafo=[[NSMutableArray alloc]init];//se crea el array que contiene los datos de la vista
                NSNumber *tipoPreg=[NSNumber numberWithInt:1];
                [datosTextoParrafo addObject:tipoPreg];//se añade el tipo de pregunta (1 texto parrafo)
                id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewTextoP]];//se crea una nueva vista a partir de la vidta texto definida en el storyboard
                view = (UIView *)vistaCopia;
                view.frame = CGRectMake(view.frame.origin.x, 380, view.frame.size.width, view.frame.size.height );
                [views insertObject:view atIndex:self.num_pregunta_enc-1];//se añade la vista en el array de vistas totales de la aplicación
                
            }
            
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].borderWidth=2.0f;
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[views objectAtIndex:self.num_pregunta_enc-1]layer].cornerRadius = 8;
            
            [[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].borderWidth=1.0f;
            [[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].borderColor = [[UIColor lightGrayColor] CGColor];
            [[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]layer].cornerRadius = 8;
            
            [self.view addSubview:[views objectAtIndex:self.num_pregunta_enc-1]];//se añade el view a la pantalla
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0f];//se setea la transparencia en 1
            
            [UIView commitAnimations];
            break;
        case 4:
        {
            if ([views count]) {
                
                if ([views count]<self.num_pregunta_enc) {//si hay menos views que preguntas
                }
                else{
                    NSLog(@"views count %d",[views count]);
                    NSLog(@"num_preg_enc %d",self.num_pregunta_enc);
                    [UIView beginAnimations:nil context:NULL];
                    [UIView setAnimationDuration:0.8];
                    [[views objectAtIndex:self.num_pregunta_enc-1]removeFromSuperview];//si ya existe una view en esa pregunta, se la remplaza por la nueva seleccion
                    [UIView commitAnimations];
                    
                    [views removeObjectAtIndex:self.num_pregunta_enc-1];
                }
            }
            datosLista=[[NSMutableArray alloc]init];
            [datosLista removeAllObjects];
            //se crea el array que contiene los datos de la vista
            NSNumber *tipoPreg=[NSNumber numberWithInt:4];
            
            [datosLista addObject:tipoPreg];//se añade el tipo de pregunta (4 Lista)
            id vistaCopia =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self.viewLista]];//se crea una nueva vista a partir de la vidta texto definida en el storyboard
            view = (UIView *)vistaCopia;
            view.frame = CGRectMake(view.frame.origin.x, 380, view.frame.size.width, view.frame.size.height );
            [views insertObject:view atIndex:self.num_pregunta_enc-1];//se añade la vista en el array de vistas totales de la aplicación
            [[views objectAtIndex:self.num_pregunta_enc-1]setTag:4];
            
        }
            [[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8]addTarget:self action:@selector(aumentarRespuesta:) forControlEvents:UIControlEventTouchDown];
            
            respuestas=[[NSMutableArray alloc]init];
            [respuestas removeAllObjects];
            NSArray *respuesta=[[NSArray alloc]initWithObjects:@[[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6],[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7],[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:8],[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]], nil];
            [respuestas addObject:respuesta];
            
            [self.view addSubview:[views objectAtIndex:self.num_pregunta_enc-1]];//se añade el view a la pantalla
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0f];//se setea la transparencia en 1
            
            [UIView commitAnimations];
            break;
    }
    if(self.num_pregunta_enc-1==[self.preguntas_enc count]){
        self.nuevoElemento.alpha=1.0f;
        self.finalizarEncuesta.alpha=1.0f;
    }
    
}


#pragma mark siguiente/atras

-(IBAction)nuevaPregunta:(id)sender{
    NSLog(@"/////Nueva pregunta/////");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if ([views count]<self.num_pregunta_enc) {
        UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Advertencia" message:@"Por favor, seleccione un tipo de pregunta" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Aceptar", nil];
        [alerta show];
    }
    else{
        if ([self.preguntas_enc count]+1==self.num_pregunta_enc) {
            NSLog(@"pregunta nueva");
            switch (tipo_pregunta) {
                case 0:
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc addObject:datosTexto];
                    
                    break;
                case 1:
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc addObject:datosTextoParrafo];
                    break;
                case 4:
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:3]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]];
                    [datosLista addObject:respuestas];
                    [self.preguntas_enc addObject:datosLista];
                    break;
                    
                default:
                    break;
            }
        }
        else{
            NSLog(@"pregunta existente");
            switch ([[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:0]intValue]) {
                    
                case 0:
                    NSLog(@"DATOS TEXTO");
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTexto];
                    
                    break;
                case 1:
                    NSLog(@"DATOS TEXTO PARRAFO");
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTextoParrafo];
                    break;
                case 4:
                    NSLog(@"DATOS LISTA");
                {
                    NSNumber *tipo_pregg=[datosLista objectAtIndex:0];
                    [datosLista removeAllObjects];
                    [datosLista addObject:tipo_pregg];
                }
                    
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:3]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]];
                    [datosLista addObject:respuestas];
                    [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosLista];
                    break;
                    
                default:
                    break;
            }

        }
        
        
        /*for (int i=0; i<[[self.preguntas_enc objectAtIndex:i]count]; i++) {
            NSLog(@"Tipo de pregunta: %d",[[[self.preguntas_enc objectAtIndex:i]objectAtIndex:0]intValue]);
            NSLog(@"Obligatorio: %ld",(long)[[[self.preguntas_enc objectAtIndex:i]objectAtIndex:1]selectedSegmentIndex]);
        }*/
        [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
        self.num_pregunta_enc++;
        NSLog(@"numero de views: %d",[views count]);
        NSLog(@"numero de preguntas: %d",[self.preguntas_enc count]);
        NSLog(@"numero de pregunta: %d",self.num_pregunta_enc);
        self.pregAnterior.alpha=1.0f;
        self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    }
   
    [UIView commitAnimations];
}

-(IBAction)siguientePregunta:(id)sender{
    NSLog(@"/////Siguiente pregunta/////");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    switch ([[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:0]intValue]) {
            
        case 0:
            NSLog(@"DATOS TEXTO");
            [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
            [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
            [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
            [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTexto];
            
            break;
        case 1:
            NSLog(@"DATOS TEXTO PARRAFO");
            [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
            [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
            [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
            [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTextoParrafo];
            break;
        case 4:
            NSLog(@"DATOS LISTA");
        {
            NSNumber *tipo_pregg=[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:0];
            [datosLista removeAllObjects];
            [datosLista addObject:tipo_pregg];
        }
            [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:3]];
            [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4]];
            [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]];
            [datosLista addObject:respuestas];
            [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosLista];
            NSLog(@"count respuestas en array antes: %d",[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count]);
            NSLog(@"---descripcion preguntas index %d---%@",self.num_pregunta_enc-1,[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]);
            break;
            
        default:
            break;
    }
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
    self.pregAnterior.alpha=1.0f;
    NSLog(@"numero de views: %d",[views count]);
    NSLog(@"numero de preguntas: %d",[self.preguntas_enc count]);
    NSLog(@"numero de pregunta: %d",self.num_pregunta_enc);
    if (self.num_pregunta_enc==[views count]) {
        NSLog(@"la siguiente no tiene  view");
        if ([self.preguntas_enc count]==self.num_pregunta_enc) {
            NSLog(@"es la ultima pregunta");
            self.pregSiguiente.alpha=0.0f;
            self.nuevoElemento.alpha=1.0f;
        }
    }
    else{
        NSLog(@"la siguiente si tiene  view");
        
        switch ([[views objectAtIndex:self.num_pregunta_enc]tag]) {
            case 4:
                [respuestas removeAllObjects];
                NSLog(@"count respuestas en array despues: %d",[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count]);
                /*se esta vaciando el array respuestas almacenado en el nsmutablearray cuando se vacia el array respuestas normal, primera solucion hacer una copia del array respuesta, no referenciarlo*/
                [respuestas addObjectsFromArray:[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc]objectAtIndex:4]];
                NSLog(@"cont items respuestas: %d",[respuestas count]);
                NSLog(@"cont items lista: %d",[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc]objectAtIndex:4]count]);
        }
        
        if ([self.preguntas_enc count]==self.num_pregunta_enc+1) {
            NSLog(@"es la ultima pregunta");
            self.pregSiguiente.alpha=0.0f;
            self.nuevoElemento.alpha=1.0f;
            
        }
        [[views objectAtIndex:self.num_pregunta_enc]setAlpha:1.0];
    }
    self.num_pregunta_enc++;

            //self.pregSiguiente.alpha=0.0f;
            //self.nuevoElemento.alpha=1.0f;

    
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    [UIView commitAnimations];
}

-(IBAction)preguntaAnterior:(id)sender{
    NSLog(@"/////Nueva anterior/////");
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if ([self.preguntas_enc count]+1==self.num_pregunta_enc) {
        NSLog(@"pregunta final");
        if (self.num_pregunta_enc>[views count]) {
            NSLog(@"no tiene view");
        }
        else{
            NSLog(@"si tiene view");
            switch ([[views objectAtIndex:self.num_pregunta_enc-1]tag]) {
                    
                case 0:
                    NSLog(@"DATOS TEXTO");
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc addObject:datosTexto];
                    
                    break;
                case 1:
                    NSLog(@"DATOS TEXTO PARRAFO");
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                    [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                    [self.preguntas_enc addObject:datosTextoParrafo];
                    break;
                case 4:
                    NSLog(@"DATOS LISTA");
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:3]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4]];
                    [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]];
                    [datosLista addObject:respuestas];
                    [self.preguntas_enc addObject:datosLista];
                    break;
                    
                default:
                    break;
            }
            [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];
        }
        
        
    }
    else{
         NSLog(@"pregunta vieja");
        switch ([[views objectAtIndex:self.num_pregunta_enc-1]tag]) {
               
            case 0:
                NSLog(@"DATOS TEXTO");
                [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                [datosTexto addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTexto];
                
                break;
            case 1:
                NSLog(@"DATOS TEXTO PARRAFO");
                [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]];
                [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:1]];
                [datosTextoParrafo addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:2]];
                [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosTextoParrafo];// aqui esta el error
                break;
            case 4:
                NSLog(@"DATOS LISTA");
            {
                NSNumber *tipo_pregg=[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:0];
                [datosLista removeAllObjects];
                [datosLista addObject:tipo_pregg];
            }
                [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:3]];
                [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:4]];
                [datosLista addObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:5]];
                [datosLista addObject:respuestas];
                [self.preguntas_enc replaceObjectAtIndex:self.num_pregunta_enc-1 withObject:datosLista];
                break;
                
            default:
                break;
        }
        [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:0.0];

    }
    
    self.pregSiguiente.alpha=1.0f;
    self.nuevoElemento.alpha=0.0f;
     NSLog(@"cont items lista actual: %d",[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count]);
    self.num_pregunta_enc--;
    
    NSLog(@"numero de views: %d",[views count]);
    NSLog(@"numero de preguntas: %d",[self.preguntas_enc count]);
    NSLog(@"numero de pregunta: %d",self.num_pregunta_enc);
   
    switch ([[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:0]intValue]) {
        case 4:
            [respuestas removeAllObjects];
            [respuestas addObjectsFromArray:[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]];
            NSLog(@"cont items respuestas: %d",[respuestas count]);
            NSLog(@"cont items lista siguiente pregunta: %d",[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count]);
            break;
    }
    
    
    [[views objectAtIndex:self.num_pregunta_enc-1]setAlpha:1.0];
    if(self.num_pregunta_enc==1){
         self.pregAnterior.alpha=0.0f;
    }
    self.numPregLB.text=[NSString stringWithFormat:@"Pregunta %d",self.num_pregunta_enc];
    [UIView commitAnimations];
}

#pragma mark - Lista


#pragma mark Aumentar y/o eliminar respuestas

-(void)aumentarRespuesta:(id)sender{
    //if ([views count]==self.num_pregunta_enc) {
        int posY=[[[[respuestas lastObject]objectAtIndex:0]objectAtIndex:0]frame].origin.y;
        NSLog(@"posicion y: %d",posY);
        NSLog(@"cont respuestas: %d",respuestas.count);
        if (posY>=509) {
        }
        else{
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            
            id copiaText =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]]];
            UIView *textfield = (UIView *)copiaText;
            textfield.frame = CGRectMake(textfield.frame.origin.x, posY+38, textfield.frame.size.width, textfield.frame.size.height);
            id copiaLabel =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7]]];
            UILabel *label = (UILabel *)copiaLabel;
            label.frame = CGRectMake(label.frame.origin.x, posY+38, label.frame.size.width, label.frame.size.height);
            label.text=[NSString stringWithFormat:@"Respuesta %lu:",(unsigned long)respuestas.count+1];
            [[[[respuestas objectAtIndex:0]lastObject]objectAtIndex:2]setFrame:CGRectMake([[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.x, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.y+38, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.width, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.height)];
            id copiaMenos =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]]];
            UIButton *menos = (UIButton *)copiaMenos;
            menos.frame = CGRectMake(menos.frame.origin.x, posY+38, menos.frame.size.width, menos.frame.size.height);
            menos.tag=respuestas.count;
            [menos addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchDown];
            
            NSArray *respuesta=[[NSArray alloc]initWithObjects:@[textfield,label,menos], nil];
            [respuestas addObject:respuesta];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:textfield];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:label];
            //[[views objectAtIndex:self.num_pregunta_enc-1]addSubview:mas];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:menos];
            
            
            [UIView commitAnimations];
        }
        
        
   // }
    /*else{
        NSLog(@"pasa x aqui 1");
        int posY=[[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]lastObject]objectAtIndex:0]objectAtIndex:0]frame].origin.y;
        NSLog(@"posicion y: %d",posY);
        if (posY>=509) {
        }
        else{
            
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.8];
            
            id copiaText =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:6]]];
            UIView *textfield = (UIView *)copiaText;
            textfield.frame = CGRectMake(textfield.frame.origin.x, posY+38, textfield.frame.size.width, textfield.frame.size.height);
            id copiaLabel =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:7]]];
            UILabel *label = (UILabel *)copiaLabel;
            label.frame = CGRectMake(label.frame.origin.x, posY+38, label.frame.size.width, label.frame.size.height);
            label.text=[NSString stringWithFormat:@"Respuesta %lu:",(unsigned long)[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count]+1];
            [[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]setFrame:CGRectMake([[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4] objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.x, [[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4] objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.y+38, [[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4] objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.width, [[[[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4] objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.height)];
            id copiaMenos =[NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[[[views objectAtIndex:self.num_pregunta_enc-1]subviews]objectAtIndex:9]]];
            UIButton *menos = (UIButton *)copiaMenos;
            menos.frame = CGRectMake(menos.frame.origin.x, posY+38, menos.frame.size.width, menos.frame.size.height);
            menos.tag=[[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4]count];
            [menos addTarget:self action:@selector(eliminarRespuesta:) forControlEvents:UIControlEventTouchDown];
            
            NSArray *respuesta=[[NSArray alloc]initWithObjects:@[textfield,label,menos], nil];
            [[[self.preguntas_enc objectAtIndex:self.num_pregunta_enc-1]objectAtIndex:4] addObject:respuesta];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:textfield];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:label];
            //[[views objectAtIndex:self.num_pregunta_enc-1]addSubview:mas];
            [[views objectAtIndex:self.num_pregunta_enc-1]addSubview:menos];
            
            
            [UIView commitAnimations];
        }
    }*/
    
}

-(void)eliminarRespuesta:(id)sender{
    int posY=[[[[respuestas lastObject]lastObject]objectAtIndex:0]frame].origin.y;
    NSLog(@"posicion y: %d",posY);
    if (posY<=167) {
    }
    else{
        
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.8];
        

        NSLog(@"descripcion: %@",[[[[respuestas objectAtIndex:self.num_pregunta_enc-1]lastObject]objectAtIndex:0] description]);
        [[[[respuestas lastObject]lastObject]objectAtIndex:0]removeFromSuperview];
        [[[[respuestas lastObject]lastObject]objectAtIndex:1]removeFromSuperview];
        [[[[respuestas lastObject]lastObject]objectAtIndex:2]removeFromSuperview];
        [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]setFrame:CGRectMake([[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.x, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].origin.y-38, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.width, [[[[respuestas objectAtIndex:0]objectAtIndex:0]objectAtIndex:2]frame].size.height)];
        
        [respuestas removeObjectAtIndex:[sender tag]];
        
        /*for (int i=0; i<respuestas.count; i++) {
            <#statements#>
        }*/
        
        
        [UIView commitAnimations];
    }
}

/*



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

*/


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
/*
#pragma mark - Notificaciones Keyboard

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
}*/

@end
