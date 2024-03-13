# imgNoiseFilter
VHDL project cleaning salt and pepper noise from a picture in parallel process implementing mergesort algorithm for the median filter

no control unit single file structure
convert raw image to mif files rgb seperated, run in modelsim
set relative path to mif files
running cleaning_lena.vhd will write new filtered raw image data to ram
export ram data to mif file
run mif2raw to return to raw file and see clean image
