#version 400 core

uniform vec3 meshColor;
uniform bool renderIDMode = false;

uniform int selectedID = -1;//-1 maps to no object selected.
uniform vec3 selectedColorChange;

struct DirectionalLight
{
   vec3 direction;
   vec3 ambient;
   vec3 diffuse;
};

uniform DirectionalLight directionalLight;

in vec3 normal;
flat in uint ID;//flat prevents interpolation, every fragment gets the same ID

out vec4 outputColor;

void main()
{
   if (!renderIDMode)
   {
      vec3 ambient = directionalLight.ambient * meshColor;

      //Diffuse lighting
      vec3 lightDir = normalize(-directionalLight.direction);//Specified as from source to origin, reverse so dot product is positive
      float diffuseCoef = max(dot(lightDir, normal), 0.0);
      vec3 diffuse = diffuseCoef * directionalLight.diffuse * meshColor;

      outputColor = vec4(ambient + diffuse, 1.0);

      //Highlight selected object
      if (selectedID == ID)
      {
         outputColor = outputColor + vec4(selectedColorChange, 1.0);
      }
   }
   else
   {
      float r = ((ID & 0x000000FF) >> 0)/255.0;
      float g = ((ID & 0x0000FF00) >>  8)/255.0;
      float b = ((ID & 0x00FF0000) >> 16)/255.0;
      outputColor = vec4(r, g, b, 1.0);
   }
}