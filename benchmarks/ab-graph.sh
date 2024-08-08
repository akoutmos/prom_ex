#!/bin/bash
#
# Helper script for apachebench to automate the plotting of test results using
# gnuplot.
#
# This script will plot apachebench results using gnuplot, and store test results
# in $PWD/results/website/date/. The script will create the plot files for gnuplot
# using the templates in the templates directory. It will also save apachebench
# output in a file called summary.txt.
#
# Author: Juan Luis Baptiste <juan _at_ juanbaptiste _dot_ tech>
#

. ./functions.sh


usage()
{
cat << EOF
Helper script for Apache Bench that also plots the results.

Usage: $0 OPTIONS

OPTIONS:
-c    Concurrent connections  (default: 1)
-k    Enable keepalive        (default: no)
-E    Extra parameters
-n    Number of requests      (default: 1)
-u    Url to test             (mandatory)
-h    Print help.
-V    Debug mode.

This script will plot apachebench results using gnuplot, and store test results
in $PWD/results/website/date/. The script will create the plot files for gnuplot
using the templates in the templates directory. It will also save apachebench output in a file
called summary.txt

EOF
}

# trap ctrl-c and call ctrl_c()
trap ctrl_c INT

function ctrl_c() {
        echo "Ctrl C pressed, removing partial test results..."
        rm -fr ${RESULTS_PATH}
        exit 1
}


while getopts c:kE:n:u:hV option
do
  case "${option}"
  in
    c) CONCURRENCY="${OPTARG}"
       ;;
    k) KEEPALIVE=" -k "
       ;;
    E) EXTRA_ARGS="${OPTARG}"
       ;;
    n) NUM_REQUESTS="${OPTARG}"
       ;;
    u) URL="${OPTARG}"
       ;;
    h) usage
       exit
       ;;
    V) set -x
       ;;
    ?) usage
       exit
       ;;
  esac
done

#Parameter validation
if [ $# -lt 1 ] || [ "${URL}" == "" ]; then
  usage
  exit 1
fi

# Prepare ab parameters
HOSTNAME="$(extract_hostname ${URL})"
RESULTS_PATH="${PWD}/results/${HOSTNAME}/${TEST_DATE}"
CSV_RESULTS_FILE="${RESULTS_PATH}/percentages.csv"
PLOT_FILE="${RESULTS_PATH}/values.tsv"
AB_OUTPUT_FILE="${RESULTS_PATH}/summary.txt"

# Create results dir
mkdir -p ${RESULTS_PATH}

echo -e "${0} - version ${VERSION}\n"


if [ "${CONCURRENCY}" == "" ]; then
  echo "No concurrency set, using default value of ${DEFAULT_CONCURRENCY} simultaneous clients"
  CONCURRENCY=${DEFAULT_CONCURRENCY}
fi

if [ "${NUM_REQUESTS}" == "" ]; then
  echo "No number of requests set, using default value of ${DEFAULT_NUM_REQUESTS} requests"
  NUM_REQUESTS=${DEFAULT_NUM_REQUESTS}
fi

# Run test
AB_COMMAND="${AB_BIN} ${KEEPALIVE} -c ${CONCURRENCY} -n ${NUM_REQUESTS} -e ${CSV_RESULTS_FILE} -g ${PLOT_FILE} ${EXTRA_ARGS} ${URL}/ "
echo -e "\n${AB_COMMAND}\n"

out="$(${AB_COMMAND})"

if [ $? -gt 0 ]; then
  echo -e "There was an error running the test:\n"
  echo -e ${out}
  exit 1
fi

# Store test summary results to summary.txt
echo -e "${out}" > ${AB_OUTPUT_FILE}
echo -e "\n${out}\n\n"

##### Plot results
# Render values template
cd ${RESULTS_PATH} || exit
echo -e "Plotting values results..."

# Define plot lines
PLOT_LINES="\"${PLOT_FILE}\" using 9 smooth sbezier with lines title \"${HOSTNAME}\""
IMAGE_FILE="$(basename ${PLOT_FILE})"
rendered_values_template=$(render_template ${PLOT_TEMPLATE_FILE} "${RESULTS_PATH}/values.p")

# Plot results
GNUPLOT_COMMAND="${GNUPLOT_BIN} ${rendered_values_template}"
echo -e "\n${GNUPLOT_COMMAND}\n"
${GNUPLOT_COMMAND}
echo -e "Done."

# Render percentages template
echo -e "Plotting percentages results..."
# Remove header line
sed 1d ${CSV_RESULTS_FILE} > ${CSV_RESULTS_FILE}.fixed
PLOT_LINES="\"${CSV_RESULTS_FILE}.fixed\"  with lines title \"${HOSTNAME}\""
IMAGE_FILE="$(basename ${CSV_RESULTS_FILE})"
rendered_percentages_template=$(render_template ${CSV_TEMPLATE_FILE} "${RESULTS_PATH}/percentages.p")

# Plot results
GNUPLOT_COMMAND="${GNUPLOT_BIN} ${rendered_percentages_template}"
echo -e "\n${GNUPLOT_COMMAND}\n"
${GNUPLOT_COMMAND}
echo -e "Done."

cd .. || exit
