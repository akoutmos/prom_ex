# output as png image
	set terminal png size 1024,768 crop

	# save file to "benchmark.png"
	set output \"${IMAGE_FILE}.png\"

	# graph a title
	set title \"# Requests: ${NUM_REQUESTS} | Concurrency: ${CONCURRENCY} - ${HOSTNAME}\"

	# nicer aspect ratio for image size
	set size 1,0.7

	# y-axis grid
	set grid y

	# x-axis label
	set xlabel \"Percentile of Users\"

	# y-axis label
	set ylabel \"Response time \(ms\)\"

  set pointsize 1

	set datafile separator \",\"

  plot ${PLOT_LINES}
