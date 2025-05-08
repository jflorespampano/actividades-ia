/**
 * clase para graficar un conjunto de puntos (x,y)
 * en un canvas 2D.
 * @class clsGraficas
 * @param {object} ctx - contexto del canvas 2D.
 * @param {array} puntos_x - arreglo de puntos x.
 * @param {array} puntos_y - arreglo de puntos y.
 * 
 */
class clsGraficas{
    //recibe en ctx el getContext("2d")
    constructor(ctx, puntos_x, puntos_y){
        this.ctx=ctx;
        this.area_grafica={
            "alto_canvas":0,
            "ancho_canvas":0,
            "maxx":0,
            "maxy":0,
            "minx":0,
            "miny":0,
            "ancho_grafica":0,
            "alto_grafica":0
        }
        this.area_grafica.alto_canvas=ctx.canvas.clientHeight-10;
        this.area_grafica.ancho_canvas=ctx.canvas.clientWidth-10;
        this.area_grafica.maxx = Math.max(...puntos_x)+1;
        this.area_grafica.maxy = Math.max(...puntos_y)+1;
        this.area_grafica.minx = Math.min(...puntos_x)-1;
        this.area_grafica.miny = Math.min(...puntos_y)-1;
        this.area_grafica.ancho_grafica = this.area_grafica.maxx-this.area_grafica.minx;
        this.area_grafica.alto_grafica = this.area_grafica.maxy-this.area_grafica.miny;
    }

    /**
     * 
     * @param {*} puntos [{"x":5.2, "y":2.3, "clase":1},...]
     */
    graficaArrayObject(puntos){
        var xMax=this.area_grafica.maxx, yMax=this.area_grafica.maxy;
        var xMin=this.area_grafica.minx, yMin=this.area_grafica.miny;
        var xRange=xMax-xMin;
        var yRange=yMax-yMin;
        const ctx=this.ctx;
        for (var i=0; i<puntos.length; i++){
            if (puntos[i].clase==1){
                ctx.fillStyle="blue";
            }else{
                ctx.fillStyle="red";
            }
            ctx.beginPath();
            ctx.arc((puntos[i].x-xMin)*canvas.width/xRange, (puntos[i].y-yMin)*canvas.height/yRange, 5, 0, Math.PI*2);
            ctx.fill();
        }
    }

    /**
     * 
     * @param {*} puntos [[x,y,clase],...]
     */
    graficaArray(puntos){
        var xMax=this.area_grafica.maxx, yMax=this.area_grafica.maxy;
        var xMin=this.area_grafica.minx, yMin=this.area_grafica.miny;
        var xRange=xMax-xMin;
        var yRange=yMax-yMin;
        const ctx=this.ctx;
        for (var i=0; i<puntos.length; i++){
            if (puntos[i][2]==1){
                ctx.fillStyle="blue";
            }else{
                ctx.fillStyle="red";
            }
            ctx.beginPath();
            ctx.arc((puntos[i][0]-xMin)*canvas.width/xRange, (puntos[i][1]-yMin)*canvas.height/yRange, 5, 0, Math.PI*2);
            ctx.fill();
        }
    }

    /**
     * 
     * @param {*} objeto {"x":0, "y":0, "clase":0}
     * @param {*} radio radio del punto (5px)
     * @param {*} color1 es color de linea del punto
     * @param {*} color2 es color relleno del punto
     */
    pon_punto(objeto, radio, color1, color2){
        this.ctx.save();
        this.ctx.strokeStyle=color1;
        this.ctx.fillStyle=color2;
        this.ctx.beginPath();
        //obtener alto del canvas
        let ancho_canvas=this.area_grafica.ancho_canvas-5;
        let alto_canvas=this.area_grafica.alto_canvas-5;
        let maxx=this.area_grafica.maxx;
        let maxy=this.area_grafica.maxy;
        //poner a escala
        let py=objeto.y;
        py=py*alto_canvas/maxy;
        let px=objeto.x;
        px=px*ancho_canvas/maxx;
        //console.log("x="+px+" y="+py);
        //invierte coordenadas
        py=alto_canvas-py;
        this.ctx.arc(px, py, radio, 0, 2*Math.PI);
        if(color2) {this.ctx.fill()} else {ctx.stroke()};
        this.ctx.stroke();
        this.ctx.restore();
    }

    /**
     * 
     * @param {*} puntos con formato [[x,y,clase],...]
     */
    grafica_puntos(puntos){
        let punto={};
        let color="blue";
        //obtener valores del canvas
        this.area_grafica.alto_canvas=this.ctx.canvas.clientHeight-5;
        this.area_grafica.ancho_canvas=this.ctx.canvas.clientWidth-5;
        //obtener valores máximos x e y
        let puntos_x = puntos.map(function(value,index) { return value[0]; });
        let puntos_y = puntos.map(function(value,index) { return value[1]; });
        //let col3 = puntos.map(function(value,index) { return value[2]; });
        this.area_grafica.maxx = Math.max(...puntos_x)+1;
        this.area_grafica.maxy = Math.max(...puntos_y)+1;
        
        puntos.forEach(elem=>{
            punto={"x":0, "y":0, "clase":0};
            punto.x=elem[0];
            punto.y=elem[1];
            punto.clase=elem[2];
            color=(punto.clase==1)?"blue":"green";
            this.pon_punto(punto, 5, "red", color)
        });
    }
    
}//fin de clase clsGraficas