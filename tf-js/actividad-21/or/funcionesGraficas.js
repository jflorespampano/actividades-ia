var area_grafica={
    "alto_canvas":0,
    "ancho_canvas":0,
    "alto_grafica":0,
    "ancho_grafica":0,
    "minx":0,
    "miny":0,
    "maxx":0,
    "maxy":0,
    "padding":5
};
//puntos a graficar
var puntos=[
    {"x":-1, "y":-1, "clase":-1},
    {"x":-1, "y": 1, "clase": 1},
    {"x": 1, "y":-1, "clase": 1},
    {"x": 1, "y": 1, "clase": 1}
    
    ];
/**
 * Traza una linea con los valores dados w0, w1 para x1*w1+x0*w0
 * @w0 {float} - valor de w0
 * @w1 {float} - valor de w1
 */
function linea(ctx,w0,w1){
    ctx.save();
    ctx.beginPath()
    // let radio=1;
    let ancho_canvas=area_grafica.ancho_canvas;
    let alto_canvas=area_grafica.alto_canvas;
    let maxx=area_grafica.maxx;
    let maxy=area_grafica.maxy;
    let minx=area_grafica.minx;
    let miny=area_grafica.miny;
    let padding=area_grafica.padding;
    //calcula punto uno segun formula de linea
    let x=minx; //que corresponde al punto minimo de la grafica
    let px=(x-minx)*ancho_canvas/(maxx-minx)+padding;
    let y=w0+w1*x;
    //ajusta escala
    let py=(y-miny)*alto_canvas/(maxy-miny);
    //invierte coordenadas
    py=alto_canvas-py+padding;
    //ir al punto 1 sin graficar
    ctx.moveTo(px, py);
    //toma el ultimo punto x del canvas
    x=maxx; //que corresponde al punto ancho_canvas de la ventana
    //px=ancho_canvas;
    px=(maxx-minx)*ancho_canvas/(maxx-minx)+padding;
    //calcula punto 2 segun formula de linea
    y=w0+w1*x;
    //ajusta escala
    py=(y-miny)*alto_canvas/(maxy-miny);
    //invierte coordenadas
    py=alto_canvas-py;
    ctx.lineTo(px, py);
    ctx.stroke();
    
    ctx.restore();
}
/**
 * Traza una linea con los valores actuales de w en la variable json llamada per
 * @ctx {objeto} - contexto del canvas
 * @color {string} - color de la linea
 */
function lineaPerceptron(ctx,color){
    ctx.save();
    ctx.beginPath()
    // let radio=1;
    let ancho_canvas=area_grafica.ancho_canvas;
    let alto_canvas=area_grafica.alto_canvas;
    let maxx=area_grafica.maxx;
    let maxy=area_grafica.maxy;
    let minx=area_grafica.minx;
    let miny=area_grafica.miny;
    let padding=area_grafica.padding;
    //calcula punto uno segun formula de linea
    let x=minx; //que corresponde al punto minimo de la grafica
    let px=(x-minx)*ancho_canvas/(maxx-minx)+padding;
    //let y=w0+w1*x;
    //0=W[0]*x0+w[1]*x1+w[2]
    //x1=-(w[0]*x0)-w[2]/w[1]
    let y=(-1*(per.W[0]*x)-per.W[2])/per.W[1];
    //ajusta escala
    let py=(y-miny)*alto_canvas/(maxy-miny);
    //invierte coordenadas
    py=alto_canvas-py+padding;
    //ir al punto 1 sin graficar
    ctx.moveTo(px, py);
    //console.log("x0= "+px+" y0="+py);
    //toma el ultimo punto x del canvas
    x=maxx; //que corresponde al punto ancho_canvas de la ventana
    //calcula punto 2 segun formula de linea
    y=(-1*(per.W[0]*x)-per.W[2])/per.W[1];
    px=(x-minx)*ancho_canvas/(maxx-minx);
    py=(y-miny)*alto_canvas/(maxy-miny);
    //ajusta escala
    py=(y-miny)*alto_canvas/(maxy-miny);
    //invierte coordenadas
    py=alto_canvas-py+padding;
    //console.log("x1= "+px+" y1="+py);
    ctx.strokeStyle=color;
    ctx.lineTo(px, py);
    ctx.stroke();
    ctx.restore();
}
/**
 * pone un punto en el canvas
 * @ctx {objeto} - contexto del canvas
 * @objeto {json} - punto a graficar {"x":0, "y":0, "clase":-1}
 * @radio {int} - radio del circulo
 * @color1 {string} - color del circulo
 * @color2 {string} -color borde del circulo
 */
function pon_punto(ctx, objeto, radio, color1, color2){
    ctx.save();
    ctx.strokeStyle=color1;
    ctx.fillStyle=color2;
    ctx.beginPath();
    //obtener alto del canvas
    let ancho_canvas=area_grafica.ancho_canvas;
    let alto_canvas=area_grafica.alto_canvas;
    let maxx=area_grafica.maxx;
    let maxy=area_grafica.maxy;
    let minx=area_grafica.minx;
    let miny=area_grafica.miny;
    let padding=area_grafica.padding;
    //poner a escala
    let py=objeto.y;
    py=(py-miny)*alto_canvas/(maxy-miny);
    let px=objeto.x;
    px=(px-minx)*ancho_canvas/(maxx-minx)+padding;
    //console.log("x="+px+" y="+py);
    //invierte coordenadas
    py=alto_canvas-py+padding;
    ctx.arc(px, py, radio, 0, 2*Math.PI);
    if(color2) {ctx.fill()} else {ctx.stroke()};
    ctx.stroke();
    ctx.restore();
}
/**
 * pon el centro de la gráfica
 */
function ponCentro(){
    ctx.save();
    let texto="(0,0)";
    ctx.beginPath();
    let px=area_grafica.ancho_canvas/2;
    let py=area_grafica.alto_canvas/2;
    //
    ctx.strokeText(texto,px-23,py+10);
    ctx.strokeText("-1",0,py+10);
    ctx.strokeText("1",area_grafica.ancho_canvas-5,py+10);
    ctx.strokeText("1",px-9,10);
    ctx.strokeText("-1",px-12,area_grafica.alto_canvas);
    //
    ctx.moveTo(px,0);
    ctx.lineTo(px,area_grafica.alto_canvas)
    ctx.stroke()
    ctx.moveTo(0,py);
    ctx.lineTo(area_grafica.ancho_canvas,py)
    ctx.stroke();
    ctx.restore();
}
signo=x=>(x<0)?-1:1;
