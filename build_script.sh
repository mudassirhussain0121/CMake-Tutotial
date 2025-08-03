mkdir build
cd build
cmake .. -G Ninja
cmake --build .
cd Windows64/Debug # Application binary/image is created in this directory.
./CMAKE_LEARNING.exe
# Prevent terminal from closing
read -p "Press Enter to exit..."