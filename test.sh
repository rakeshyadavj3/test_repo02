#!/bin/bash
#to identify the files more than 100 MB
#find -type f -size +100M -exec ls -lh {} \; | awk '{print $5, $9}' | xargs tar -rvf arch.tar.gz_$(date '+%Y-%m%d_%H-%M-%S')
find -type f -size +100M -exec tar -rvf arc.tar.gz_$(date '+%Y-%m-%d_%H-%M-%S') {} \;
mv arc.tar.gz_* /mnt/c/Users/Dell/Desktop/CG/archive/arc.tar.gz_$(date '+%Y-%m-%d_%H-%M-%S')
find -type f -size +100M -exec rm -r "{}" \;
#mv arch.tar.gz_$(date '+%Y-%m%d_%H-%M-%S') /mnt/c/Users/Dell/Desktop/CG/archive/archive_$(date '+%Y-%m-%d_%H-%M-%S')
