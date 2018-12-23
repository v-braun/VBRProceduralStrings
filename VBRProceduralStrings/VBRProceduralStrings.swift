//
//  VBRProceduralStrings.swift
//  VBRProceduralStrings
//
//  Created by Viktor Braun on 23.12.2018.
//  Copyright © 2018 Viktor Braun - Software Development. All rights reserved.
//
import UIKit
import Macaw

public extension UIImageView {
    
    public func generate(settings : ProcStringsSettings){
        self.image = ProceduralStringGenerator.generateSVGImage(settings: settings)
    }
    
}

public class ProceduralStringGenerator{
    
    static public func generateSVGUIView(settings : ProcStringsSettings) -> UIView{
        let svg = ProceduralStringGenerator.generateSVGString(settings: settings)
        
        let node = try! SVGParser.parse(text: svg)
        let view = MacawView(node: node, frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(settings.width), height: CGFloat(settings.height)))
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.clear
        return view
    }
    
    static public func generateSVGImage(settings : ProcStringsSettings) -> UIImage{
        let view = generateSVGUIView(settings: settings)
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { context in
            return view.layer.render(in: context.cgContext)
        }
        
        return image
    }
    
    static public func generateSVGString(settings : ProcStringsSettings) -> String{
        let lines = generateLines(params: settings);
        var stops = "";
        for stop in settings.gradients {
//        stops += "<stop offset=\"0%\" stop-color=\"red\"/>";
            stops += "<stop offset=\"\(stop.offset)%\" stop-color=\"\(stop.color)\"/>";
        }
        
        
        var paths = "";
        for l in lines{
            let d = l.SvgD();
            let path = "<path fill=\"none\" stroke=\"url(#grad)\" d=\"\(d)\" ></path>";
            paths += path;
        }
        
        let result = """
        <svg width="\(settings.width)" height="\(settings.height)" xmlns="http://www.w3.org/2000/svg">
        <defs>
        <linearGradient id="grad" x1="0%" y1="0%" x2="100%" y2="0%">
        \(stops)
        </linearGradient>
        </defs>
        \(paths)
        </svg>
        """;
        
        return result;
    }
    
    static private func generateLines(params : ProcStringsSettings) -> [Line]{
        var result : [Line] = [];
        var prev : Line? = nil;
        
        let sinYMin : Float = 0;
        let sinYMax : Float = params.height;
        
        let sinXMin : Float = 0;
        let sinXMax : Float = 100;
        let xMoveCurves : Float = 2;
        
        var pointsRnd : [Int: PointConf] = [:];
        for str in 0..<params.lines {
            let l = Line();
            l.prev = prev;
            l.phase = str;
            
            for point in 0..<params.points{
                var x = (params.width / Float(params.points)) * Float(point);
                let xDelta = sinCurves(totalPhases: Float(params.lines), totalWaves: xMoveCurves, min: sinXMin, max: sinXMax, val: Float(str));
                x += xDelta;
                
                if(point == (params.points-1)){
                    x = params.width;
                }
                else if(point == 0){
                    x = 0;
                }
                
                
                if(pointsRnd[point] == nil){
                    let cfg = PointConf()
                    cfg.min = randomBetween(from: sinYMin, to: sinYMax)
                    cfg.max = randomBetween(from: sinYMin, to: sinYMax)
                    if cfg.min > cfg.max{
                        let m = cfg.min
                        cfg.min = cfg.max
                        cfg.max = m
                    }
                    cfg.initial = randomBetween(from: cfg.min, to: cfg.max)
                    pointsRnd[point] = cfg
                }
                
                let cfg = pointsRnd[point]!;
                let yDelta = sinCurves(totalPhases: Float(params.lines), totalWaves: 2, min: cfg.min, max: cfg.max, val: cfg.initial + Float(str));
                let y = 0 + yDelta;
                
                let p = Point();
                p.x = x
                p.y = y
                
                l.points.append(p);
            }
            
            prev = l;
            result.append(l)
        }
        
        return result;
    }
    static private func sinCurves(totalPhases : Float, totalWaves : Float, min : Float, max : Float, val : Float) -> Float{
        let middle = (max - min) / 2;
        var result = sin(val * (Float.pi * totalWaves / totalPhases))
        result = min + middle + result * middle;
        return result;
    }
    static private func randomBetween(from : Float, to : Float) -> Float{
        let res = Float.random(in: from...to)
        return res
    }
}


public class ProcStringsSettings{
    public init(){
        
    }
    public var width : Float = 100;
    public var height : Float = 100;
    public var points : Int = 10;
    public var lines : Int = 100;
    public var gradients : [GradientStep] = []
}

public class GradientStep{
    public init(offset: Float, color: String){
        self.offset = offset
        self.color = color
    }
    public var offset : Float = 0
    public var color : String = "red"
}

fileprivate class PointConf {
    var min : Float = 0;
    var max : Float = 0;
    var initial : Float = 0;
}

fileprivate class Point {
    var x : Float = 0;
    var y : Float = 0;
}
fileprivate class Line {
    var phase : Int = 0;
    
    var curve : Float = 10;
    
    /** @type {Point[]} */
    var points : [Point] = [];
    
    /** @type {Line} */
    var prev : Line? = nil;
    
    func SvgD() -> String {
        var result = "";
        for i in 0..<self.points.count{
            let p = self.points[i];
            var svgP = "";
            if(i == 0){
                svgP = "M \(p.x) \(p.y)";
            }
            else{
                let prevP = self.points[i - 1];
                svgP = " C \(prevP.x + self.curve) \(prevP.y) \(p.x - self.curve) \(p.y) \(p.x) \(p.y)"
            }
            
            result += svgP;
        }
        
        return result;
    }
}
