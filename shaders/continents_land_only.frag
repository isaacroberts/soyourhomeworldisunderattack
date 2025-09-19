// Author @kyndinfo - 2016
// http://www.kynd.info
// Title: Map(flattend fBM)
#version 460 core

#include <flutter/runtime_effect.glsl>
precision mediump float;

//Return value
out vec4 fragColor;

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

uniform vec3 colorLand;



float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

// Based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define OCTAVES 6
float landFreqMod (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitud = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitud * noise(st);
        st *= 2.;
        amplitud *= .5;
    }
    return value;
}

void main() {
    vec2 st = FlutterFragCoord().xy / u_resolution.xy;
    st.x *= u_resolution.x / u_resolution.y;
    float stepStart = clamp(.45 + u_time, .45, .7);
    float slur = .01;
    float v = smoothstep(stepStart, stepStart+slur, landFreqMod(st * 10.0));
    fragColor = vec4(colorLand, v);
}