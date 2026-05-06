using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DrawMesh : MonoBehaviour
{
    public Mesh meshToDraw;
        public Material materialToUse;
        public Vector3 position;
        public Vector3 rotation;
    
        void Update()
        {
            // Creamos la matriz TRS: Translation, Rotation, Scale
            Matrix4x4 matrix = Matrix4x4.TRS(
                position, 
                Quaternion.Euler(rotation), 
                Vector3.one
            );
    
            // Se debe llamar en cada frame dentro de Update o LateUpdate
            Graphics.DrawMesh(meshToDraw, matrix, materialToUse, 0);
        }
}
