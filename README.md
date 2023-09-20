# Image Processing App

Program ini adalah sebuah program yang dapat melakukan beberapa fitur image processing, diantaranya : 
- Show Histogram
- Image Brightening
- Negative to Positive Image (& Reverse)
- Log Transformation
- Power Transformation
- Contrast Stretching
- Histogram Equalization
- Histogram Specification

Untuk memulai, sudah disediakan beberapa citra yang dapat digunakan untuk tes fitur. Citra - citra tersebut terletak pada folder `images`
## Dependencies
- Matlab R2023b

## Installation

Aplikasi ini dapat diinstalasi melalui fitur instalasi aplikasi dari MATLAB , pastikan sudah memiliki MATLAB dan dapat buka (double click) `Image_Processing.mlappinstall`. Jika tidak memiliki MATLAB dapat menggunakan file `App Installer` yang disediakan dalam folder Installer. Installer ini akan melakukan instalasi runtime MATLAB yang sizenya lumayan besar.

Apabila melalui git clone :
1. Git clone repo ini
2. Buka repo pada aplikasi MATLAB, masuk ke folder `main`
3. Run `main_gui.mlapp` yang ada dalam folder `main`
4. Gunakan aplikasi

## Usage
- Gunakan drop down untuk memilih fitur yang ingin digunakan
- Masukan input - input yang dibutuhkan (beberapa fitur membutuhkan input lebih lanjut, seperti variabel a dan b untuk Image Brightening)
- Tekan tombol Go untuk memulai proses
- Tekan tombol download pada panel tengah apabila ingin melakukan download hasil
