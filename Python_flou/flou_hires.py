# -*- coding:UTF-8 -*-
import numpy as np
import time
import matplotlib.pyplot as plt #to plot things
import matplotlib.image as mpimg # to load images

def flou_non_opti(img):
    """
    cette fonction est plus lente que la fonction originale.
    Elle accède 3 fois à la valeur img[i,j] alors que 1 fois suffit.
    Chaque pixel a besoin de 11 lectures pour être traité au lieu de 9, ici.
    """
    taille = img.shape
    
    taille_kernel = 1;
    
    for i in range(1,taille[0]-1):
        for j in range(1,taille[1]-1):
            tmp = img[i,j]
            for ii in range(-taille_kernel,taille_kernel+1):
                for jj in range(-taille_kernel,taille_kernel+1):
                    img[i,j] += img[i+ii,j+jj]
            img[i,j] = (img[i,j] - tmp)/9
            
    return (img)


def flou(img):
    taille = img.shape
    # parcourt l'image et fait la moyenne des pixels avoisinants
    for i in range(1,taille[0]-1):
        for j in range(1,taille[1]-1):
            tmp = 0
            for ii in range(-1,2):
                for jj in range(-1,2):
                    tmp += img[i+ii,j+jj]
            img[i,j] = (tmp)/(9)
            
    return (img)

def flou_adapt(img, taille_kernel):
    taille = img.shape
    
    # parcourt l'image et fait la moyenne des pixels avoisinants
    for i in range(1,taille[0]-taille_kernel):
        for j in range(1,taille[1]-taille_kernel):
            tmp = 0
            for ii in range(-taille_kernel,taille_kernel+1):
                for jj in range(-taille_kernel,taille_kernel+1):
                    tmp += img[i+ii,j+jj]
            img[i,j] = (tmp)/((taille_kernel*2+1)*(taille_kernel*2+1))
            
    return (img)


def applique_flou(fichier_image):
    image = mpimg.imread(fichier_image)
    
    # passer l'image en niveaux de gris, et en entiers (int)
    image = (image[:,:,0] / 3) + (image[:,:,1] / 3) + (image[:,:,2] / 3)
    image = image.astype(int)
    
    # faire une copie. Permet d'afficher l'une et de modifier l'autre
    image_orig = np.copy(image)
    
    #chronométrer l'application du flou
    print "Application du flou"
    a = time.clock()
    image_floue = flou(image)
    b = time.clock()
    print b-a
    
    #affiche les deux images dans une fenêtre
    fnames = [image_orig, image_floue]
    
    fig = plt.figure()
    for i,fname in enumerate(fnames):
        fig.add_subplot(len(fnames), 1, i+1)
        plt.imshow(fname, cmap='gray')
    plt.show()

#LANCER
applique_flou('tearsofsteel.jpg')



