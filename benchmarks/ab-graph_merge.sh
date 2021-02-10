#!/bin/bash
#
# Script to merge several apachebench-grpahs test results pltotted into a single
# images using gnuplot.
#
# This script will  merge the test results and percentile stats for a list of
# reports created by apachebench-graphs. List the reports as parameters to the
# script and a new report will be created with the merged results.
#
# Author: Juan Luis Baptiste <juan _at_ juanbaptiste _dot_ tech>
#

. ./functions.sh

# Create results dir
RESULTS_PATH="${PWD}/results/${TEST_DATE}/merged_results/"
mkdir -p ${RESULTS_PATH}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "Ctrl C pressed, removing partial test results..."
        rm -fr ${RESULTS_PATH}
        exit 1
}


#Parameter validation
if [ $# -lt 2 ]; then
  echo -e "\nYou need to at least set two reports.\n"
  exit 1
fi

# Generate merged results plot lines
n=0
while (( "$#" )); do
  plot_values_file="${1}/values.tsv"
  plot_percentages_file="${1}/percentages.csv.fixed"
  hostname="$(basename "`dirname ${1}`")"
  date="$(basename ${1})"
  if [[ ${n} -lt $# ]]; then
    comma=","
  else
    comma=""
  fi
  PLOT_VALUES_LINES+="\"${plot_values_file}\" using 9 smooth sbezier with lines title \"${hostname} - ${date}\"${comma}"
  PLOT_PERCENTAGES_LINES+="\"${plot_percentages_file}\" with lines title \"${hostname} - ${date}\"${comma}"

  n+=1
  shift

done

echo -e "${0} - version ${VERSION}\n"

##### Plot results
# Render values template
cd ${RESULTS_PATH} || exit
echo -e "Plotting merged results..."

IMAGE_FILE="merged_values"
rendered_values_template=$(render_template ${MERGE_VALUES_TEMPLATE_FILE} "${RESULTS_PATH}/values.p")

# Plot results
GNUPLOT_COMMAND="${GNUPLOT_BIN} ${rendered_values_template}"
echo -e "\n${GNUPLOT_COMMAND}\n"
${GNUPLOT_COMMAND}
echo -e "Done."

IMAGE_FILE="merged_percentages"
rendered_percentages_template=$(render_template ${MERGE_PERCENTAGES_TEMPLATE_FILE} "${RESULTS_PATH}/percentages.p")

# Plot results
GNUPLOT_COMMAND="${GNUPLOT_BIN} ${rendered_percentages_template}"
echo -e "\n${GNUPLOT_COMMAND}\n"
${GNUPLOT_COMMAND}
echo -e "Done."

cd .. || exit
