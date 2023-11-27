#mencoder 'mf://images/spheres*.png' -mf type=png:fps=5 -ovc lavc -lavcopts vcodec=mpeg4 -oac copy -o tissue_1o2.mpg

timestamp=$(date +"%Y%m%d_%H%M%S")
ffmpeg -r 10 -f image2 -s 1920x1080 -i spheres%03d.png -vcodec libx264 -crf 25 -pix_fmt yuv420p "movie_${timestamp}.mp4"



