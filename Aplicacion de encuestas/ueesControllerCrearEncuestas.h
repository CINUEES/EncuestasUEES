//
//  ueesControllerCrearEncuestas.h
//  Aplicacion de encuestas
//
//  Created by Centro de Investigaciones on 14/11/13.
//  Copyright (c) 2013 Centro de Investigaciones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ueesControllerCrearEncuestas : UIViewController<UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>


//Variables Generales de creación de encuestas
@property NSString *nombre_enc;
@property NSString *descrip_enc;
@property int tema_enc;
@property NSString *msj_inicio_enc;
@property NSString *msj_fin_enc;
@property NSArray *tipos_preg_enc;
@property NSMutableArray *preguntas_enc;
@property NSMutableArray *views_enc;
@property int num_pregunta_enc;


//@property (nonatomic,weak) IBOutlet UIView *viewInicial;
@property (nonatomic,weak) IBOutlet UILabel *numPregLB;
@property (nonatomic,weak) IBOutlet UIPickerView *tipoPregunta;
@property (nonatomic,weak) IBOutlet UIButton *nuevoElemento;
@property (nonatomic,weak) IBOutlet UIButton *pregAnterior;
@property (nonatomic,weak) IBOutlet UIButton *pregSiguiente;
@property (nonatomic,weak) IBOutlet UIButton *finalizarEncuesta;

@property NSString *titulo;
@property NSString *numPregunta;
@property UIColor *color;


#pragma mark - texto

@property (nonatomic,weak) IBOutlet UIView *viewTexto;


#pragma mark - texto párrafo

@property (nonatomic,weak) IBOutlet UIView *viewTextoP;


#pragma mark - Lista

@property (nonatomic,weak) IBOutlet UIView *viewLista;

@end
