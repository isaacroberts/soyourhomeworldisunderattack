// Author: Joseph Silverstein
// Noise functions: @patriciogv - 2015
// http://patriciogonzalezvivo.com
//
// I highly recommend bookofshaders.com
// Non-programmers could learn programming through it

#version 460 core

#include <flutter/runtime_effect.glsl>
precision mediump float;

//Return value
out vec4 fragColor;


uniform vec2 u_resolution;

uniform float u_time;

//Front smoke
uniform vec3 cloudColor;
uniform float cloudAlpha;
//Spill
uniform vec3 spillColor;
uniform float spillAlpha;

const vec3 forestColor = vec3(.00784, .3764, .192);
const vec3 sandColor = vec3(.97, .96, .4);

//You could do the cinematic flyover, or you could do a regular sphere
const bool correctCamera=false;

//THis code has been hard-coded for a radius of 1
//const float radius=1;

const float timeK = 1;

const float PI = 3.14159258;

//-2 = -radius*2
const vec3 origCamera = vec3(0, 0, -2);
//-1.5 = -radius * 1.5
const float pixelPt = -1.0;

//const float PI = 3.14159258;

vec2 center = vec2(u_resolution.x/2, u_resolution.y/2);


// === Utilities
float sqrdMagnitude(vec3 a) {
    return a.x * a.x + a.y * a.y + a.z * a.z;
}
float magnitude(vec3 a) {
    return sqrt(sqrdMagnitude(a));
}
float sqrdMagnitude(vec2 a) {
    return a.x * a.x + a.y * a.y;
}
float magnitude(vec2 a) {
    return sqrt(sqrdMagnitude(a));
}

// Compute the cross product a X b
vec3 crossProduct (vec3 a, vec3 b)
{
    vec3 pOut = vec3(0);
    pOut.x = a.y * b.z - a.z * b.y;
    pOut.y = a.z * b.x - a.x * b.z;
    pOut.z = a.x * b.y - a.y * b.x;
    return pOut;
}

float dotProduct(vec3 a, vec3 b) {
    return a.x * b.x + a.y * b.y + a.z + b.z;
}

vec3 rotateX(vec3 point, float theta) {
    float y = point.y;
    float z = point.z;
    float c = cos(theta);
    float s = sin(theta);
    //x=x
    point.y = y * c - z * s;
    point.z = y * s + z * c;
    return point;
}
vec3 rotateY(vec3 point, float theta) {
    float x = point.x;
    float z = point.z;
    float c = cos(theta);
    float s = sin(theta);
    //y=y
    point.x =  x * c + z * s;
    point.z = -x * s + z * c;
    return point;
}
vec3 rotateZ(vec3 point, float theta) {
    float x = point.x;
    float y = point.y;
    float c = cos(theta);
    float s = sin(theta);
    //z=z
    point.x = x * c - y * s;
    point.y = x * s + y * c;
    return point;
}

// Precision-adjusted variations of https://www.shadertoy.com/view/4djSRW
float hash(float p) {
    p = fract(p * 0.011);
    p *= p + 7.5;
    p *= p + p;
    return fract(p);
}
float hash(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.13);
    p3 += dot(p3, p3.yzx + 3.333);
    return fract((p3.x + p3.y) * p3.z);
}


float random (in vec2 _st) {
    return fract(sin(dot(_st.xy, vec2(23.9898,19.233)))* 12.43);
//    return fract(sin(dot(_st.xy,
//    vec2(12.9898,78.233)))*
//    43758.5453123);
}

float taylorInvSqrt(in float r) { return 1.79284291400159 - 0.85373472095314 * r; }
vec2 taylorInvSqrt(in vec2 r) { return 1.79284291400159 - 0.85373472095314 * r; }
vec3 taylorInvSqrt(in vec3 r) { return 1.79284291400159 - 0.85373472095314 * r; }
vec4 taylorInvSqrt(in vec4 r) { return 1.79284291400159 - 0.85373472095314 * r; }


float mod289(const in float x) { return x - floor(x * (1. / 289.)) * 289.; }
vec2 mod289(const in vec2 x) { return x - floor(x * (1. / 289.)) * 289.; }
vec3 mod289(const in vec3 x) { return x - floor(x * (1. / 289.)) * 289.; }
vec4 mod289(const in vec4 x) { return x - floor(x * (1. / 289.)) * 289.; }

float permute(const in float v) { return mod289(((v * 34.0) + 1.0) * v); }
vec2 permute(const in vec2 v) { return mod289(((v * 34.0) + 1.0) * v); }
vec3 permute(const in vec3 v) { return mod289(((v * 34.0) + 1.0) * v); }
vec4 permute(const in vec4 v) { return mod289(((v * 34.0) + 1.0) * v); }

float noise(in vec2 v) {
    const vec4 C = vec4(0.211324865405187,  // (3.0-sqrt(3.0))/6.0
                        0.366025403784439,  // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626,  // -1.0 + 2.0 * C.x
                        0.024390243902439); // 1.0 / 41.0
    // First corner
    vec2 i  = floor(v + dot(v, C.yy) );
    vec2 x0 = v -   i + dot(i, C.xx);

    // Other corners
    vec2 i1;
    //i1.x = step( x0.y, x0.x ); // x0.x > x0.y ? 1.0 : 0.0
    //i1.y = 1.0 - i1.x;
    i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    // x0 = x0 - 0.0 + 0.0 * C.xx ;
    // x1 = x0 - i1 + 1.0 * C.xx ;
    // x2 = x0 - 1.0 + 2.0 * C.xx ;
    vec4 x12 = x0.xyxy + C.xxzz;
    x12.xy -= i1;

    // Permutations
    i = mod289(i); // Avoid truncation effects in permutation
    vec3 p = permute( permute( i.y + vec3(0.0, i1.y, 1.0 ))
    + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(dot(x0,x0), dot(x12.xy,x12.xy), dot(x12.zw,x12.zw)), 0.0);
    m = m*m ;
    m = m*m ;

    // Gradients: 41 points uniformly over a line, mapped onto a diamond.
    // The ring size 17*17 = 289 is close to a multiple of 41 (41*7 = 287)

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt( a0*a0 + h*h );
    m *= 1.79284291400159 - 0.85373472095314 * ( a0*a0 + h*h );

    // Compute final noise value at P
    vec3 g;
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * x12.xz + h.yz * x12.yw;
    return 130.0 * dot(m, g);
}


float noise(in vec3 v) {
    const vec2  C = vec2(1.0/6.0, 1.0/3.0) ;
    const vec4  D = vec4(0.0, 0.5, 1.0, 2.0);

    // First corner
    vec3 i  = floor(v + dot(v, C.yyy) );
    vec3 x0 =   v - i + dot(i, C.xxx) ;

    // Other corners
    vec3 g = step(x0.yzx, x0.xyz);
    vec3 l = 1.0 - g;
    vec3 i1 = min( g.xyz, l.zxy );
    vec3 i2 = max( g.xyz, l.zxy );

    //   x0 = x0 - 0.0 + 0.0 * C.xxx;
    //   x1 = x0 - i1  + 1.0 * C.xxx;
    //   x2 = x0 - i2  + 2.0 * C.xxx;
    //   x3 = x0 - 1.0 + 3.0 * C.xxx;
    vec3 x1 = x0 - i1 + C.xxx;
    vec3 x2 = x0 - i2 + C.yyy; // 2.0*C.x = 1/3 = C.y
    vec3 x3 = x0 - D.yyy;      // -1.0+3.0*C.x = -0.5 = -D.y

    // Permutations
    i = mod289(i);
    vec4 p = permute( permute( permute(
                i.z + vec4(0.0, i1.z, i2.z, 1.0 ))
            + i.y + vec4(0.0, i1.y, i2.y, 1.0 ))
            + i.x + vec4(0.0, i1.x, i2.x, 1.0 ));

    // Gradients: 7x7 points over a square, mapped onto an octahedron.
    // The ring size 17*17 = 289 is close to a multiple of 49 (49*6 = 294)
    float n_ = 0.142857142857; // 1.0/7.0
    vec3  ns = n_ * D.wyz - D.xzx;

    vec4 j = p - 49.0 * floor(p * ns.z * ns.z);  //  mod(p,7*7)

    vec4 x_ = floor(j * ns.z);
    vec4 y_ = floor(j - 7.0 * x_ );    // mod(j,N)

    vec4 x = x_ *ns.x + ns.yyyy;
    vec4 y = y_ *ns.x + ns.yyyy;
    vec4 h = 1.0 - abs(x) - abs(y);

    vec4 b0 = vec4( x.xy, y.xy );
    vec4 b1 = vec4( x.zw, y.zw );

    //vec4 s0 = vec4(lessThan(b0,0.0))*2.0 - 1.0;
    //vec4 s1 = vec4(lessThan(b1,0.0))*2.0 - 1.0;
    vec4 s0 = floor(b0)*2.0 + 1.0;
    vec4 s1 = floor(b1)*2.0 + 1.0;
    vec4 sh = -step(h, vec4(0.0));

    vec4 a0 = b0.xzyw + s0.xzyw*sh.xxyy ;
    vec4 a1 = b1.xzyw + s1.xzyw*sh.zzww ;

    vec3 p0 = vec3(a0.xy,h.x);
    vec3 p1 = vec3(a0.zw,h.y);
    vec3 p2 = vec3(a1.xy,h.z);
    vec3 p3 = vec3(a1.zw,h.w);

    //Normalise gradients
    vec4 norm = taylorInvSqrt(vec4(dot(p0,p0), dot(p1,p1), dot(p2, p2), dot(p3,p3)));
    p0 *= norm.x;
    p1 *= norm.y;
    p2 *= norm.z;
    p3 *= norm.w;

    // Mix final noise value
    vec4 m = max(0.6 - vec4(dot(x0,x0), dot(x1,x1), dot(x2,x2), dot(x3,x3)), 0.0);
    m = m * m;
    return 42.0 * dot( m*m, vec4( dot(p0,x0), dot(p1,x1),
                                dot(p2,x2), dot(p3,x3) ) );
}

#define NUM_OCTAVES 6


float fbm(vec2 x) {
    float v = 0.0;
    float a = 0.5;
    vec2 shift = vec2(100);
    // Rotate to reduce axial bias
    mat2 rot = mat2(cos(0.5), sin(0.5), -sin(0.5), cos(0.50));
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(x);
        x = rot * x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}


float fbm(vec3 x) {
    float v = 0.0;
    float a = 1./6.;
    vec3 shift = vec3(1);
    for (int i = 0; i < 6; ++i) {
        v += a * noise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

///This must generate noise, but not shift as the damn thing rotates
vec2 latAndLong(vec3 v) {
    v = normalize(v);
    float lat = v.y ;
//    float lat = acos(v.y) /PI*2 -1  ;
    //Cosine of longitude
//    vec3 axis = vec3(0.0,1.0,0.0);
    float lng = atan(v.x/v.z) ;
//    float lng = (v.x*v.z/2 + v.x + v.z) ;
    return 1.5 * vec2( lat,  lng);
}

vec3 getRay(vec2 st, vec3 camera) {
    if (correctCamera) {
        float cameraMagn = magnitude(camera);
        camera = normalize(camera);
        vec3 tangent1 = crossProduct(camera, normalize(vec3(0, 1, 1)));
        tangent1 = normalize(tangent1);
        //Second normal
        const float spread = .75;
        vec3 tangent2 = crossProduct(camera, tangent1);
        tangent2 = normalize(tangent2);
        vec3 ray= spread * tangent1 * (st.x) + spread * tangent2 * (st.y) -camera;

//        vec3 pixelWindow = vec3((st), pixelPt);
//        vec3 ray =  camera  - pixelWindow;
        return -normalize(ray);
    }
    else {
        //This is wrong but looks cool
        //I thought I needed a normal
        vec3 tangent1 = crossProduct(camera, vec3(0, 1, 0));
        //Second normal
        vec3 tangent2 = crossProduct(camera, tangent1);
//        st *= .8;
        return -camera + tangent1 * st.x + tangent2 + st.y;
    }
}
//
//const vec3 shadec = vec3(116./255,97./255,227./255);
//const vec3 shade6 = vec3(36./255,40./255,94.2/255);
//const vec3 shade1 = vec3(3./255, 3./255, 21./255);
//
const vec3 shadec = vec3(116./255,97./255,227./255);
const vec3 shade6 = vec3(36./255,40./255,94.2/255);
const vec3 shade1 = vec3(3./255, 3./255, 21./255);

//Fire variant
//const vec3 shadec = vec3(255./255, 186./255,17./255);
//const vec3 shade6 = vec3(240./255, 156./255,10./255);
//const vec3 shade1 = vec3(31./255,3./255, 3./255);


vec4 starBackground(vec2 st)
{
//    vec2 tVec = vec2(0, -u_time);
//    st/=1.5;
//    float f = noise(5/4 * st + .2 * tVec);
//    f += noise(4 * (st + .1 * tVec));
//    f = sin(f);
//    f = clamp(1-f, 0, 1);
////    f = f * f;
//    vec3 color;
//
//    if (f < .333) {
//        color= mix(vec3(1), shade6, f*3);
//    }
//    else if ( f < .666) {
//        color = mix(shade6, shade1, f*3-1);
//    }
//    else {
//        color= mix(shade1, vec3(0), f*3-2);
//    }
//
//return vec4(color, 1);
//    return vec4(.5 + f * .3, .2 + f * .3, .1 * f, 1);
    //Stars
    float star = noise(1+st*40);
    if (star > .86) {
//            fragColor = vec4(.039, .039,.101,1);
        return vec4(1,1,1,1);
    }
    else if (star > .1) {
         star *= .01;
        return vec4(.039+star*.1, .039+star*.5,.101+star,1);
    }
    else {
         //0xFF0a0a1a
         //10, 10, 26
        return vec4(.039, .039,.101,1);
    }
}

// Original parameters:
//      C = sphere center
//      r = sphere radius
//      P = ray origin
//      w = ray direction
//Hardcoded in:
//     C = (0, 0, 0)
//     r = 1
//     P  = camera
float  intersectSphere( vec3 ray, vec3 camera) {
    float b = -dot(ray, camera);
    // - 1 = - radius**2
    float c = dot(camera, camera) - 1;
    float d = b*b - c;
    if (d < 0.0) { return -3; }
    float dsqrt = sqrt(d);

//TODO: Find out if one of these never happens
    float negHit = b - dsqrt;
    float posHit = b + dsqrt;

    if (negHit<0 || posHit<0) {
        return abs(max(negHit, posHit));
    }
    else {
        // Choose the first positive intersection
        return min(negHit, posHit);
    }
}


#define LAND_OCTAVES 4

float landFreqMod (in vec2 coord) {
    //Coordinates that gracefully handle rotation
//coord = 4.234 * coord;
//vec2 coord = st.xy;
    // Initial values
    float value = .4;
    float amplitud = 1;
//    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < LAND_OCTAVES; i++) {
//        value += amplitud * noise(2*st);
        value += amplitud * noise( 1.25*coord);
        coord = coord * 2.;
        amplitud *= .5;
    }
    return value;
}


void main() {

    //Get earth coordinate from pixel
    vec2 st = 2.0 * FlutterFragCoord().xy/u_resolution.xy - vec2(1);
    //Camera
    vec3 camera;
    if (correctCamera) {
        //Not using "creative" flyover code
        camera = normalize(origCamera);
        camera = rotateY(camera, u_time * .04);
//        camera = rotateY(camera, u_time * timeK * .14);
//        camera = rotateX(camera, u_time * timeK * .02);

        camera = normalize(camera) * 2;
    }
    else {
        //Creates cinematic flyover
        camera = rotateX(origCamera, u_time * timeK * .0125);
    }
    vec3 ray = getRay(st, camera);

    //TODO: Calculate distance without sphere intersection

    float dist = intersectSphere( ray, camera);

    //Check distance
    if (dist < 0) {
        //Offscreen
        fragColor = starBackground(st);
        return;
    }
    vec3 coord = camera + dist * ray;
    coord = normalize(coord);
//    coord = coord;
//    coord =  rotateY( coord, u_time * timeK * 0.2);

    float stepStart = clamp(.45 + (u_time*timeK-4)/16, .40, .55);
         stepStart = .45;

//    float slur = .01;
//    float landness = (landFreqMod(coord)-.333) *5;
    vec2 latLong =  latAndLong(coord);
    float temperature = cos(latLong.x * 2*PI);

    float climateChange = clamp(u_time - 1, 0, 1000) * timeK * .003;
temperature += climateChange;
    float landness = landFreqMod(latLong) + temperature/40;
    float land2 = landFreqMod (latLong + vec2(1.0));
    float land3 = landFreqMod (latLong + (vec2(2.0)));

    float clampedLand = clamp(landness, 0, 1);

    //water
    vec3 color =    vec3(0.004,0.018,0.410);

    //0xff026031
    vec3 colorLand = forestColor;

    vec3 oceanColor;
float waterPollutedness = climateChange/3;
//waterPollutedness=3;
    if (waterPollutedness<1) {
    oceanColor = mix(
        //Good water
        vec3(0.03,0.04,.2),
        //Bad water
        vec3(0.17, .20, .21),
         waterPollutedness
         );
    }
else {

    oceanColor = mix(
        //Bad water
        vec3(0.17, .20, .21),
         //Plastic
         vec3(0.87, 1, 0.69),
         clamp(waterPollutedness-2, 0, 1)
     );
}


//    vec3 q = vec3(0.);
//    q.x = fbm( coord + 0.10*u_time);
//    q.y = fbm( coord + vec3(1.0));
//    q.z = fbm(coord + vec3(1.0));

//    vec3 r = vec3(0.);
//    r.x = fbm(1. *coord + 1.0*q +vec3(1.690,.400, 2.53)+ 1.0*u_time );
//    r.y = fbm( coord + 1*q + vec3(0.740,0.830, 1.26)+ 1.0*u_time);
//    r.z = fbm( coord + 1*q + vec3(0.321,4.217, .12)+ 1.0*u_time);

    const float landthresh = .75;


    float mtn =  fbm(vec2(1.5 * landness,.1) );
    mtn = clamp(-mtn, -1, 1);
    mtn = (mtn) * 2 * 2 ;
    bool frozen =   fbm (latLong) - temperature + mtn/4> .5 ;

//    bool frozen =   fbm (latLong) - temperature * clamp(1-landness*2, 0, 1) + mtn/4> .5 ;

//    bool frozen =   fbm (latLong) - temperature * clamp(1-landness*2, 0, 1)> .5 || mtn > 1;
//bool frozen = latLong.x < -.4 || latLong.x>.4;

    float biome =clamp(land3 * temperature + clamp(landness - .25, 0, 1) * temperature, 0, 1) + land3*land2 + temperature/10 - .6;
    bool concrete = biome - clamp(landness, 0, 1) >1;
    concrete=false;
    //Land
    if (landness>=.333 || frozen) {
    //Pick land color
        //Mountain caps
    if (frozen) {
        if (concrete) {
            //Frozen Concrete
         colorLand = vec3(.5);
        }
        else if (biome < .2) {
        //Forest ice
            colorLand = vec3(1.0, .96, .86);
        }
        else {
            //Sand ice
            colorLand = vec3(1.0);
        }
    }
    else if (biome < .2) {
        colorLand = forestColor;
//    colorLand = vec3(.00784, .3764, .192);
    }
    else if (biome < .8) {
        colorLand = mix(forestColor, sandColor, clamp(biome- .2, 0, 1));
    }
    else if (!concrete) {
        colorLand = mix(
            sandColor,
            //dirt
            vec3(.54, .35, .1),
            clamp(biome-1, 0, 1));
    }
    else {
        //Concrete
        colorLand = vec3(.29, .3, .35);
    }
    }
    //Draw land
    if (landness > .75 || frozen) {
    //Land mtns

   //Above 2 is mtn
   //Below -2 is valley

//    mtn = mtn * mtn;
//    mtn = clamp(mtn, -1, 1);
//    colorLand *= mtn;
    //Screen
    colorLand = 1- (1-colorLand)* clamp(1-mtn + 1, 0,1);
    //Burn
    float valleyBurn = 1-clamp(1 + mtn + 1, 0, 1);
//    colorLand = colorLand * (1-valleyBurn);
colorLand = clamp(colorLand - .3 * valleyBurn, .2, 1);

    //Land texture
    float f =  (landness + sin(21.24* landness * latLong.x) + sin( 12.253 * landness * latLong.y ));
    //Less trees in sand
    f *= clamp(1-biome, 0, 1);
    //Clamp
    f = clamp(f, 0, 1);
    //Microtexture
    f *= fbm((1+clampedLand) * (130 * coord));
    //Clamp again, pushing
    f = clamp(f*5 + 0, 0, 1);

    //Trees
    if (f>0) {
        vec3 mixColor = vec3(1.0);
        if (frozen) {
            //Blue ice
            mixColor = vec3(.5, .5, 1);
        }
        else if (concrete) {
            //McDonalds
            mixColor = vec3(.5, .1, .1);
        }
        else {
            //Trees
            mixColor = vec3(.2, .5, .23);
        }
        //color = colorLand;
            //Texture
            color = mix(colorLand, mixColor, f);
        }
        else {
            color = colorLand;
        }
    }
     else {
         //Undersea shelves
        float f =  fbm(vec2(10 * landness,.1) );
        f = 1-f;
        //Deep ocean
        color = vec3(0, 0, .1);

        float sea1 = sin(landness);
        float sea2 = sin(land2/20);
        float sea3 = sin(land3*100 + land2 * 109 + landness * 218
        //Ripples
        + u_time * 5.128) ;

        float seaMtn =  2 * landness + (  sea3 * sea3 * 20.1) * clamp(sea2, 0, 1);

        //Darken
        seaMtn = clamp( 1 - ((1-seaMtn)*1), 0, 1);
        f = clamp(f * f , 0, 1);
//        color = oceanColor * seaMtn;
        color = mix(color,oceanColor, seaMtn );
        color *= (1-(1-f)*.8);



        //    Spill
//        if (spillAlpha>0) {
//        float spillAmt =   clamp(length(q*3),0.0,1.0);
//            color = mix(color,
//            spillColor,
//            spillAlpha* spillAmt)
//           ;
//        }

        //Half land
        //Radius around land
        if (landness > .61) {
        if (frozen) {
            color = mix(oceanColor, vec3(1.0), .5);
        }
        else {
            color = mix(colorLand, oceanColor, .5);
}
        }
    }
float ccCloudFactor = (clamp(cos(climateChange/10), 0, 1));

    //Clouds
float cloudScale = clamp(landness, 1, 10);
    vec2 cloudPos = 3.34 * cloudScale * vec2 (  latLong.x, .25 * (latLong.y - .152 * u_time));
//
//    float cloudTexture = landFreqMod (.25*latLong * (.1+ccCloudFactor) + vec2( latLong.x*3, -.45826*u_time));
//        cloudTexture = clamp(cloudTexture, 0, 1);
vec2 fineCloudPos =  vec2 ( 7* latLong.x,.1 * (latLong.y) - .45826 * u_time);
    float cloudTexture = landFreqMod (fineCloudPos);
        cloudTexture = clamp(cloudTexture, 0, 1);
//    cloudTexture=1;

    float cloudWeather =   noise(cloudPos);

        float cf =cloudTexture *  cloudWeather;
        

  //Lower is
    cf = clamp(1-cf, .2, 1);
    vec3 scrn = 1 - color;
    scrn *= cf;
    color = 1-scrn;

    fragColor = vec4(color,1.);
}
