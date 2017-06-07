if [ "$#" -ne 2 ]; then
    echo "Usage: ./run.sh <input_png_dir>"
fi

rm -rf b_resized
rm -rf b_blank
rm -rf b_combined

python tools/process.py --input_dir $1 --operation resize --output_dir b_resized

python tools/process.py --input_dir b_resized --operation blank --output_dir b_blank

python tools/process.py --input_dir b_blank --b_dir b_resized --operation combine --output_dir b_combined

rm -rf c_test

python pix2pix.py --mode test --output_dir c_test --input_dir b_combined --checkpoint c_train

open c_test/index.html