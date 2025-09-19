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

//Spill
uniform vec3 spillColor;

uniform vec3 colorLand;

//THis code has been hard-coded for a radius of 1
//const float radius=1;

const float timeK = 1;

const float PI = 3.14159258;

//-2 = -radius*2
const vec3 camera = vec3(0, 0, -2);
//-1.5 = -radius * 1.5
const float pixelPt = -1.0;

//const float PI = 3.14159258;


#define NUM_OCTAVES 6

#define OCTAVES 3

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
    float x = point.x;
    float z = point.z;
    float c = cos(theta);
    float s = sin(theta);
    point.x = x * c + z * s;
    point.z = - x * s - z * c;
    return point;
}
vec3 rotateY(vec3 point, float theta) {
    float y = point.y;
    float z = point.z;
    float c = cos(theta);
    float s = sin(theta);
    point.y = y * c + z * s;
    point.z =-y * s + z * c;
    return point;
}
vec3 rotateZ(vec3 point, float theta) {
    float x = point.x;
    float y = point.y;
    float c = cos(theta);
    float s = sin(theta);
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


float noise(vec2 x) {
    vec2 i = floor(x);
    vec2 f = fract(x);

    // Four corners in 2D of a tile
    float a = hash(i);
    float b = hash(i + vec2(1.0, 0.0));
    float c = hash(i + vec2(0.0, 1.0));
    float d = hash(i + vec2(1.0, 1.0));

    // Simple 2D lerp using smoothstep envelope between the values.
    // return vec3(mix(mix(a, b, smoothstep(0.0, 1.0, f.x)),
    //			mix(c, d, smoothstep(0.0, 1.0, f.x)),
    //			smoothstep(0.0, 1.0, f.y)));

    // Same code, with the clamps in smoothstep and common subexpressions
    // optimized away.
    vec2 u = f * f * (3.0 - 2.0 * f);
    return mix(a, b, u.x) + (c - a) * u.y * (1.0 - u.x) + (d - b) * u.x * u.y;
}

float noise(vec3 x) {
    const vec3 step = vec3(110, 241, 171);

    vec3 i = floor(x);
    vec3 f = fract(x);

    // For performance, compute the base input to a 1D hash from the integer part of the argument and the
    // incremental change to the 1D based on the 3D -> 1D wrapping
    float n = dot(i, step);

    vec3 u = f * f * (3.0 - 2.0 * f);
    return mix(mix(mix( hash(n + dot(step, vec3(0, 0, 0))), hash(n + dot(step, vec3(1, 0, 0))), u.x),
    mix( hash(n + dot(step, vec3(0, 1, 0))), hash(n + dot(step, vec3(1, 1, 0))), u.x), u.y),
    mix(mix( hash(n + dot(step, vec3(0, 0, 1))), hash(n + dot(step, vec3(1, 0, 1))), u.x),
    mix( hash(n + dot(step, vec3(0, 1, 1))), hash(n + dot(step, vec3(1, 1, 1))), u.x), u.y), u.z);
}




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
    float a = 0.5;
    vec3 shift = vec3(100);
    for (int i = 0; i < NUM_OCTAVES; ++i) {
        v += a * noise(x);
        x = x * 2.0 + shift;
        a *= 0.5;
    }
    return v;
}

///This must generate noise, but not shift as the damn thing rotates
vec2 latAndLong(vec3 v) {
//return vec2(1);
    //Calculate the polar coordinates
    //Use that as input to noise function
    float lat = v.y;
    //Cosine of longitude
    vec3 axis = vec3(0.0,1.0,0.0);
    //TODO: Check if necessary

    v = normalize(v);

    //tan(beta) = sin(beta) / cos(beta) == ((Va x Vb) . Vn) / (Va . Vb)
    float cos = dotProduct(v, axis);
    float sine = sin(acos(cos));

    //Sine so it is unique across the circle, but wraps

//    float sine = magnitude(v.xz);
    vec2 ret = vec2( 20*lat,  100* sine);
    return ret;
}


float landFreqMod (in vec3 st) {
    //Coordinates that gracefully handle rotation
//    vec2 coord = latAndLong(st);
//vec2 coord = st.xy;
    // Initial values
    float value = 0.0;
    float amplitud = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitud * noise(5*st);
        st *= 2.;
        amplitud *= .5;
    }
    return value;
}

//float fbm(vec3 x) {
//    return 0;
//}


vec3 getRay(vec2 st) {
    vec3 pixelWindow = vec3((st), pixelPt);
    vec3 ray =  camera - pixelWindow;
    return normalize(ray);
}
float intersect(vec3 dir)
{
    // Analytic solution
    vec3 L = camera;
    float a = dotProduct(dir, dir);
    float b = 2 * dotProduct(dir, L);
    // - 1 = -radius * radius
    float c = dotProduct(L, L) - 1;

    float t0, t1; // Solutions for t if the ray intersects

    //Quadratic {
    float discr = b * b - 4 * a * c;
    //Miss
    if (discr < 0) return -1;
    else if (discr == 0)
    t0 = t1 = -0.5 * b / a;
    else {
        float sqDiscr = sqrt(discr);
        float q = (b > 0) ?
        -0.5 * (b + sqDiscr) :
        -0.5 * (b - sqDiscr);
        t0 = q / a;
        t1 = c / q;
    }
    // }

    if (t0 > t1)
    {
        //If highest is negative, it counts as a miss
        return t0;
    }
    else {
        return t1;
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
float  intersectSphere( vec3 ray) {
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

void main() {
    //Get earth coordinate from pixel
    vec2 st = 2.0 * FlutterFragCoord().xy/u_resolution.xy - vec2(1);
    vec3 ray = getRay(st);
    //    float dist = -intersect(ray);
    float dist = intersectSphere( ray);

    if (dist < 0) {
        //Offscreen
        //Stars
        float star = noise(1+st*40);
        if (star > .98) {
//            fragColor = vec4(.039, .039,.101,1);
            fragColor = vec4(1,1,1,1);
        }
        else if (star > .1) {
             star *= .01;
            fragColor = vec4(.039+star*.1, .039+star*.5,.101+star,1);
        }
        else {
             //0xFF0a0a1a
             //10, 10, 26
            fragColor = vec4(.039, .039,.101,1);
        }
//            fragColor = vec4(.039, .039,.101,1);

        return;
    }
    vec3 coord = camera + dist * ray;
//    coord= rotateX(coord, u_time/20.0);

    float stepStart = clamp(.45 + (u_time*timeK-4)/16, .40, .55);
         stepStart = .45;

    float slur = .01;
//    float landness = smoothstep(stepStart, stepStart+slur, landFreqMod(landSt * 7.0));
    float landness = clamp((landFreqMod(coord)-.333) *5, 0, 1);

//    vec3 color = yesterdaysSpill;
vec3 color = vec3(0.004,0.018,0.410);
    vec3 q = vec3(0.);
    q.x = fbm( coord + 0.10*u_time);
    q.y = fbm( coord + vec3(1.0));
    q.z = fbm(coord + vec3(1.0));

    vec3 r = vec3(0.);

    r.x = fbm(1. *coord + 1.0*q +vec3(1.690,.400, 2.53)+ 1.0*u_time );
    r.y = fbm( coord + 1*q + vec3(0.740,0.830, 1.26)+ 1.0*u_time);
    r.z = fbm( coord + 1*q + vec3(0.321,4.217, .12)+ 1.0*u_time);


    float f = fbm(coord+r);

//    Spill
    color = mix(color,
    //    vec3(1, 0, 0),
    spillColor,
    clamp(length(q),0.0,1.0));

    //Water color baked in
    color = mix(color, vec3(0.024,0.118,0.410),(f*f*f+.6*f*f+.5*f) );


    //Land


    if (landness > .333) {
//    color = mix(color, colorLand, landness);
        color = rotateY(color, PI/2 * landness);
    }
//    Clouds
        color = mix(color,
                    cloudColor,
                    clamp(length(r.x) * 3 - 1.5,0.0,.9));


    fragColor = vec4(color,1.);
}

/*
//DEBUG
void main() {
    //Orangish
    fragColor = vec4(1, .7, .2, 1);
    return;
}
*/