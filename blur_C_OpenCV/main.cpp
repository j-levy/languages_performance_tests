#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <time.h>

using namespace cv;

void flou(Mat *img)
{
    /* Applique un flou sur l'image
    Parcourt les pixels un à un
    Pour chaque pixel, convolue avec un noyau 3x3 de coefficients
    [1 1 1
     1 1 1
     1 1 1]
    */


    /*
    // Noyau de convolution, pas utilisé
    const int kernel[3][3]=
    {
        {-1, -1, -1},
        {0,0,0},
        {1, 1, 1}
    };
    */


    for (int i = 1; i < img->rows; i++)
    {
        for (int j = 1; j < img->cols; j++)
        {
            // variable temporaire pour récupérer les valeurs des pixels aux alentours.
            // Taille plus grande (int16) pour sommer des int8 dedans (éviter l'overflow)
            int tmp = 0;

            for (int ii = -1; ii < 2; ii++)
            {
                for (int jj = -1; jj < 2; jj++)
                {
                    //tmp += (img->at<uint8_t>(i + ii, j + jj)) * kernel[1+ii][1+jj];
                     tmp += img->at<uint8_t>(i + ii, j + jj);
                }
            }
            // assignement avec moyenne.
            img->at<uint8_t>(i,j) = tmp / 9;
        }
    }
}

int main(int argc, char *argv[])
{
    // on lit l'image en niveaux de gris
    Mat img = imread("tearsofsteel_low.jpg", CV_LOAD_IMAGE_GRAYSCALE);
    // on vérifie que l'image a bien été lue.
    if(img.empty())
       return -1;

    // affichage de l'image d'origine dans une première fenêtre.
    namedWindow( "tears of steel", CV_WINDOW_FREERATIO );
    imshow("tears of steel", img);

    clock_t startTime, endTime;
    double elapsed;

    // lancer le flou, chronométrer le temps pris
    startTime = clock();                                  /* Lancement de la mesure */
    flou(&img);
    endTime = clock();                                    /* Arrêt de la mesure     */

    elapsed = ((double)endTime - startTime) / CLOCKS_PER_SEC; /* Conversion en secondes  */
    fprintf(stderr, "%.9f", elapsed);


    // afficher la nouvelle image dans une nouvelle fenêtre
    namedWindow("tears of steel 2", CV_WINDOW_FREERATIO);
    imshow("tears of steel 2", img);


    waitKey(0);
    return 0;
}



