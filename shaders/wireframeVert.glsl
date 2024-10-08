#version 400 core

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

layout (location = 0) in float ID;
layout (location = 1) in vec3 position;
layout (location = 2) in vec3 inNormal;

void main()
{
    gl_Position = projection * view * model * vec4(position, 1.0);
}