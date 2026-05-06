using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawTexture : MonoBehaviour
{
    public Texture textureToDisplay;
    public Rect screenRect = new Rect(10, 10, 150, 150);

    // OnGUI es el modo tradicional para dibujar texturas inmediatas
    void OnGUI()
    {
        if (textureToDisplay != null)
        {
            // Dibuja la textura en las coordenadas de pantalla definidas
            Graphics.DrawTexture(screenRect, textureToDisplay);
        }
    }
}
