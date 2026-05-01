#include "helpers.h"
#include <math.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (short int i= 0; i < height; i++)
    {
        for (short int j = 0; j < width; j++)
        {
            int av = image[i][j].rgbtRed + image[i][j].rgbtBlue + image[i][j].rgbtGreen;
            av = round(av/3.0);
            image[i][j].rgbtBlue = image[i][j].rgbtRed = image[i][j].rgbtGreen = av;
        }
    }
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{

    for(short int i = 0; i < height; i++)

        for(short int j = 0; j < width/2; j++)
        {
            RGBTRIPLE a = image[i][j];
            image[i][j] = image[i][width -1 - j];
            image[i][width -1 - j] = a;
        }

    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

        for(short int i = 0; i < height; i++)
    {
        for(short int j = 0; j < width; j++)
        {
            float count = 0;
            short int Red = 0, Blue = 0, Green = 0;
            for(short int x = -1; x < 2; x++)
            {
                for(short int y = -1; y < 2; y++)
                {
                    if((i + x) < 0 || (j + y) < 0 || (i + x) > (height - 1) || (j + y) > (width - 1))
                        continue;

                    Red += image[i + x][j + y].rgbtRed;
                    Blue += image[i + x][j + y].rgbtBlue;
                    Green += image[i + x][j + y].rgbtGreen;
                    count++;
                }
            }

            temp[i][j].rgbtRed = round(Red/count);
            temp[i][j].rgbtBlue = round(Blue/count);
            temp[i][j].rgbtGreen = round(Green/count);
        }
    }

    for(short int i = 0; i < height; i++)

        for(short int j = 0; j < width; j++)
        {
            image[i][j] = temp[i][j];
        }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE temp[height][width];

    int G[3][3] = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0,1}};

    for(short int i = 0; i < height; i++)
    {
        for(short int j = 0; j < width; j++)
        {
            int Redx = 0, Bluex = 0, Greenx = 0, Redy = 0, Bluey = 0, Greeny = 0;

            for(short int x = -1; x < 2; x++)
            {
                for(short int y = -1; y < 2; y++)
                {
                    if((i + x) < 0 || (j + y) < 0 || (i + x) > (height - 1) || (j + y) > (width - 1))
                    {
                        continue;
                    }

                    Redx += (image[i + x][j + y].rgbtRed * G[x + 1][y + 1]);
                    Bluex += (image[i + x][j + y].rgbtBlue * G[x + 1][y + 1]);
                    Greenx += (image[i + x][j + y].rgbtGreen * G[x + 1][y + 1]);

                    Redy += (image[i + x][j + y].rgbtRed * G[y + 1][x + 1]);
                    Bluey += (image[i + x][j + y].rgbtBlue * G[y + 1][x + 1]);
                    Greeny += (image[i + x][j + y].rgbtGreen * G[y + 1][x + 1]);
                }
            }

            short int Red = round(sqrt((Redx * Redx) + (Redy * Redy)));
            short int Blue = round(sqrt((Bluex * Bluex) + (Bluey  * Bluey)));
            short int Green = round(sqrt((Greenx * Greenx) + (Greeny * Greeny)));

            if (Red>255)
                Red = 255;
            if(Blue > 255)
                Blue = 255;
            if(Green >  255)
                Green = 255;

            temp[i][j].rgbtRed = Red;
            temp[i][j].rgbtGreen = Green;
            temp[i][j].rgbtBlue = Blue;
        }
    }

    for(short int i= 0; i < height; i++)

        for(short int j = 0; j < width; j++)
        {
            image[i][j] = temp[i][j];
        }
    return;
}

//Sepia filter
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (short int i = 0; i < height; i++)
    {
        for (short int j = 0; j < width; j++)
        {
            short int sepiaBlue = round(.272 * image[i][j].rgbtRed + .534 * image[i][j].rgbtGreen + .131 * image[i][j].rgbtBlue);
            short int sepiaGreen = round(.349 * image[i][j].rgbtRed + .686 * image[i][j].rgbtGreen + .168 * image[i][j].rgbtBlue);
            short int sepiaRed = round(.393 * image[i][j].rgbtRed + .769 * image[i][j].rgbtGreen + .189 * image[i][j].rgbtBlue);

            image[i][j].rgbtBlue = (sepiaBlue > 255) ? 255 : sepiaBlue;
            image[i][j].rgbtGreen = (sepiaGreen > 255) ? 255 : sepiaGreen;
            image[i][j].rgbtRed = (sepiaRed > 255) ? 255 : sepiaRed;
        }
    }
    return;
}
